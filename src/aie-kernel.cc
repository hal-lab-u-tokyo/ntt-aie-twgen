//===- vector_scaler_mul.cc -------------------------------------*- C++ -*-===//
//
// This file is licensed under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// Copyright (C) 2024, Advanced Micro Devices, Inc.
//
//===----------------------------------------------------------------------===//

#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <type_traits>
#include <cmath>
#include <aie_api/aie.hpp>

constexpr int32_t vec_prime = 16;
constexpr int32_t vec_prime_half = 8;
constexpr int32_t calc_size_log = 4;
constexpr int32_t barret_w = 14;
constexpr int32_t barret_u = 21843;

// ==================================
// Vector operations
// ==================================

int32_t barrett(int32_t v, int32_t p, int32_t factor, int32_t u, int32_t w)
{
    int64_t t = (int64_t)v * factor;
    int32_t x_1 = (int32_t)(t >> (w - 2));
    int64_t x_2 = (int64_t)x_1 * u;
    int32_t s = (int32_t)(x_2 >> (w + 2));
    int64_t r = (int64_t)s * p;
    int32_t c = (int32_t)(t - r);
    if (c >= p)
    {
        c = c - p;
    }
    return c;
}

// Barrett reduction for 16 elements
aie::vector<int32_t, vec_prime> vector_barrett(aie::vector<int32_t, vec_prime> &v, aie::vector<int32_t, vec_prime> &p_vec, aie::vector<int32_t, vec_prime> &factor_vec, aie::vector<int32_t, vec_prime> &u_vec, int32_t w)
{
  aie::accum<acc64, vec_prime> t = aie::mul(v, factor_vec);
  aie::vector<int32_t, vec_prime> x_1 = t.template to_vector<int32_t>(w - 2);
  aie::accum<acc64, vec_prime> x_2 = aie::mul(x_1, u_vec);
  aie::vector<int32_t, vec_prime> s = x_2.template to_vector<int32_t>(w + 2);
  aie::accum<acc64, vec_prime> r = aie::mul(s, p_vec);
  aie::accum<acc64, vec_prime> cc = aie::sub(t, r);
  aie::vector<int32_t, vec_prime> c = cc.template to_vector<int32_t>(0);
  // aie::vector<int32_t, vec_prime> tt = t.template to_vector<int32_t>(0);
  // aie::vector<int32_t, vec_prime> rr = r.template to_vector<int32_t>(0);
  // aie::vector<int32_t, vec_prime> c = aie::sub(tt, rr);
  aie::mask<vec_prime> mask_c_lt_p = aie::lt(c, p_vec);
  aie::vector<int32_t, vec_prime> over_c = aie::select(p_vec, 0, mask_c_lt_p);
  aie::vector<int32_t, vec_prime> barrett = aie::sub(c, over_c);
  return barrett;
}

aie::vector<int32_t, vec_prime> vector_barrett_const(const aie::vector<int32_t, vec_prime> &v, aie::vector<int32_t, vec_prime> &p_vec, aie::vector<int32_t, vec_prime> &factor_vec, aie::vector<int32_t, vec_prime> &u_vec, int32_t w)
{
  aie::accum<acc64, vec_prime> t = aie::mul(v, factor_vec);
  aie::vector<int32_t, vec_prime> x_1 = t.template to_vector<int32_t>(w - 2);
  aie::accum<acc64, vec_prime> x_2 = aie::mul(x_1, u_vec);
  aie::vector<int32_t, vec_prime> s = x_2.template to_vector<int32_t>(w + 2);
  aie::accum<acc64, vec_prime> r = aie::mul(s, p_vec);
  aie::accum<acc64, vec_prime> cc = aie::sub(t, r);
  aie::vector<int32_t, vec_prime> c = cc.template to_vector<int32_t>(0);
  aie::mask<vec_prime> mask_c_lt_p = aie::lt(c, p_vec);
  aie::vector<int32_t, vec_prime> over_c = aie::select(p_vec, 0, mask_c_lt_p);
  aie::vector<int32_t, vec_prime> barrett = aie::sub(c, over_c);
  return barrett;
}

