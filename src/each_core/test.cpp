//===- test.cpp -------------------------------------------------*- C++ -*-===//
//
// This file is licensed under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// Copyright (C) 2023, Advanced Micro Devices, Inc.
//
//===----------------------------------------------------------------------===//

#include <cassert>
#include <cmath>
#include <cstdint>
#include <fstream>
#include <iostream>

#include "../nttlib.h"
#include "test_utils.h"
#include "xrt/xrt_bo.h"
#include "xrt/xrt_device.h"
#include "xrt/xrt_kernel.h"

// ===================================
// Change here for different configurations
// ===================================
const int32_t N_LOG = 17;
const int32_t modulo_q = 65537;
const int32_t w_root = 3;
const int n_stage_for_debug = N_LOG; // 1-origin stage index
// ===================================

const int32_t N = 1 << N_LOG;
const int32_t COL_NUM_LOG = 2;
const int32_t COL_NUM = 1 << COL_NUM_LOG;
const int32_t RAW_NUM_LOG = 2;
const int32_t RAW_NUM = 1 << RAW_NUM_LOG;
const int32_t CORE_NUM_LOG = COL_NUM_LOG + RAW_NUM_LOG;
const int32_t CORE_NUM = COL_NUM * RAW_NUM;
const int32_t FACTOR_SIZE_PER_CORE = N_LOG + 8;
const int32_t N_LOG_PER_CORE = N_LOG - CORE_NUM_LOG;

// ===================================
// Parameters for Divided NTT
// ===================================
const int32_t N_LOG_PHASE1 = (N_LOG + 1) / 2;
const int32_t N_LOG_PHASE2 = N_LOG - N_LOG_PHASE1;
const int32_t N_PHASE1 = 1 << N_LOG_PHASE1;
const int32_t N_PHASE2 = 1 << N_LOG_PHASE2;
const int32_t LOOP_PHASE1 = N_LOG_PHASE2 - CORE_NUM_LOG;
const int32_t LOOP_PHASE2 = N_LOG_PHASE1 - CORE_NUM_LOG;
const int32_t FLAG_PHASE1 = 0;
const int32_t FLAG_PHASE2 = 1;


void initialize_a(int *a, int32_t size)
{
  for (int32_t i = 0; i < size; i++)
  {
    a[i] = ((int64_t)i * i) % modulo_q;
  }
}

// Initialize twiddle factors for all columns
// Output buffer consists of `COL_NUM` loops of `FACTOR_SIZE_PER_CORE` metadatas
// Each `FACTOR_SIZE_PER_CORE` buffer is:
// [w, w^2, w^4, w^8, ..., w^(2^(N_LOG-1)), modulus, barrett_w, barrett_u]
void initialize_metadata_for_divided_ntt(int *buff, int32_t size, int32_t mod, int32_t root, int32_t logn_for_current_ntt, int32_t if_phase2)
{
  assert(size == FACTOR_SIZE_PER_CORE * COL_NUM);
  for (int core = 0; core < CORE_NUM; core++){
    for (int i = 0; i < N_LOG; i++){
        int w_temp = 1;
        int w_index = 1 << (i);
        for (int j = 0; j < w_index; j++){
          w_temp = (w_temp * root) % mod;
        }
        buff[i + FACTOR_SIZE_PER_CORE * core] = w_temp;
    }
    int barrett_w = std::ceil(std::log2(mod));
    int barrett_u = ((int64_t)1<<(2 * barrett_w)) / mod;
    buff[FACTOR_SIZE_PER_CORE * core + N_LOG] = mod;
    buff[FACTOR_SIZE_PER_CORE * core + N_LOG + 1] = barrett_w;
    buff[FACTOR_SIZE_PER_CORE * core + N_LOG + 2] = barrett_u;
    buff[FACTOR_SIZE_PER_CORE * core + N_LOG + 3] = logn_for_current_ntt;
    buff[FACTOR_SIZE_PER_CORE * core + N_LOG + 4] = 1 << logn_for_current_ntt;
    buff[FACTOR_SIZE_PER_CORE * core + N_LOG + 5] = if_phase2;
  }
}

