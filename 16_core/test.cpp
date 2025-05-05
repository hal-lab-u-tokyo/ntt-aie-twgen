//===- test.cpp -------------------------------------------------*- C++ -*-===//
//
// This file is licensed under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// Copyright (C) 2023, Advanced Micro Devices, Inc.
//
//===----------------------------------------------------------------------===//

#include <cstdint>
#include <fstream>
#include <iostream>
#include <sstream>
#include <bitset>


#include "test_utils.h"
#include "xrt/xrt_bo.h"

#ifndef DATATYPES_USING_DEFINED
#define DATATYPES_USING_DEFINED
using DATATYPE = std::int32_t; // Configure this to match your buffer data type
#endif


void change_binary(int32_t x, int32_t *ls);
void NTT(int32_t *a, int32_t n, int32_t q, int32_t w,int32_t p);
void bit_reverse(int32_t *ls, int32_t n, int32_t p);
void FNTT(int32_t *a, int32_t n, int32_t q, int32_t w);
void change_order(int32_t *a,int32_t N);
void bit_reverse_new(int32_t *ls, int32_t n,int32_t m);
void bit_reverse_new_modoshi(int32_t *ls, int32_t n,int32_t m);

int32_t calc_mod(int32_t a, int32_t q);
int32_t calc_mod_64(int64_t a, int32_t q);


const int32_t col_num_log = 2;
const int32_t col_num = 1 << col_num_log;
const int32_t raw_num_log = 2;
const int32_t raw_num = 1 << raw_num_log;
const int32_t core_num_log = col_num_log + raw_num_log;
const int32_t core_num = col_num * raw_num;
const int32_t all_size_log = 16;
const int32_t factor_single_size = all_size_log;
const int32_t ntt_size_log = all_size_log;
const int32_t all_size = 1 << all_size_log;
const int32_t col_size = 1 << (all_size_log - col_num);
const int32_t ntt_size = 1 << ntt_size_log;
const int32_t ntt_num_log = all_size_log - ntt_size_log;
const int32_t ntt_num = 1 << ntt_num_log;



const int32_t modulo_q =65537;
// const int32_t modulo_q =12289;
const int32_t r =3;


namespace po = boost::program_options;