// Barrett reduction for 8 elements
aie::vector<int32_t, vec_prime_half>
vector_barrett_half(const aie::vector<int32_t, vec_prime_half> &v, const aie::vector<int32_t, vec_prime_half> &p_vec, const aie::vector<int32_t, vec_prime_half> &factor_vec, const aie::vector<int32_t, vec_prime_half> &u_vec, int32_t w)
{
  aie::accum<acc64, vec_prime_half> t = aie::mul(v, factor_vec);
  aie::vector<int32_t, vec_prime_half> x_1 = t.template to_vector<int32_t>(w - 2);
  aie::accum<acc64, vec_prime_half> x_2 = aie::mul(x_1, u_vec);
  aie::vector<int32_t, vec_prime_half> s = x_2.template to_vector<int32_t>(w + 2);
  aie::accum<acc64, vec_prime_half> r = aie::mul(s, p_vec);
  aie::accum<acc64, vec_prime_half> cc = aie::sub(t, r);
  aie::vector<int32_t, vec_prime_half> c = cc.template to_vector<int32_t>(0);
  // aie::vector<int32_t, vec_prime_half> tt = t.template to_vector<int32_t>(0);
  // aie::vector<int32_t, vec_prime_half> rr = r.template to_vector<int32_t>(0);
  // aie::vector<int32_t, vec_prime_half> c = aie::sub(tt, rr);
  aie::mask<vec_prime_half> mask_c_lt_p = aie::lt(c, p_vec);
  aie::vector<int32_t, vec_prime_half> over_c = aie::select(p_vec, 0, mask_c_lt_p);
  aie::vector<int32_t, vec_prime_half> barrett = aie::sub(c, over_c);
  return barrett;
}

// Modulo addition for 16 elements
aie::vector<int32_t, vec_prime> vector_modadd(aie::vector<int32_t, vec_prime> &v0, aie::vector<int32_t, vec_prime> &v1, aie::vector<int32_t, vec_prime> &p_vector)
{
  aie::vector<int32_t, vec_prime> v2 = aie::add(v0, v1);
  aie::mask<vec_prime> mask_v2_lt_p = aie::lt(v2, p_vector);
  aie::vector<int32_t, vec_prime> over_v2 = aie::select(p_vector, 0, mask_v2_lt_p);
  aie::vector<int32_t, vec_prime> modadd = aie::sub(v2, over_v2);
  return modadd;
}

// Modulo addition for 16 elements
aie::vector<int32_t, vec_prime> vector_modadd_const(const aie::vector<int32_t, vec_prime> &v0, const aie::vector<int32_t, vec_prime> &v1, aie::vector<int32_t, vec_prime> &p_vector)
{
  aie::vector<int32_t, vec_prime> v2 = aie::add(v0, v1);
  aie::mask<vec_prime> mask_v2_lt_p = aie::lt(v2, p_vector);
  aie::vector<int32_t, vec_prime> over_v2 = aie::select(p_vector, 0, mask_v2_lt_p);
  aie::vector<int32_t, vec_prime> modadd = aie::sub(v2, over_v2);
  return modadd;
}

// Modulo subtraction for 16 elements
aie::vector<int32_t, vec_prime> vector_modsub(aie::vector<int32_t, vec_prime> &v0, aie::vector<int32_t, vec_prime> &v1, aie::vector<int32_t, vec_prime> &p_vector)
{
  aie::vector<int32_t, vec_prime> v0_plus_p = aie::add(v0, p_vector);
  aie::vector<int32_t, vec_prime> v3 = aie::sub(v0_plus_p, v1);
  aie::mask<vec_prime> mask_v3_lt_p = aie::lt(v3, p_vector);
  aie::vector<int32_t, vec_prime> over_v3 = aie::select(p_vector, 0, mask_v3_lt_p);
  aie::vector<int32_t, vec_prime> modsub = aie::sub(v3, over_v3);
  return modsub;
}