// Bitreverse and separate odd-even bits
// Example:
// input: [0, 1, 2, 3, 4, 5, 6, 7]
// bit-reverse: [0, 4, 2, 6, 1, 5, 3, 7]
// separate odd-even bits: [0, 2, 1, 3, 4, 6, 5, 7]
//
// Arguments:
// logN: log2 of total data size
// logN_block: 
//   - for whole-core NTT: log2 of data size per core, i.e., LOGN - CORE_NUM_LOG
//   - for each-core NTT: log2 of N for current phase
void rearrange_to_aie_order(int *data, int logN, int logN_per_block)
{
    const int N = 1 << logN;
    const int N_per_block = 1 << logN_per_block;
    const int number_of_blocks = N / N_per_block;
    int32_t *temp_ls = new int32_t[N];
    for (int i = 0; i < N; i++)
    {
        temp_ls[i] = data[i];
    }
 
    for (int i = 0; i < N; ++i)
    {
      int reversed_index = bit_reverse(i, logN);
      int32_t odd_even_bit = (reversed_index >> (0)) & 1;
      int32_t idx_block = reversed_index / N_per_block;
      int32_t idx_in_block = reversed_index % N_per_block;
      int32_t new_index = ((idx_in_block - odd_even_bit) >> 1) + (odd_even_bit * (1 << (logN_per_block - 1))) + idx_block * N_per_block;
      data[new_index] = temp_ls[i];
    }
    delete[] temp_ls;
}

// Rearrange data from AIE's output order to normal order
// Arguments:
// logN: log2 of total data size
// logN_per_block: log2 of N for current phase
void rearrange_from_aie_order_for_divided_ntt(int *data, int32_t logN, int32_t logN_per_block)
{
  int N = 1 << logN;
  int N_per_block = 1 << logN_per_block;
  int number_of_blocks = N / N_per_block;
  int *temp = new int[N];

  for (int i = 0; i < N; i++)
  {
    temp[i] = data[i];
  }

  // ===================
  // Inner block order
  // ===================
  // Reverse order in each block
  // CPU: [0, 1, 2, 3, 4, 5, 6, 7]
  // AIE: [0, 2, 4, 6, 1, 3, 5, 7]
  for (int i = 0; i < number_of_blocks; i++){
    int *data_ptr = data + i * N_per_block;
    int *temp_ptr = temp + i * N_per_block;
    for (int j = 0; j < (N_per_block / 2); j++){
      data_ptr[2 * j] = temp_ptr[j];
      data_ptr[2 * j + 1] = temp_ptr[(N_per_block / 2) + j];
    }
  }
  delete[] temp;
}

void rotl_array(int *dst, int *src, int32_t logN, int32_t rotation){
  int N = 1 << logN;
  int *tmp = new int[N];
  for (int i = 0; i < N; i++){
    tmp[i] = src[rotl(i, rotation, logN)];
  }
  for (int i = 0; i < N; i++){
    dst[i] = tmp[i];
  }
  delete[] tmp;
}

void rearrange_and_rotl(int *dst, int *src, int32_t logN, int32_t logN_p1, int32_t logN_p2, int32_t rotation)
{
  int N = 1 << logN;
  int N_p1 = 1 << logN_p1;
  int N_p2 = 1 << logN_p2;
  int *temp = new int[N];

  // TODO: can we merge rearrangement and rotl in one loop?

  // ===================
  // Inner block order
  // ===================
  // Reverse order in each block
  // CPU: [0, 1, 2, 3, 4, 5, 6, 7]
  // AIE: [0, 2, 4, 6, 1, 3, 5, 7]
  for (int i = 0; i < N_p2; i++)
  {
    int *src_i = src + i * N_p1;
    int *temp_i = temp + i * N_p1;
    for (int j = 0; j < (N_p1 / 2); j++)
    {
      temp_i[2 * j] = src_i[j];
      temp_i[2 * j + 1] = src_i[(N_p1 / 2) + j];
    }
  }

  // ===================
  // rotl
  // ===================
  for (int i = 0; i < N; i++)
  {
    src[i] = temp[rotl(i, rotation, logN)];
  }

  // ===================
  // Inter block order
  // ===================
  for (int i = 0; i < N_p1; i++)
  {
    int *temp_i = temp + i * N_p2;
    int *src_i = src + i * N_p2;
    for (int j = 0; j < (N_p2 / 2); j++)
    {
      temp_i[j] = src_i[2 * j];
      temp_i[(N_p2 / 2) + j] = src_i[2 * j + 1];
    }
  }

  for (int i = 0; i < N; i++){
    dst[i] = temp[i];
  }

  delete[] temp;
}