int main(int argc, const char *argv[]) {
  int32_t calc_temp = (modulo_q-1)/(ntt_size);
  std::cout << "calc_temp : " << calc_temp << "\n";
  int32_t calc_temp_2 = 1;

  for (int j=0;j<calc_temp;j++){
    // calc_temp_2 = calc_temp_2*r % modulo_q;
    uint64_t ttt = calc_temp_2*r;
    ttt = ttt % modulo_q;
    calc_temp_2 = ttt;
  }
  int32_t w_ori = calc_temp_2;

  std::cout << "====================\n";
  std::cout << "w_ori : " << w_ori << "\n";



  // Program arguments parsing
  po::options_description desc("Allowed options");
  po::variables_map vm;
  test_utils::add_default_options(desc);

  test_utils::parse_options(argc, argv, desc, vm);
  int verbosity = vm["verbosity"].as<int>();
  int do_verify = vm["verify"].as<bool>();
  int n_iterations = vm["iters"].as<int>();
  int n_warmup_iterations = vm["warmup"].as<int>();
  int trace_size = vm["trace_sz"].as<int>();

  constexpr bool VERIFY = true;
  constexpr int IN_SIZE = all_size;
  std::cout << "IN_SIZE : " << IN_SIZE << "\n";
  constexpr int IN_FACTOR_SIZE = (factor_single_size)*core_num;
  std::cout << "IN_SIZE_factor : " << IN_FACTOR_SIZE << "\n";
  constexpr int OUT_SIZE = IN_SIZE;
  int OUT_SIZE_bit = IN_SIZE*sizeof(DATATYPE)+trace_size;


  // Load instruction sequence
  std::vector<uint32_t> instr_v =
      test_utils::load_instr_sequence(vm["instr"].as<std::string>());

  if (verbosity >= 1)
    std::cout << "Sequence instr count: " << instr_v.size() << "\n";

  // Start the XRT context and load the kernel
  xrt::device device;
  xrt::kernel kernel;

  test_utils::init_xrt_load_kernel(device, kernel, verbosity,
                                   vm["xclbin"].as<std::string>(),
                                   vm["kernel"].as<std::string>());                       

  // set up the buffer objects
  auto bo_instr = xrt::bo(device, instr_v.size() * sizeof(int),
                          XCL_BO_FLAGS_CACHEABLE, kernel.group_id(1));
  auto bo_inA = xrt::bo(device, IN_SIZE * sizeof(DATATYPE),
                        XRT_BO_FLAGS_HOST_ONLY, kernel.group_id(3));

  auto bo_in_factor = xrt::bo(device, IN_FACTOR_SIZE * sizeof(DATATYPE),
                        XRT_BO_FLAGS_HOST_ONLY, kernel.group_id(4));

  auto bo_outE = xrt::bo(device, OUT_SIZE_bit,
                         XRT_BO_FLAGS_HOST_ONLY, kernel.group_id(5));

  if (verbosity >= 1)
    std::cout << "Writing data into buffer objects.\n";
  

  // Copy instruction stream to xrt buffer object
  void *bufInstr = bo_instr.map<void *>();
  memcpy(bufInstr, instr_v.data(), instr_v.size() * sizeof(int));

  // Initialize buffer bo_inA
  int32_t *bufInA = bo_inA.map<int32_t *>();
  for (int32_t i = 0; i < IN_SIZE; i++){
      bufInA[i] = i;
  }
  int32_t *bufInA_copy = new int32_t[IN_SIZE]; // 新しいメモリを確保
  for (int i = 0; i < IN_SIZE; i++) {
      bufInA_copy[i] = bufInA[i];
  }
  int32_t *bufInA_FNTT = new int32_t[IN_SIZE]; // 新しいメモリを確保
  for (int i = 0; i < IN_SIZE; i++) {
      bufInA_FNTT[i] = bufInA[i];
  }

  bit_reverse(bufInA_FNTT,all_size_log,1);
  bit_reverse_new(bufInA,all_size_log,core_num_log);


  int32_t *bufInFactor = bo_in_factor.map<int32_t *>();
  for(int core=0;core<core_num;core++){
    for (int32_t i = 0; i < factor_single_size; i++){
      int32_t w_temp = 1;
      int32_t w_index = 1 << (i);
      for(int j=0;j<w_index;j++){
        w_temp = (w_temp * w_ori) % modulo_q;
        if(w_temp<0){
          w_temp += modulo_q + 1;
        }
      }
      bufInFactor[i+factor_single_size*core] = w_temp;
      std::cout << "i : " << i <<  " , w(" << w_index << ") : " << w_temp << "\n";
    } 
  }

  


  // Zero out buffer bo_outC
  DATATYPE *bufOutE = bo_outE.map<DATATYPE *>();
  memset(bufOutE, 0, OUT_SIZE * sizeof(DATATYPE));


  // sync host to device memories
  bo_instr.sync(XCL_BO_SYNC_BO_TO_DEVICE);
  bo_inA.sync(XCL_BO_SYNC_BO_TO_DEVICE);   
  bo_in_factor.sync(XCL_BO_SYNC_BO_TO_DEVICE);     
  bo_outE.sync(XCL_BO_SYNC_BO_TO_DEVICE);

  // ------------------------------------------------------
  // Initialize run configs
  // ------------------------------------------------------
  unsigned num_iter = n_iterations + n_warmup_iterations;
  float npu_time_total = 0;
  float npu_time_min = 9999999;
  float npu_time_max = 0;

  int errors = 0;


  // ------------------------------------------------------
  // Main run loop
  // ------------------------------------------------------
  for (unsigned iter = 0; iter < num_iter; iter++) {

    // Run kernel
    if (verbosity >= 1)
      std::cout << "Running Kernel.\n";
    auto start = std::chrono::high_resolution_clock::now();
    unsigned int opcode = 3;
    auto run =
        kernel(opcode, bo_instr, instr_v.size(), bo_inA, bo_in_factor, bo_outE);
    std::cout << "====================" << "\n";
        // kernel(opcode, bo_instr, instr_v.size(), bo_inA,bo_outC);
    run.wait();
    auto stop = std::chrono::high_resolution_clock::now();


    // Sync device to host memories
    bo_outE.sync(XCL_BO_SYNC_BO_FROM_DEVICE);


  

    if (iter < n_warmup_iterations) {
      /* Warmup iterations do not count towards average runtime. */
      continue;
    }



// 


// 以下は実行結果との確認


// 
    std::cout << "IN_SIZE" << IN_SIZE << "\n";
    std::cout << "IN_SIZE_factor" << IN_FACTOR_SIZE << "\n";

    // Copy output results and verify they are correct
    // Copy output results and verify they are correct
    if (do_verify) {
      if (verbosity >= 1) {
        std::cout << "Verifying results ..." << std::endl;
      }
      auto vstart = std::chrono::system_clock::now();

      std::cout << "NTT_start" << std::endl;
      FNTT(bufInA_FNTT, all_size_log, modulo_q, w_ori);
      // NTT(bufInA_copy, all_size, modulo_q, w_ori,1);
      std::cout << "NTT_Finish" << std::endl;
      std::cout << "aaaaa" << std::endl;



      int32_t miss_cnt = 0;
      int32_t core_count_index = 0;
      int32_t tile_size = all_size/(col_num*raw_num);

      // bit_reverse_new(bufInA_copy,all_size_log);
      bit_reverse_new_modoshi(bufOutE,all_size_log,core_num_log);
      std::ofstream outfile("output.txt", std::ios::trunc);
      outfile << " N = " << all_size << "\n";

      for (int i = 0; i < IN_SIZE; i++) {
        if((i % tile_size) == 0){
          std::cout << "\n"<< "core : " << core_count_index << "\n"; 
          std::cout << "\n========================================"<< "\n"; 
          outfile<< "\n"<< "core : " << core_count_index << "\n"; 
          outfile<< "\n========================================"<< "\n"; 
          core_count_index += 1;
        }

        int32_t test = bufOutE[i];
        // int32_t correct_flag = 1;

        if (test!=bufInA[i]){
          miss_cnt += 1;
          // correct_flag = 0;
        }
        std::cout << "index : " << i << " , inputs " << bufInA[i] << " = " << std::bitset<all_size_log>(bufInA[i]) <<", out_put:" << test  << "\n"; 
        outfile << "index : " << i << " , inputs " << bufInA[i] << " = " << std::bitset<all_size_log>(bufInA[i])<< " , correct : " << bufInA_FNTT[i] <<", out_put:" << test  << "\n"; 
      }
      for(int i=0;i<factor_single_size;i++){
        std::cout << "w_ori(" << i << ") , : " << bufInFactor[i] << "\n";
      }
      auto vstop = std::chrono::system_clock::now();
      float vtime =
          std::chrono::duration_cast<std::chrono::seconds>(vstop - vstart)
              .count();
      std::cout << "miss_cnt : " << miss_cnt << "\n";
      if (verbosity >= 1) {
        std::cout << "Verify time: " << vtime << "secs." << std::endl;
      }
      std::cout << "W_ori: " << w_ori<< std::endl;
      
    }else{
      if (verbosity >= 1)
        std::cout << "WARNING: results not verified." << std::endl;
    }

    // Write trace values if trace_size > 0
    if (trace_size > 0) {
      test_utils::write_out_trace(((char *)bufOutE) + IN_SIZE, trace_size,
                                  vm["trace_file"].as<std::string>());
    }


    // Accumulate run times
    float npu_time =
        std::chrono::duration_cast<std::chrono::microseconds>(stop - start)
            .count();

    npu_time_total += npu_time;
    npu_time_min = (npu_time < npu_time_min) ? npu_time : npu_time_min;
    npu_time_max = (npu_time > npu_time_max) ? npu_time : npu_time_max;
  }

  // ------------------------------------------------------
  // Print verification and timing results
  // ------------------------------------------------------

  // TODO - Mac count to guide gflops
  float macs = 0;

  std::cout << std::endl
            << "Avg NPU time: " << npu_time_total / n_iterations << "us."
            << std::endl;
  if (macs > 0)
    std::cout << "Avg NPU gflops: "
              << macs / (1000 * npu_time_total / n_iterations) << std::endl;

  std::cout << std::endl
            << "Min NPU time: " << npu_time_min << "us." << std::endl;
  if (macs > 0)
    std::cout << "Max NPU gflops: " << macs / (1000 * npu_time_min)
              << std::endl;

  std::cout << std::endl
            << "Max NPU time: " << npu_time_max << "us." << std::endl;
  if (macs > 0)
    std::cout << "Min NPU gflops: " << macs / (1000 * npu_time_max)
              << std::endl;

  // Print Pass/Fail result of our test
  if (!errors) {
    std::cout << std::endl << "PASS!" << std::endl << std::endl;
    return 0;
  } else {
    std::cout << std::endl
              << errors << " mismatches." << std::endl
              << std::endl;
    std::cout << std::endl << "fail." << std::endl << std::endl;
    return 1;
  }
}


