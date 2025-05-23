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

double calc_val(float *ls,double ave,int num);

const int32_t all_size_log =12;
const int32_t all_size = 1 << all_size_log;
const int32_t half_all_size = 1 << (all_size_log-1);
const int32_t calc_size_log = 4;
const int32_t minus_size_log = 0;
const int32_t calc_size = 1 << calc_size_log;
const int32_t modulo_q = 65537;
// const int32_t modulo_q = 12289;
const int32_t r = 3;


namespace po = boost::program_options;

int main(int argc, const char *argv[]) {
  int32_t calc_temp = (modulo_q-1)/(all_size);
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
  constexpr int IN_VOLUME = all_size;
  constexpr int IN_FACTOR_VOLUME = all_size_log ;


  constexpr int IN_SIZE = IN_VOLUME * sizeof(DATATYPE);
  constexpr int IN_FACTOR_SIZE = IN_FACTOR_VOLUME * sizeof(DATATYPE);
  int OUT_SIZE = IN_SIZE + trace_size;

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
  auto bo_inA =
      xrt::bo(device, IN_SIZE, XRT_BO_FLAGS_HOST_ONLY, kernel.group_id(3));
  auto bo_in_Factor = xrt::bo(device, IN_FACTOR_SIZE,
                             XRT_BO_FLAGS_HOST_ONLY, kernel.group_id(4));
  auto bo_outC =
      xrt::bo(device, OUT_SIZE, XRT_BO_FLAGS_HOST_ONLY, kernel.group_id(5));

  if (verbosity >= 1)
    std::cout << "Writing data into buffer objects.\n";

  // Copy instruction stream to xrt buffer object
  void *bufInstr = bo_instr.map<void *>();
  memcpy(bufInstr, instr_v.data(), instr_v.size() * sizeof(int));

  // Initialize buffer bo_inA
  DATATYPE *bufInA = bo_inA.map<DATATYPE *>();
  for (int i = 0; i < IN_VOLUME; i++){
    bufInA[i] = i;
  }

  DATATYPE *bufInA_copy = new DATATYPE[IN_VOLUME]; // 新しいメモリを確保
  for (int i = 0; i < IN_VOLUME; i++) {
      bufInA_copy[i] = bufInA[i];
  }

  bit_reverse(bufInA,all_size,1 << minus_size_log);


  DATATYPE *bufInFactor = bo_in_Factor.map<DATATYPE *>();

  for (int i = 0; i < IN_FACTOR_VOLUME; i++){
    int32_t w_temp = 1;
    int32_t w_index = 1 << (i);
    for(int j=0;j<w_index;j++){
      w_temp = w_temp * w_ori % modulo_q;
      if(w_temp < 0){
        w_temp += modulo_q + 1;
      }
    }
    bufInFactor[i] = w_temp;
    
    // std::cout << "w_temp("<< i << ") : " << w_temp <<"\n";
  }


  // Zero out buffer bo_outC
  DATATYPE *bufOut = bo_outC.map<DATATYPE *>();
  memset(bufOut, 0, OUT_SIZE);

  // sync host to device memories
  bo_instr.sync(XCL_BO_SYNC_BO_TO_DEVICE);
  bo_inA.sync(XCL_BO_SYNC_BO_TO_DEVICE);
  bo_in_Factor.sync(XCL_BO_SYNC_BO_TO_DEVICE);
  bo_outC.sync(XCL_BO_SYNC_BO_TO_DEVICE);

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
  std::cout << "============="  << num_iter << "\n";
  float *time_list = new float[n_iterations];
  for (unsigned iter = 0; iter < num_iter; iter++) {

    // Run kernel
    if (verbosity >= 1)
      std::cout << "Running Kernel.\n";
    auto start = std::chrono::high_resolution_clock::now();
    unsigned int opcode = 3;
    auto run =
        kernel(opcode, bo_instr, instr_v.size(), bo_inA, bo_in_Factor, bo_outC);
    run.wait();
    auto stop = std::chrono::high_resolution_clock::now();

    // Sync device to host memories
    bo_outC.sync(XCL_BO_SYNC_BO_FROM_DEVICE);

    if (iter < n_warmup_iterations) {
      /* Warmup iterations do not count towards average runtime. */
      continue;
    }

    // Copy output results and verify they are correct

    // NTT(bufInA_copy, all_size, modulo_q, w_ori,1 << minus_size_log);
    int32_t correct_check = 0;
    // do_verify = 0;
    if (do_verify) {
      if (verbosity >= 1) {
        std::cout << "Verifying results ..." << std::endl;
      }
      auto vstart = std::chrono::system_clock::now();
      for (uint32_t i = 0; i < IN_VOLUME; i++) {
        int32_t ref = bufInA_copy[i];
        int32_t test = bufOut[i];
        if(ref != test){
          correct_check += 1;
        }
        std::cout << " i : "<< i << ", ref : " << ref << " , test : " << test << "\n";
      }
      if(correct_check == 0){
        std::cout << "Correct" << "\n";
      }else{
        std::cout << "False : " << correct_check << " times " << "\n";
      }
      std::cout << "W_ori : " << w_ori << "\n";
      auto vstop = std::chrono::system_clock::now();
      float vtime =
          std::chrono::duration_cast<std::chrono::seconds>(vstop - vstart)
              .count();
      if (verbosity >= 1) {
        std::cout << "Verify time: " << vtime << "secs." << std::endl;
      }
    } else {
      if (verbosity >= 1)
        std::cout << "WARNING: results not verified." << std::endl;
    }

    // Write trace values if trace_size > 0
    if (trace_size > 0) {
      test_utils::write_out_trace(((char *)bufOut) + IN_SIZE, trace_size,
                                  vm["trace_file"].as<std::string>());
    }

    // Accumulate run times
    float npu_time =
        std::chrono::duration_cast<std::chrono::microseconds>(stop - start)
            .count();

    time_list[iter-n_warmup_iterations] = npu_time;
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

  double ave = (npu_time_total / n_iterations);
  double val = calc_val(time_list,ave,n_iterations);
  delete[] time_list; 
  float sd = std::sqrt(val);

  std::cout << "\n";

  std::cout << "sd NPU time:"
            << sd << "us." << std::endl;
  

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
            int w_pow= 1;
            
            // w^expを計算する
            for (int i = 0; i < exp; ++i) {
                w_pow = (w_pow * w) % q;
            }

            ls[k] += (a[j+temp*l] * w_pow) % q;
        }
      }
      for (int i=0; i<temp ; ++i){
        a[i+temp*l] = ls[i] % q;
      }
    }
}

void bit_reverse(int32_t *ls, int32_t n,int32_t p) {
    int temp  = n /p;
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

double calc_val(float *ls,double ave,int num){
  double temp = 0;
  for(int i=0;i<num;i++){
    temp += std::pow((static_cast<double>(ls[i])-ave),2);
  }
  temp = temp/num;
  return temp;
}
