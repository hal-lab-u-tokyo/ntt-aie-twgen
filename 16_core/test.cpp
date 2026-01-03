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

#include "nttlib.h"
#include "test_utils.h"
#include "xrt/xrt_bo.h"

#ifndef DATATYPES_USING_DEFINED
#define DATATYPES_USING_DEFINED
using DATATYPE = std::int32_t; // Configure this to match your buffer data type
#endif

void reverse_order_for_verify(uint32_t *data, int32_t logN, int32_t logN_per_core);

int32_t calc_mod(int32_t a, int32_t q);
int32_t calc_mod_64(int64_t a, int32_t q);

// ===================================
// Change here for different configurations
const int32_t all_size_log = 16;
const int32_t modulo_q = 65537;
const int32_t r = 3;
// ===================================

const int32_t col_num_log = 2;
const int32_t col_num = 1 << col_num_log;
const int32_t raw_num_log = 2;
const int32_t raw_num = 1 << raw_num_log;
const int32_t core_num_log = col_num_log + raw_num_log;
const int32_t core_num = col_num * raw_num;
const int32_t factor_single_size = all_size_log;
const int32_t ntt_size_log = all_size_log;
const int32_t all_size = 1 << all_size_log;
const int32_t ntt_size = 1 << ntt_size_log;
const int32_t size_per_core_log = all_size_log - core_num_log;

namespace po = boost::program_options;


void initialize_a(uint32_t *a, int32_t size)
{
  for (int32_t i = 0; i < size; i++)
  {
    a[i] = i;
  }
}

void initialize_twfactor(uint32_t *buff, int32_t size, int32_t w_ori)
{
  for (int core = 0; core < core_num; core++){
    for (uint32_t i = 0; i < factor_single_size; i++){
        uint32_t w_temp = 1;
        uint32_t w_index = 1 << (i);
        for (uint32_t j = 0; j < w_index; j++){
          w_temp = (w_temp * w_ori) % modulo_q;
          if (w_temp < 0)
          {
            w_temp += modulo_q + 1;
          }
        }
        buff[i + factor_single_size * core] = w_temp;
    }  
  }
}