void change_binary(int32_t x, int32_t *ls){

  for (int i = 0; i < 32; i++) {
  ls[31 - i] = (x >> i) & 1;  // xのi番目のビットを取得

  }
}

void NTT(int32_t *a, int32_t n, int32_t q, int32_t w,int32_t p) {
    int temp = n /p;
    for (int l=0; l<p;l++ ){
      std::vector<int32_t> ls(temp, 0);
      for (int k = 0; k < temp; ++k) {
        for (int j = 0; j < temp; ++j) {
            int exp = (k * j) % temp;
            int32_t w_pow= 1;
            
            // w^expを計算する
            for (int i = 0; i < exp; ++i) {
                // w_pow = (w_pow * w) % q;
                int64_t w_temp = (w_pow * w);
                w_pow = calc_mod(w_temp,q);
            }

            // ls[k] += (a[j+temp*l] * w_pow) % q;
            int64_t aaa = a[j+temp*l] * w_pow;
            ls[k] = calc_mod(ls[k] + aaa,q);
        }
      }
      for (int i=0; i<temp ; ++i){
        // a[i+temp*l] = ls[i] % q;
        a[i+temp*l] = calc_mod(ls[i],q);
      }
    }
}

void bit_reverse(int32_t *ls, int32_t n,int32_t p) {
    int N = 1<<n;
    int temp  = N /p;
    int num_bits = std::log2(temp);  // n のビット数を計算
    for(int l=0;l<p;l++){
      int offset = temp * l;

      for (int i = 0; i < temp; ++i) {
          int reversed_index = 0;
          int temp = i;

          // インデックスを反転
          for (int j = 0; j < num_bits; ++j) {
              reversed_index = (reversed_index << 1) | (temp & 1);
              temp >>= 1;
          }
          ls[offset + i] = reversed_index;

      }
    }
}


