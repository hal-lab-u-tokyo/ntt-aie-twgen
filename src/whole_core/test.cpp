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

#include "../nttlib.h"
#include "test_utils.h"
#include "xrt/xrt_bo.h"
#include "xrt/xrt_device.h"
#include "xrt/xrt_kernel.h"

// ===================================
// Change here for different configurations
// ===================================
const int32_t all_size_log = 16;
const int32_t modulo_q = 65537;
const int32_t r = 3;
const int n_stage_for_debug = all_size_log; // 1-origin stage index
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

// namespace po = boost::program_options;


void initialize_a(int *a, int32_t size)
{
  for (int32_t i = 0; i < size; i++)
  {
    a[i] = i;
  }
}

void initialize_twfactor(int *buff, int32_t size, int32_t w_ori)
{
  // std::cout << "w_ori in init twiddle: " << w_ori << "\n";
  for (int core = 0; core < core_num; core++){
    for (int i = 0; i < factor_single_size; i++){
        int w_temp = 1;
        int w_index = 1 << (i);
        for (int j = 0; j < w_index; j++){
          w_temp = (w_temp * w_ori) % modulo_q;
          if (w_temp < 0)
          {
            w_temp += modulo_q + 1;
          }
        }
        // std::cout << "Core " << core << " Twiddle factor index " << i << " = w ^" << w_index << " = " << w_temp << "\n";
        buff[i + factor_single_size * core] = w_temp;
    }
  }
}

// Rearrange data from AIE's output order to normal order
void rearrange_from_aie_order(int *data, int32_t logN, int32_t logN_per_core)
{
  int N = 1 << logN;
  int N_per_core = 1 << logN_per_core;
  int *temp = new int[N];
  
  // ===================
  // Inter tile order
  // ===================
  // Change core order
  std::vector<int> aie_order = {0, 2, 1, 3, 8, 10, 9, 11, 4, 6, 5, 7, 12, 14, 13, 15};
  // std::vector<int> aie_order = {0, 2, 1, 3, 4, 6, 5, 7, 8, 10, 9, 11, 12, 14, 13, 15};
  for (int i = 0; i < core_num; i++){
    int aie_order_index = aie_order[i];
    int *temp_ptr = temp + i * N_per_core;
    int *aie_ptr = data + aie_order_index * N_per_core;
    for (int j = 0; j < N_per_core; j++){
      temp_ptr[j] = aie_ptr[j];
    }
  }


  // ===================
  // Inner tile order
  // ===================
  // Reverse order in each tile
  // CPU: [0, 1, 2, 3, 4, 5, 6, 7]
  // AIE: [0, 2, 4, 6, 1, 3, 5, 7]
  for (int i = 0; i < core_num; i++){
    for (int j = 0; j < (N_per_core / 2); j++){
      int *data_ptr = data + i * N_per_core;
      int *temp_ptr = temp + i * N_per_core;
      data_ptr[2 * j] = temp_ptr[j];
      data_ptr[2 * j + 1] = temp_ptr[(N_per_core / 2) + j];
    }
  }
  delete[] temp;
}