int main(int argc, const char *argv[])
{
  int32_t calc_temp = (modulo_q - 1) / (ntt_size);
  int32_t calc_temp_2 = 1;

  for (int j = 0; j < calc_temp; j++)
  {
    // calc_temp_2 = calc_temp_2*r % modulo_q;
    uint64_t ttt = calc_temp_2 * r;
    ttt = ttt % modulo_q;
    calc_temp_2 = ttt;
  }
  int32_t w_ori = calc_temp_2;

  std::cout << "====================\n";
  std::cout << "w_ori : " << w_ori << "\n";

  // ===================================
  // Program arguments parsing
  // ===================================
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
  int OUT_SIZE_bit = IN_SIZE * sizeof(DATATYPE) + trace_size;

  // ===================================
  // Load instruction sequence
  // ===================================
  std::vector<uint32_t> instr_v =
      test_utils::load_instr_binary(vm["instr"].as<std::string>());

  if (verbosity >= 1)
  {
    std::cout << "Instruction loaded. size: " << instr_v.size() << "\n";
  }

  // Start the XRT context and load the kernel
  xrt::device device;
  xrt::kernel kernel;

  test_utils::init_xrt_load_kernel(device, kernel, verbosity,
                                   vm["xclbin"].as<std::string>(),
                                   vm["kernel"].as<std::string>());

  // ===================================
  // Set up the buffer objects
  // ===================================
  auto bo_instr = xrt::bo(device, instr_v.size() * sizeof(int),
                          XCL_BO_FLAGS_CACHEABLE, kernel.group_id(1));
  auto bo_inA = xrt::bo(device, IN_SIZE * sizeof(DATATYPE),
                        XRT_BO_FLAGS_HOST_ONLY, kernel.group_id(3));

  auto bo_in_factor = xrt::bo(device, IN_FACTOR_SIZE * sizeof(DATATYPE),
                              XRT_BO_FLAGS_HOST_ONLY, kernel.group_id(4));

  auto bo_outE = xrt::bo(device, OUT_SIZE_bit,
                         XRT_BO_FLAGS_HOST_ONLY, kernel.group_id(5));

  if (verbosity >= 1)
  {
    std::cout << "Writing data into buffer objects.\n";
  }

  // Copy instruction stream to xrt buffer object
  void *bufInstr = bo_instr.map<void *>();
  memcpy(bufInstr, instr_v.data(), instr_v.size() * sizeof(int));

  // ===================================
  // Initialize buffer objects
  // ===================================
  uint32_t *bufInA = bo_inA.map<uint32_t *>();
  uint32_t *bufInA_reference = new uint32_t[IN_SIZE];
  uint32_t *bufInFactor = bo_in_factor.map<uint32_t *>();
  uint32_t *bufOutE = bo_outE.map<uint32_t *>();
  
  
  // sync host to device memories
  bo_instr.sync(XCL_BO_SYNC_BO_TO_DEVICE);
  
  // ===================================
  // Main run loop
  // ===================================
  float npu_time_total = 0;
  float npu_time_first = 0;

  int errors = 0;

  // Compute reference results
  initialize_a(bufInA_reference, IN_SIZE);
  vector_bit_reverse(bufInA_reference, all_size_log);
  ntt_cpu(bufInA_reference, all_size_log, w_ori, modulo_q, false, 1);

  for (unsigned iter = 0; iter < n_iterations; iter++)
  {

    // ===================================
    // Prepare input data for each iteration
    // ===================================
    initialize_a(bufInA, IN_SIZE);
    vector_bit_reverse_and_separate(bufInA, all_size_log, size_per_core_log);

    initialize_twfactor(bufInFactor, IN_FACTOR_SIZE, w_ori);

    memset(bufOutE, 0, OUT_SIZE * sizeof(uint32_t));

    bo_inA.sync(XCL_BO_SYNC_BO_TO_DEVICE);
    bo_in_factor.sync(XCL_BO_SYNC_BO_TO_DEVICE);
    bo_outE.sync(XCL_BO_SYNC_BO_TO_DEVICE);


    // ===================================
    // Run kernel
    // ===================================
    std::cout << "====================\n";
    if (verbosity >= 1)
    {
      std::cout << "Running Kernel.\n";
    }
    auto start = std::chrono::high_resolution_clock::now();
    unsigned int opcode = 3;
    auto run =
        kernel(opcode, bo_instr, instr_v.size(), bo_inA, bo_in_factor, bo_outE);
    run.wait();
    auto stop = std::chrono::high_resolution_clock::now();

    // Sync device to host memories
    bo_outE.sync(XCL_BO_SYNC_BO_FROM_DEVICE);

    if (iter < n_warmup_iterations)
    {
      continue;
    }

    // ===================================
    // Verify
    // ===================================
    if (do_verify)
    {
      if (verbosity >= 1)
      {
        std::cout << "Verifying results ..." << std::endl;
      }

      int32_t miss_cnt = 0;
      int32_t core_count_index = 0;
      int32_t tile_size = all_size / (col_num * raw_num);

      reverse_order_for_verify(bufOutE, all_size_log, size_per_core_log);

      // Output results to file
      std::ofstream outfile("output.txt", std::ios::trunc);
      outfile << " N = " << all_size << "\n";

      for (int i = 0; i < IN_SIZE; i++)
      {
        if ((i % tile_size) == 0)
        {
          outfile << "\n"
                  << "core : " << core_count_index << "\n";
          outfile << "\n========================================" << "\n";
          core_count_index += 1;
        }

        int32_t expected = bufInA_reference[i];
        int32_t output = bufOutE[i];
        // int32_t correct_flag = 1;

        if (output != expected)
        {
          miss_cnt += 1;
          // correct_flag = 0;
          // std::cout << "index : " << i << " , correct : " << expected << ", output:" << output << "\n";
        }
        outfile << "index : " << i << " , correct : " << expected << ", output:" << output << "\n";
      }
      
      if (miss_cnt == 0)
      {
        std::cout << "PASSED: All results match reference.\n";
      }
      else
      {
        std::cout << "FAILED: results did not match reference. "
                  << miss_cnt << " mismatches found.\n";
      }
    }
    else
    {
      if (verbosity >= 1)
        std::cout << "WARNING: results not verified." << std::endl;
    }

    // ===================================
    // Write trace values
    // ===================================
    if (trace_size > 0)
    {
      test_utils::write_out_trace(((char *)bufOutE) + IN_SIZE, trace_size,
                                  vm["trace_file"].as<std::string>());
    }

    // ===================================
    // Accumulate run times
    // ===================================
    float npu_time =
        std::chrono::duration_cast<std::chrono::microseconds>(stop - start)
            .count();
    
    if (iter == 0){
      npu_time_first = npu_time;
    }else {
      npu_time_total += npu_time;
    }
  }

  // ===================================
  // Print timing results
  // ===================================
  std::cout << "====================\n";
  std::cout << "First NPU time: " << npu_time_first << " [us]" << std::endl;

  if (n_iterations > 1) {
    std::cout << "Average NPU time over " << n_iterations - 1
              << " iterations: "
              << npu_time_total / (n_iterations - 1) << " [us]" << std::endl;
  } 
}

int32_t calc_mod(int32_t a, int32_t q)
{
  a = a % q;
  if (a < 0)
  {
    a += q + 1;
  }
  return a;
}

int32_t calc_mod_64(int64_t a, int32_t q)
{
  a = a * q;
  if (a < 0)
  {
    a += q + 1;
  }
  return a;
}

void reverse_order_for_verify(uint32_t *data, int32_t logN, int32_t logN_per_core)
{
  int N = 1 << logN;
  int single_size = 1 << logN_per_core;
  uint32_t *temp_ls = new uint32_t[N];
  for (int i = 0; i < N; i++)
  {
    temp_ls[i] = data[i];
  }

  // Reverse order from AIE to CPU
  // CPU: [0, 1, 2, 3, 4, 5, 6, 7]
  // AIE: [0, 2, 4, 6, 1, 3, 5, 7]
  for (int i = 0; i < N; ++i)
  {
    int32_t idx_in_block = i % single_size;
    int32_t idx_block = i / single_size;
    int32_t odd_even_bit = idx_in_block & 1;
    int32_t idx_aie = ((idx_in_block - odd_even_bit) >> 1) + (odd_even_bit * (single_size / 2)) + (idx_block * single_size);
    data[i] = temp_ls[idx_aie];
  }
  delete[] temp_ls;
}