void FNTT(int32_t *a, int32_t n, int32_t q, int32_t w) {
    int N = 1<<n;
    std::vector<int32_t> w_ls(N + 1);
    int32_t w_single = 1; 
    for (int i = 0; i <= N; ++i) {
        w_ls[i] = w_single;
        // std::cout << "w(" << i << ") : " << w_single << "\n";
        w_single = (w_single*w) % q;
        if(w_single < 0){
          w_single += q + 1 ;
        }
    }
    
    N = 1 << n;
    for (int stage=1;stage<n+1;stage++){
      int32_t w_stage_cnt = 1<<(n-stage);
      int32_t gap = 1<<(stage-1);
      int32_t BF_elements = 1 << stage;
      for(int BF_set =0;BF_set<(1<<(n-stage));BF_set++){
        int32_t w_temp = 0;
        for(int index=0;index<(1<<(stage-1));index++){
          int32_t temp_1 = a[BF_set*BF_elements+index];
          int32_t temp_2 = a[BF_set*BF_elements+index+gap];
          int32_t temp_3 = (temp_2*w_ls[w_temp])%q;
          if(temp_3<0){
            temp_3 += q + 1;
          }
          a[BF_set*BF_elements+index] = (temp_1 + temp_3)%q;
          if(a[BF_set*BF_elements+index]<0){
            a[BF_set*BF_elements+index] += q+1;
          }

          a[BF_set*BF_elements+index+gap] = (temp_1 -temp_3)%q;
          if(a[BF_set*BF_elements+index+gap]<0){
            a[BF_set*BF_elements+index+gap] += q+1;
          }
          w_temp = ((w_stage_cnt + w_temp) %q);
        }
      }
    }
}