int main(int argc, const char *argv[])
{
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
  constexpr int IN_SIZE = N;
  constexpr int IN_FACTOR_SIZE = FACTOR_SIZE_PER_CORE * COL_NUM;
  constexpr int OUT_SIZE = IN_SIZE;
  int OUT_SIZE_bit = IN_SIZE * sizeof(int) + trace_size;
  std::cout << "IN_SIZE : " << IN_SIZE << "\n";
  std::cout << "IN_SIZE_factor : " << IN_FACTOR_SIZE << "\n";
  std::cout << "OUT_SIZE : " << OUT_SIZE << "\n";
  std::cout << "TRACE_SIZE : " << trace_size << "\n";

  std::cout << "N_LOG_PHASE1 : " << N_LOG_PHASE1 << "\n";
  std::cout << "N_LOG_PHASE2 : " << N_LOG_PHASE2 << "\n";
  std::cout << "LOOP_PHASE1 : " << LOOP_PHASE1 << "\n";
  std::cout << "LOOP_PHASE2 : " << LOOP_PHASE2 << "\n";
  assert(N_LOG_PHASE1 <= 12); // Each core can handle max 4096 points NTT
  assert(N_LOG_PHASE2 <= 12);

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
  const int stage_limit = (N_LOG + 1) / 2;
  initialize_a(bufInA_reference, IN_SIZE);
  divided_ntt_inplace(bufInA_reference, N_LOG, w_root, modulo_q, stage_limit, false);


  for (unsigned iter = 0; iter < n_iterations; iter++)
  {
    std::cout << "====================\n";
    
    unsigned int opcode = 3;

    // ===================================
    // Prepare for Phase1
    // ===================================
    
    // Input data
    initialize_a(bufInA, IN_SIZE);
    rearrange_to_aie_order(bufInA, N_LOG, N_LOG_PHASE1);

    // Twiddle factors
    initialize_metadata_for_divided_ntt(bufInFactor, IN_FACTOR_SIZE, modulo_q, w_root, N_LOG_PHASE1, FLAG_PHASE1);

    // Clear output buffer
    memset(bufOutE, 0, OUT_SIZE * sizeof(int));

    // Sync host to device memories
    bo_inA.sync(XCL_BO_SYNC_BO_TO_DEVICE);
    bo_in_factor.sync(XCL_BO_SYNC_BO_TO_DEVICE);
    bo_outE.sync(XCL_BO_SYNC_BO_TO_DEVICE);


    auto start = std::chrono::high_resolution_clock::now();
    
    // ===================================
    // Phase1
    // ===================================
    auto run =
        kernel(opcode, bo_instr, instr_v.size(), bo_inA, bo_in_factor, bo_outE);
    run.wait();

    bo_outE.sync(XCL_BO_SYNC_BO_FROM_DEVICE);

    // ===================================
    // Prepare for Phase2
    // ===================================
    // rotation and set new input
    rearrange_and_rotl(bufInA, bufOutE, N_LOG, N_LOG_PHASE1, N_LOG_PHASE2, N_LOG_PHASE1);
    
    // Twiddle factors
    initialize_metadata_for_divided_ntt(bufInFactor, IN_FACTOR_SIZE, modulo_q, w_root, N_LOG_PHASE2, FLAG_PHASE2);

    bo_inA.sync(XCL_BO_SYNC_BO_TO_DEVICE);
    bo_in_factor.sync(XCL_BO_SYNC_BO_TO_DEVICE);
    bo_outE.sync(XCL_BO_SYNC_BO_TO_DEVICE); // This sync is required
    
    // ===================================
    // Phase2
    // ===================================
    auto run_p2 =
        kernel(opcode, bo_instr, instr_v.size(), bo_inA, bo_in_factor, bo_outE);
    run_p2.wait();
    bo_outE.sync(XCL_BO_SYNC_BO_FROM_DEVICE);
    
    auto stop = std::chrono::high_resolution_clock::now();
    
    // Rearrange output data to normal order
    rearrange_from_aie_order_for_divided_ntt(bufOutE, N_LOG, N_LOG_PHASE2);
    rotl_array(bufOutE, bufOutE, N_LOG, N_LOG_PHASE2);

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
      int32_t tile_size = N / (COL_NUM * RAW_NUM);


      // Open output file
      std::ofstream outfile("output.txt", std::ios::trunc);
      outfile << " N = " << N << "\n";

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