aie::vector<int32_t, vec_prime> vector_modsub_const(const aie::vector<int32_t, vec_prime> &v0, const aie::vector<int32_t, vec_prime> &v1, aie::vector<int32_t, vec_prime> &p_vector)
{
  aie::vector<int32_t, vec_prime> v0_plus_p = aie::add(v0, p_vector);
  aie::vector<int32_t, vec_prime> v3 = aie::sub(v0_plus_p, v1);
  aie::mask<vec_prime> mask_v3_lt_p = aie::lt(v3, p_vector);
  aie::vector<int32_t, vec_prime> over_v3 = aie::select(p_vector, 0, mask_v3_lt_p);
  aie::vector<int32_t, vec_prime> modsub = aie::sub(v3, over_v3);
  return modsub;
}

extern "C"
{

  // Copy from buff_1 to buff_2 using vector load/store
  void vector_copy(int32_t *buff_1, int32_t *buff_2, int32_t times)
  {
    for (int i = 0; i < times; i++)
    {
      int32_t *BF_index_1 = buff_1 + 16 * i;
      int32_t *BF_index_2 = buff_2 + 16 * i;
      aie::vector<int32_t, vec_prime> a1 = aie::load_v<vec_prime>(BF_index_1);
      aie::store_v(BF_index_2, a1);
    }
  }

  void vector_swap(int32_t *buff_1, int32_t *buff_2, int32_t start_index, int32_t repeat_times)
  {
    for (int i = 0; i < repeat_times; i++)
    {
      int32_t *BF_index_1 = buff_1 + i * vec_prime + start_index;
      int32_t *BF_index_2 = buff_2 + i * vec_prime + start_index;
      aie::vector<int32_t, vec_prime> a1 = aie::load_v<vec_prime>(BF_index_1);
      aie::vector<int32_t, vec_prime> b1 = aie::load_v<vec_prime>(BF_index_2);
      aie::store_v(BF_index_1, b1);
      aie::store_v(BF_index_2, a1);
    }
  }

  // ==================================
  // NTT operations
  // ==================================

  // DIT NTT
  void NTT_stage_down(int32_t *buff_in, int32_t *buff_out, int32_t *factor_buff, int32_t *factor_fifo_buff, int32_t stage, int32_t all_size_log, int32_t size_per_core_log, 
    int32_t modulo_q, int32_t barret_w, int32_t barret_u, int32_t w_offset)
  {
    event0();

    aie::vector<int32_t, vec_prime> q_vector = aie::broadcast<int32_t, vec_prime>(modulo_q);
    aie::vector<int32_t, vec_prime_half> q_vector_half = aie::broadcast<int32_t, vec_prime_half>(modulo_q);
    aie::vector<int32_t, vec_prime> u_vector = aie::broadcast<int32_t, vec_prime>(barret_u);
    aie::vector<int32_t, vec_prime_half> u_vector_half = aie::broadcast<int32_t, vec_prime_half>(barret_u);
    aie::vector<int32_t, vec_prime> factor_vec_1;
    aie::vector<int32_t, vec_prime> factor_vec_2;

    aie::vector<int32_t, vec_prime> factor_vec_stage;
    

    // On-the-fly compute factor vectors
    aie::vector<int32_t, vec_prime> factor_vec;
    if (stage == 1)
    {
      factor_vec = aie::broadcast<int32_t, vec_prime>(1);
    }
    else
    {
      aie::vector<int32_t, vec_prime_half> factor_vec_1_half = aie::load_v<vec_prime_half>(factor_buff);
      factor_vec_1 = aie::load_v<vec_prime>(factor_buff);
      factor_vec_stage = aie::broadcast<int32_t, vec_prime>(factor_fifo_buff[all_size_log - (stage)]);
      aie::vector<int32_t, vec_prime_half> factor_vec_stage_half = aie::broadcast<int32_t, vec_prime_half>(factor_fifo_buff[all_size_log - (stage)]);
      factor_vec_2 = vector_barrett(factor_vec_1, q_vector, factor_vec_stage, u_vector, barret_w);
      aie::vector<int32_t, vec_prime_half> factor_vec_2_half = vector_barrett_half(factor_vec_1_half, q_vector_half, factor_vec_stage_half, u_vector_half, barret_w);
      auto [res, res2] = aie::interleave_zip(factor_vec_1_half, factor_vec_2_half, 1);
      factor_vec = aie::concat(res, res2);
    }
    aie::store_v(factor_buff, factor_vec);

    if (w_offset != 1)
    {
      // Apply w_offset to factor_vec
      aie::vector<int32_t, vec_prime> w_offset_vec = aie::broadcast<int32_t, vec_prime>(w_offset);
      factor_vec_1 = vector_barrett(factor_vec_1, q_vector, w_offset_vec, u_vector, barret_w);
      factor_vec_2 = vector_barrett(factor_vec_2, q_vector, w_offset_vec, u_vector, barret_w);
    }
    
    // Compute NTT stage
    int32_t w_stage_cnt = 1 << (all_size_log - (stage - 1));
    int32_t gap = 1 << ((stage - 1) - 1);
    int32_t BF_elements = 1 << (stage - 1);
    int32_t core_half_size = 1 << (size_per_core_log - 1);

    if (stage == 1)
    {
      for (int i = 0; i < (1 << (size_per_core_log - 5)); i++)
      {
        int32_t *BF_index_in_1 = buff_in + i * vec_prime;
        int32_t *BF_index_in_2 = buff_in + i * vec_prime + core_half_size;
        aie::vector<int32_t, vec_prime> a1 = aie::load_v<vec_prime>(BF_index_in_1);
        aie::vector<int32_t, vec_prime> a2 = aie::load_v<vec_prime>(BF_index_in_2);

        if (w_offset != 1)
        {
          aie::vector<int32_t, vec_prime> w_offset_vec = aie::broadcast<int32_t, vec_prime>(w_offset);
          a2 = vector_barrett(a2, q_vector, w_offset_vec, u_vector, barret_w);
        }

        aie::vector<int32_t, vec_prime> add = vector_modadd(a1, a2, q_vector);
        aie::vector<int32_t, vec_prime> sub = vector_modsub(a1, a2, q_vector);

        int32_t *BF_index_out_1 = buff_out + i * vec_prime;
        int32_t *BF_index_out_2 = buff_out + i * vec_prime + core_half_size;
        aie::store_v(BF_index_out_1, add);
        aie::store_v(BF_index_out_2, sub);
      }
    }

    if (stage != 1)
    {
      // first half
      for (int i = 0; i < (1 << (size_per_core_log - 6)); i++)
      {
        int32_t *BF_index_in_1 = buff_in + i * vec_prime * 2;
        int32_t *BF_index_in_2 = buff_in + i * vec_prime * 2 + vec_prime;
        aie::vector<int32_t, vec_prime> a1 = aie::load_v<vec_prime>(BF_index_in_1);
        aie::vector<int32_t, vec_prime_half> a1_half = aie::filter_even(a1, gap);
        aie::vector<int32_t, vec_prime> a2 = aie::load_v<vec_prime>(BF_index_in_2);
        aie::vector<int32_t, vec_prime_half> a2_half = aie::filter_even(a2, gap);

        aie::vector<int32_t, vec_prime> b1 = aie::shuffle_down(a1, gap);
        aie::vector<int32_t, vec_prime_half> b1_half = aie::filter_even(b1, gap);
        aie::vector<int32_t, vec_prime> b2 = aie::shuffle_down(a2, gap);
        aie::vector<int32_t, vec_prime_half> b2_half = aie::filter_even(b2, gap);

        aie::vector<int32_t, vec_prime> a = aie::concat(a1_half, a2_half);
        aie::vector<int32_t, vec_prime> b = aie::concat(b1_half, b2_half);

        // TODO: why exclude stage 2 in original implementation?
        // if (stage != 2)
        // {
          // b = vector_barrett(b, q_vector, factor_vec_1, u_vector, barret_w);
        // }
        b = vector_barrett(b, q_vector, factor_vec_1, u_vector, barret_w);
        aie::vector<int32_t, vec_prime> add = vector_modadd(a, b, q_vector);
        aie::vector<int32_t, vec_prime> sub = vector_modsub(a, b, q_vector);

        auto [res, res2] = aie::interleave_zip(add, sub, gap);
        int32_t *BF_index_out_1 = buff_out + i * vec_prime * 2;
        int32_t *BF_index_out_2 = buff_out + i * vec_prime * 2 + vec_prime;
        aie::store_v(BF_index_out_1, res);
        aie::store_v(BF_index_out_2, res2);
      }

      // second half
      for (int i = 0; i < (1 << (size_per_core_log - 6)); i++)
      {
        int32_t *BF_index_in_1 = buff_in + i * vec_prime * 2 + core_half_size;
        int32_t *BF_index_in_2 = buff_in + i * vec_prime * 2 + vec_prime + core_half_size;

        aie::vector<int32_t, vec_prime> a1 = aie::load_v<vec_prime>(BF_index_in_1);
        aie::vector<int32_t, vec_prime_half> a1_half = aie::filter_even(a1, gap);
        aie::vector<int32_t, vec_prime> a2 = aie::load_v<vec_prime>(BF_index_in_2);
        aie::vector<int32_t, vec_prime_half> a2_half = aie::filter_even(a2, gap);

        aie::vector<int32_t, vec_prime> b1 = aie::shuffle_down(a1, gap);
        aie::vector<int32_t, vec_prime_half> b1_half = aie::filter_even(b1, gap);
        aie::vector<int32_t, vec_prime> b2 = aie::shuffle_down(a2, gap);
        aie::vector<int32_t, vec_prime_half> b2_half = aie::filter_even(b2, gap);

        aie::vector<int32_t, vec_prime> a = aie::concat(a1_half, a2_half);
        aie::vector<int32_t, vec_prime> b = aie::concat(b1_half, b2_half);

        b = vector_barrett(b, q_vector, factor_vec_2, u_vector, barret_w);

        aie::vector<int32_t, vec_prime> add = vector_modadd(a, b, q_vector);
        aie::vector<int32_t, vec_prime> sub = vector_modsub(a, b, q_vector);

        auto [res, res2] = aie::interleave_zip(add, sub, gap);
        int32_t *BF_index_out_1 = buff_out + i * vec_prime * 2 + core_half_size;
        int32_t *BF_index_out_2 = buff_out + i * vec_prime * 2 + vec_prime + core_half_size;
        aie::store_v(BF_index_out_1, res);
        aie::store_v(BF_index_out_2, res2);
      }
    }
    event1();
  }

  // DIF NTT
  void NTT_stage_up(int32_t *buff_in, int32_t *buff_out, int32_t *factor_buff, int32_t *factor_fifo_buff, int32_t stage, int32_t all_size_log, int32_t size_per_core_log, 
    int32_t modulo_q, int32_t barret_w, int32_t barret_u, int32_t w_offset)
  {
    event0();

    aie::vector<int32_t, vec_prime> q_vector = aie::broadcast<int32_t, vec_prime>(modulo_q);
    aie::vector<int32_t, vec_prime_half> q_vector_half = aie::broadcast<int32_t, vec_prime_half>(modulo_q);
    aie::vector<int32_t, vec_prime> u_vector = aie::broadcast<int32_t, vec_prime>(barret_u);
    aie::vector<int32_t, vec_prime_half> u_vector_half = aie::broadcast<int32_t, vec_prime_half>(barret_u);

    int32_t w_stage_cnt = 1 << (size_per_core_log - (stage - 1));
    int32_t gap = 1 << ((stage - 1) - 1);
    int32_t BF_elements = 1 << (stage - 1);
    int32_t cores_half_size = 1 << (size_per_core_log - 1);

    aie::vector<int32_t, vec_prime> factor_vec_stage = aie::broadcast<int32_t, vec_prime>(factor_fifo_buff[all_size_log - stage]);

    for (int index_reverse = 0; index_reverse < (1 << (stage - 6)); index_reverse++)
    {
      int32_t index = (1 << (stage - 6)) - index_reverse - 1;
      int32_t *factor_temp_index = factor_buff + vec_prime * index;
      aie::vector<int32_t, vec_prime> factor_vec_1 = aie::load_v<vec_prime>(factor_temp_index);
      aie::vector<int32_t, vec_prime> factor_vec_2 = vector_barrett(factor_vec_stage, q_vector, factor_vec_1, u_vector, barret_w);
      
      auto [res, res2] = aie::interleave_zip(factor_vec_1, factor_vec_2, 1);
      aie::store_v(factor_buff + index * vec_prime * 2, res);
      aie::store_v(factor_buff + index * vec_prime * 2 + vec_prime, res2);
      
      if (w_offset != 1)
      {
        // Apply w_offset to factor_vec_stage
        aie::vector<int32_t, vec_prime> w_offset_vec = aie::broadcast<int32_t, vec_prime>(w_offset);
        factor_vec_1 = vector_barrett(factor_vec_1, q_vector, w_offset_vec, u_vector, barret_w);
        factor_vec_2 = vector_barrett(factor_vec_2, q_vector, w_offset_vec, u_vector, barret_w);
      }

      for (int BF_set = 0; BF_set < (w_stage_cnt >> 1); BF_set++)
      {
        int32_t *BF_index_in_1 = buff_in + BF_elements * BF_set + index * vec_prime;
        int32_t *BF_index_in_2 = buff_in + BF_elements * BF_set + index * vec_prime + cores_half_size;
        aie::vector<int32_t, vec_prime> a1 = aie::load_v<vec_prime>(BF_index_in_1);
        aie::vector<int32_t, vec_prime> b1 = aie::load_v<vec_prime>(BF_index_in_1 + gap);
        aie::vector<int32_t, vec_prime> barret = vector_barrett(b1, q_vector, factor_vec_1, u_vector, barret_w);
        aie::vector<int32_t, vec_prime> add = vector_modadd(a1, barret, q_vector);
        aie::vector<int32_t, vec_prime> sub = vector_modsub(a1, barret, q_vector);
        int32_t *BF_index_out_1 = buff_out + BF_elements * BF_set + index * vec_prime;
        int32_t *BF_index_out_gap_1 = buff_out + BF_elements * BF_set + index * vec_prime + gap;
        aie::store_v(BF_index_out_1, add);
        aie::store_v(BF_index_out_gap_1, sub);

        aie::vector<int32_t, vec_prime> a2 = aie::load_v<vec_prime>(BF_index_in_2);
        aie::vector<int32_t, vec_prime> b2 = aie::load_v<vec_prime>(BF_index_in_2 + gap);
        aie::vector<int32_t, vec_prime> barret_2 = vector_barrett(b2, q_vector, factor_vec_2, u_vector, barret_w);
        aie::vector<int32_t, vec_prime> add_2 = vector_modadd(a2, barret_2, q_vector);
        aie::vector<int32_t, vec_prime> sub_2 = vector_modsub(a2, barret_2, q_vector);
        int32_t *BF_index_out_2 = buff_out + BF_elements * BF_set + index * vec_prime + cores_half_size;
        int32_t *BF_index_out_gap_2 = buff_out + BF_elements * BF_set + index * vec_prime + gap + cores_half_size;
        aie::store_v(BF_index_out_2, add_2);
        aie::store_v(BF_index_out_gap_2, sub_2);
      }
    }

    event1();
  }

  void NTT_stage_next_up_down(int32_t *buff_in_1, int32_t *buff_in_2, int32_t *buff_out_1, int32_t *buff_out_2, int32_t *factor_buff, int32_t *factor_fifo_buff, int32_t factor_scalar, int32_t factor_scalar_index, int32_t half_bool, int32_t stage, int32_t all_size_log, int32_t size_per_core_log, int32_t times, 
    int32_t modulo_q, int32_t barret_w, int32_t barret_u, int32_t if_debug, int if_store_factor)
  {
    // factor_scale : 基準のfactor_buffに "factor_scale倍して計算をしていく"
    // CT3()ComputeTile_2では
    // 1回目の時 1 = W^0
    // 2回目の時　(W^(cores_elements)*1+cores_elements/(16*2)*0 )前半は 2(mod 4) > 1 後半は　1(mod 2) < 1のため
    // この計算はPythonサイドで行いたい
    // halfは計算のスタートをbuffの半分より上から取り出すか否かの boolen
    //
    event0();

    aie::vector<int32_t, vec_prime> q_vector = aie::broadcast<int32_t, vec_prime>(modulo_q);
    aie::vector<int32_t, vec_prime> u_vector = aie::broadcast<int32_t, vec_prime>(barret_u);

    if (factor_scalar == -1) {
      // compute factor_scalar from factor_scalar_index
      aie::vector<int32_t, vec_prime> scalar_vec = aie::broadcast<int32_t, vec_prime>(factor_fifo_buff[all_size_log - stage + size_per_core_log]);
      aie::vector<int32_t, vec_prime> res = aie::broadcast<int32_t, vec_prime>(1);
      for (int32_t i = 0; i < factor_scalar_index; i++) {
        res = vector_barrett(res, q_vector, scalar_vec, u_vector, barret_w);
      }
      factor_scalar = res[0];
    }
    
    // Generate factor_vec for next stage
    // このstageでは、loadしたfactor_vecを
    // (i) half_bool == 0 のときはそのまま使う
    // (ii) half_bool == 1 のときは factor_scalar倍したものを使う
    // 次のstageのために、factor_vecとfactor_vec * factor_scalarのzipしたものをfactor_buffに保存する
    aie::vector<int32_t, vec_prime> factor_vec = aie::load_v<vec_prime>(factor_buff);
    if (if_store_factor == 1)
    {
      aie::vector<int32_t, vec_prime> factor_vec_1 = aie::load_v<vec_prime>(factor_buff);
      aie::vector<int32_t, vec_prime> factor_vec_stage = aie::broadcast<int32_t, vec_prime>(factor_fifo_buff[all_size_log - stage]);
      aie::vector<int32_t, vec_prime> factor_vec_2 = vector_barrett(factor_vec_1, q_vector, factor_vec_stage, u_vector, barret_w);
      auto zipped = aie::interleave_zip(factor_vec_1, factor_vec_2, 1);
      aie::store_v(factor_buff, zipped.first);
    }

    // Compute Twiddle factor's index
    if (half_bool == 1)
    {
      factor_scalar = barrett(factor_scalar, modulo_q, factor_fifo_buff[all_size_log - stage], barret_u, barret_w);
    }
    aie::vector<int32_t, vec_prime> factor_scalar_vec = aie::broadcast<int32_t, vec_prime>(factor_scalar);
    factor_vec = vector_barrett(factor_scalar_vec, q_vector, factor_vec, u_vector, barret_w);
    aie::vector<int32_t, vec_prime> factor_vec_stage_2_full = aie::broadcast<int32_t, vec_prime>(factor_fifo_buff[all_size_log - stage + 5]);

    int32_t half = half_bool * (1 << (size_per_core_log - 1));

    // Compute NTT stage
    for (int index = 0; index < times; index++)
    {
      int32_t *BF_index_in_1 = buff_in_1 + index * vec_prime + half;
      int32_t *BF_index_in_2 = buff_in_2 + index * vec_prime + half;
      aie::vector<int32_t, vec_prime> a1 = aie::load_v<vec_prime>(BF_index_in_1);
      aie::vector<int32_t, vec_prime> b1 = aie::load_v<vec_prime>(BF_index_in_2);

      aie::vector<int32_t, vec_prime> barret = vector_barrett(b1, q_vector, factor_vec, u_vector, barret_w);
      aie::vector<int32_t, vec_prime> add = vector_modadd(a1, barret, q_vector);
      aie::vector<int32_t, vec_prime> sub = vector_modsub(a1, barret, q_vector);

      int32_t *BF_index_out_1 = buff_out_1 + index * vec_prime + half;
      int32_t *BF_index_out_2 = buff_out_2 + index * vec_prime + half;

      aie::store_v(BF_index_out_1, add);
      aie::store_v(BF_index_out_2, sub);

      factor_vec = vector_barrett(factor_vec, q_vector, factor_vec_stage_2_full, u_vector, barret_w);
    }
    event1();
  }

  int32_t pow_from_table(int32_t exponent, int32_t *table, int32_t table_size, int32_t modulo_q, int barret_w, int barret_u)
  {
    int32_t res = 1;
    for (int32_t i = 0; i < table_size; i++){
      if (exponent & (1 << i)){
        res = barrett(res, modulo_q, table[i], barret_u, barret_w);
      }
    }
    return res;
  }

  // NOTICE: current_ntt_log must be greater than or equal to 6
  void multi_NTT_in_a_tile(int32_t *buff_in, int32_t *buff_out, int32_t *factor_buff, int32_t *factor_fifo_buff, int all_size_log, int buff_size_log, int current_ntt_log, 
    int32_t modulo_q, int32_t barret_w, int32_t barret_u, int32_t w_offset_pow, int32_t if_phase2)
  {
    const int loops = 1 << (buff_size_log - current_ntt_log);
    const int ntt_size = 1 << (current_ntt_log);

    for (int idx_loop = 0; idx_loop < loops; idx_loop++)
    {
      const int offset = idx_loop * ntt_size;
      int32_t *buff_i = buff_in + offset;
      
      // NTT
      if (if_phase2) {
        int offset_exponent = (w_offset_pow + idx_loop) << current_ntt_log;
        for (int stage = 1; stage < 6; stage++){
          offset_exponent >>= 1;
          int w_offset = pow_from_table(offset_exponent, factor_fifo_buff, all_size_log, modulo_q, barret_w, barret_u);
          NTT_stage_down(buff_i, buff_i, factor_buff, factor_fifo_buff, stage, all_size_log, current_ntt_log, modulo_q, barret_w, barret_u, w_offset);
        }
        for (int stage = 6; stage < current_ntt_log + 1; stage++){
          offset_exponent >>= 1;
          int w_offset = pow_from_table(offset_exponent, factor_fifo_buff, all_size_log, modulo_q, barret_w, barret_u);
          NTT_stage_up(buff_i, buff_i, factor_buff, factor_fifo_buff, stage, all_size_log, current_ntt_log, modulo_q, barret_w, barret_u, w_offset);
        }
      } else {
        int w_offset = 1;
        for (int stage = 1; stage < 6; stage++){
          NTT_stage_down(buff_i, buff_i, factor_buff, factor_fifo_buff, stage, all_size_log, current_ntt_log, modulo_q, barret_w, barret_u, w_offset);
        }
        for (int stage = 6; stage < current_ntt_log + 1; stage++){
          NTT_stage_up(buff_i, buff_i, factor_buff, factor_fifo_buff, stage, all_size_log, current_ntt_log, modulo_q, barret_w, barret_u, w_offset);
        }
      }
    }
  }

} // extern "C"