void change_order(int32_t *a,int32_t N){
  int32_t quater = N >> 2;
  for(int i=0;i<quater;i++){
    int32_t temp = a[quater+i];
    a[quater+i]=a[quater+quater+i];
    a[quater+quater+i] = temp;
  }
}

int32_t calc_mod(int32_t a, int32_t q){
  a = a % q;
  if (a<0){
    a += q + 1;
  }
  return a;
}

int32_t calc_mod_64(int64_t a, int32_t q){
  a = a*q;
  if(a<0){
    a += q + 1;
  }
  return a;
}



void bit_reverse_new(int32_t *ls, int32_t n,int32_t m) {
  int N = 1 << n;
  int M = 1 << m;
  int32_t single_size = 1<<(n-m);
  int32_t *temp_ls = new int32_t[N];
  for(int i=0;i<N;i++){
    temp_ls[i] = ls[i];
  }
  for (int i = 0; i < N; ++i) {
    int reversed_index = 0;
    int temp = i;
    // インデックスを反転
    for (int j = 0; j < n; ++j) {
        reversed_index = (reversed_index << 1) | (temp & 1);
        temp >>= 1;
    }
    int32_t odd_even_bit = (reversed_index>> (0)) & 1 ;
    int32_t aaa = reversed_index / single_size;
    int32_t bbb = reversed_index - aaa*single_size;
    int32_t new_index = ((bbb-odd_even_bit)>>1)+(odd_even_bit*(1<<(n-m-1))) + aaa*single_size;
    ls[new_index] = temp_ls[i];
    
  }
  

  delete[] temp_ls;
}

void bit_reverse_new_modoshi(int32_t *ls, int32_t n,int32_t m) {
  int N = 1 << n;
  int M = 1<<m;
  int single_size = 1<<(n-m);
  int32_t *temp_ls = new int32_t[N];
  for(int i=0;i<N;i++){
    temp_ls[i] = ls[i];
  }

  for (int i = 0; i < N; ++i) {
    int32_t bbb = i % single_size;
    int32_t aaa = i / single_size;
    int32_t top_bit = (bbb>> (n-m-1)) & 1;
    int32_t new_index;
    if (top_bit == 0 ){
      new_index = (bbb << 1) + aaa*single_size;
    }else{
      new_index = ((bbb-(1<<(n-m-1)))<<1) + 1+ aaa*single_size;
    }
    ls[new_index] = temp_ls[i];
  }
  delete[] temp_ls;
}