int main(int argc, const char *argv[])
{
  int32_t calc_temp = (modulo_q - 1) / (ntt_size);
  int32_t calc_temp_2 = 1;

  for (int j = 0; j < calc_temp; j++)
  {
    uint64_t ttt = calc_temp_2 * r;
    ttt = ttt % modulo_q;
    calc_temp_2 = ttt;
  }
  int32_t w_ori = calc_temp_2;
  std::cout << "w_ori : " << w_ori << "\n";

  // ===================================
  // Program arguments parsing
  // ===================================
  // po::options_description desc("Allowed options");
  // po::variables_map vm;
  // test_utils::add_default_options(desc);
  cxxopts::Options options("Vector Exp Test");
  cxxopts::ParseResult vm;
  test_utils::add_default_options(options);
  test_utils::parse_options(argc, argv, options, vm);

  // test_utils::parse_options(argc, argv, desc, vm);
  int verbosity = vm["verbosity"].as<int>();
  int do_verify = vm["verify"].as<bool>();
  int n_iterations = vm["iters"].as<int>();
  int trace_size = vm["trace_sz"].as<int>();

  constexpr bool VERIFY = true;
  constexpr int IN_SIZE = all_size;
  constexpr int IN_FACTOR_SIZE = factor_single_size * col_num;
  constexpr int OUT_SIZE = IN_SIZE;
  int OUT_SIZE_bit = IN_SIZE * sizeof(int) + trace_size;
  std::cout << "IN_SIZE : " << IN_SIZE << "\n";
  std::cout << "IN_SIZE_factor : " << IN_FACTOR_SIZE << "\n";
  std::cout << "OUT_SIZE : " << OUT_SIZE << "\n";
  std::cout << "TRACE_SIZE : " << trace_size << "\n";

  // ===================================
  // Start the XRT context and load the kernel 
  // ===================================
  // Load instruction sequence
  std::vector<uint32_t> instr_v =
      test_utils::load_instr_binary(vm["instr"].as<std::string>());

  // Start the XRT context and load the kernel
  // Get a device handle
  unsigned int device_index = 0;
  auto device = xrt::device(device_index);
  
  // Load and register the xclbin
  auto xclbin = xrt::xclbin(vm["xclbin"].as<std::string>());
  device.register_xclbin(xclbin);

  // Load the kernel
  std::string Node = vm["kernel"].as<std::string>();
  auto xkernels = xclbin.get_kernels();
  auto xkernel = *std::find_if(xkernels.begin(), xkernels.end(),
                               [Node, verbosity](xrt::xclbin::kernel &k)
                               {
                                 auto name = k.get_name();
                                 if (verbosity >= 1)
                                 {
                                   std::cout << "Name: " << name << std::endl;
                                 }
                                 return name.rfind(Node, 0) == 0;
                               });
  auto kernelName = xkernel.get_name();

  // Get a hardware context
  xrt::hw_context context(device, xclbin.get_uuid());

  // Get a kernel handle
  auto kernel = xrt::kernel(context, kernelName);

  // ===================================
  // Set up the buffer objects
  // ===================================
  auto bo_instr = xrt::bo(device, instr_v.size() * sizeof(int),
                          XCL_BO_FLAGS_CACHEABLE, kernel.group_id(1));
  auto bo_inA = xrt::bo(device, IN_SIZE * sizeof(int),
                        XRT_BO_FLAGS_HOST_ONLY, kernel.group_id(3));

  auto bo_in_factor = xrt::bo(device, IN_FACTOR_SIZE * sizeof(int),
                              XRT_BO_FLAGS_HOST_ONLY, kernel.group_id(4));

  auto bo_outE = xrt::bo(device, OUT_SIZE_bit,
                         XRT_BO_FLAGS_HOST_ONLY, kernel.group_id(5));
  int *bufInA = bo_inA.map<int *>();
  int *bufInA_reference = new int[IN_SIZE];
  int *bufInFactor = bo_in_factor.map<int *>();
  int *bufOutE = bo_outE.map<int *>();

  // Copy instruction stream to xrt buffer object
  // and sync host to device memories
  void *bufInstr = bo_instr.map<void *>();
  memcpy(bufInstr, instr_v.data(), instr_v.size() * sizeof(int));
  bo_instr.sync(XCL_BO_SYNC_BO_TO_DEVICE);
  
  
  // ===================================
  // Main run loop
  // ===================================
  float npu_time_total = 0;
  float npu_time_first = 0;

  int errors = 0;

  // ===================================
  // Compute reference for verification
  // ===================================
  initialize_a(bufInA_reference, IN_SIZE);
  vector_bit_reverse(bufInA_reference, all_size_log);
  ntt_cpu(bufInA_reference, all_size_log, w_ori, modulo_q, false, n_stage_for_debug);

  for (unsigned iter = 0; iter < n_iterations; iter++)
  {

    // ===================================
    // Initialize input data for each iteration
    // ===================================
    // Input data
    initialize_a(bufInA, IN_SIZE);
    vector_bit_reverse_and_separate(bufInA, all_size_log, size_per_core_log);

    // Twiddle factors
    initialize_twfactor(bufInFactor, IN_FACTOR_SIZE, w_ori);
    if (verbosity >= 2) {
      for (int i = 0; i < core_num; i++) {
        std::cout << "Core " << i << " Twiddle factors: ";
        for (int j = 0; j < factor_single_size; j++) {
          std::cout << bufInFactor[i * factor_single_size + j] << " ";
        }
        std::cout << "\n";
      }
    }

    // Clear output buffer
    memset(bufOutE, 0, OUT_SIZE * sizeof(int));

    // Sync host to device memories
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
    
    // Rearrange output data to normal order
    rearrange_from_aie_order(bufOutE, all_size_log, size_per_core_log);

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


      // Open output file
      std::ofstream outfile("output.txt", std::ios::trunc);
      outfile << " N = " << all_size << "\n";

      for (int i = 0; i < IN_SIZE; i++)
      {
        // Output results to file `output.txt`
        if ((i % tile_size) == 0)
        {
          outfile << "\n"
                  << "core : " << core_count_index << "\n";
          outfile << "\n========================================" << "\n";
          core_count_index += 1;
        }

        int32_t expected = bufInA_reference[i];
        int32_t output = bufOutE[i];

        outfile << "index : " << i << " , correct : " << expected << ", output:" << output;
        if (output != expected)
        {
          miss_cnt += 1;
          outfile << "  <-- MISMATCH!";
        }
        outfile << "\n";
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
    
    if (iter == 0) {
      npu_time_first = npu_time;
    } else {
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

