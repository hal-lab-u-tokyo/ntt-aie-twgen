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



aie::vector<int32_t, vec_prime> vector_barrett(aie::vector<int32_t, vec_prime> &v, aie::vector<int32_t, vec_prime> &p_vec, aie::vector<int32_t, vec_prime> &factor_vec, aie::vector<int32_t, vec_prime> &u_vec, int32_t w){

  event0();
  aie::accum<acc64, vec_prime> t = aie::mul(v, factor_vec);
  aie::vector<int32_t, vec_prime> x_1 = t.template to_vector<int32_t>(w - 2);
  aie::accum<acc64, vec_prime> x_2 = aie::mul(x_1, u_vec);
  aie::vector<int32_t, vec_prime> s = x_2.template to_vector<int32_t>(w + 2);
  aie::accum<acc64, vec_prime> r = aie::mul(s, p_vec);
  aie::vector<int32_t, vec_prime> tt = t.template to_vector<int32_t>(0);
  aie::vector<int32_t, vec_prime> rr = r.template to_vector<int32_t>(0);
  aie::vector<int32_t, vec_prime> c = aie::sub(tt, rr);
  aie::mask<vec_prime> mask_c_lt_p = aie::lt(c, p_vec);
  aie::vector<int32_t, vec_prime> over_c = aie::select(p_vec, 0, mask_c_lt_p);
  aie::vector<int32_t, vec_prime> barrett = aie::sub(c, over_c);
  event1();
  return barrett;
}


aie::vector<int32_t, vec_prime_half> vector_barrett_half(aie::vector<int32_t, vec_prime_half> &v, aie::vector<int32_t, vec_prime_half> &p_vec, aie::vector<int32_t, vec_prime_half> &factor_vec, aie::vector<int32_t, vec_prime_half> &u_vec, int32_t w){
  event0();
    aie::accum<acc64, vec_prime_half> t = aie::mul(v, factor_vec);
    aie::vector<int32_t, vec_prime_half> x_1 = t.template to_vector<int32_t>(w - 2);
    aie::accum<acc64, vec_prime_half> x_2 = aie::mul(x_1, u_vec);
    aie::vector<int32_t, vec_prime_half> s = x_2.template to_vector<int32_t>(w + 2);
    aie::accum<acc64, vec_prime_half> r = aie::mul(s, p_vec);
    aie::vector<int32_t, vec_prime_half> tt = t.template to_vector<int32_t>(0);
    aie::vector<int32_t, vec_prime_half> rr = r.template to_vector<int32_t>(0);
    aie::vector<int32_t, vec_prime_half> c = aie::sub(tt, rr);
    aie::mask<vec_prime_half> mask_c_lt_p = aie::lt(c, p_vec);
    aie::vector<int32_t, vec_prime_half> over_c = aie::select(p_vec, 0, mask_c_lt_p);
    aie::vector<int32_t, vec_prime_half> barrett = aie::sub(c, over_c);
  event1();
  return barrett;
}


aie::vector<int32_t, vec_prime> vector_modadd(aie::vector<int32_t, vec_prime> &v0, aie::vector<int32_t, vec_prime> &v1, aie::vector<int32_t, vec_prime> &p_vector){
  aie::vector<int32_t, vec_prime> v2 = aie::add(v0, v1);
  aie::mask<vec_prime> mask_v2_lt_p = aie::lt(v2, p_vector);
  aie::vector<int32_t, vec_prime> over_v2 = aie::select(p_vector, 0, mask_v2_lt_p);
  aie::vector<int32_t, vec_prime> modadd = aie::sub(v2, over_v2);
  return modadd;
}

aie::vector<int32_t, vec_prime> vector_modsub(aie::vector<int32_t, vec_prime> &v0, aie::vector<int32_t, vec_prime> &v1, aie::vector<int32_t, vec_prime> &p_vector){
  aie::vector<int32_t, vec_prime> v0_plus_p = aie::add(v0, p_vector);
  aie::vector<int32_t, vec_prime> v3 = aie::sub(v0_plus_p, v1);
  aie::mask<vec_prime> mask_v3_lt_p = aie::lt(v3, p_vector);
  aie::vector<int32_t, vec_prime> over_v3 = aie::select(p_vector, 0, mask_v3_lt_p);
  aie::vector<int32_t, vec_prime> modsub = aie::sub(v3, over_v3);
  return modsub;
}

int32_t barrett_2k(int32_t a, int32_t b, int32_t q, int32_t w, int32_t u){
	int64_t t = (int64_t)a *(int64_t) b;
	int64_t x_1 = t >> (w - 2);
	int64_t x_2 = u * x_1;
	int64_t s = x_2 >> (w + 2);
	int64_t r = s * q;
	int64_t c = t - r;
	if (c >= q) {
		return c - q;
	}else {
		return c;
	}
}

int32_t modadd(int32_t a, int32_t b, int32_t q){
  int ret = a + b;
  if (ret >= q){
    return ret - q;
  }
  return ret;
}

int32_t modsub(int32_t a, int32_t b, int32_t q){
  int ret = a + q - b;
  if (ret >= q){
    return ret - q;
  }
  return ret;
}





extern "C" {


void store_func(int32_t *buff_1, int32_t *buff_2,int32_t times){
  for(int i=0;i<times;i++){
    int32_t *BF_index_1 = buff_1 + 16*i;
    int32_t *BF_index_2 = buff_2 + 16*i;
    aie::vector<int32_t, vec_prime> a1 = aie::load_v<vec_prime>(BF_index_1);
    aie::store_v(BF_index_2,a1);
  }
}




void swap(int32_t *buff_1, int32_t *buff_2,int32_t start_index,int32_t repeat_times){
  for(int i=0;i<repeat_times;i++){
    int32_t *BF_index_1 = buff_1 + i * vec_prime + start_index;
    int32_t *BF_index_2 = buff_2 + i * vec_prime + start_index;
    aie::vector<int32_t, vec_prime> a1 = aie::load_v<vec_prime>(BF_index_1);
    aie::vector<int32_t, vec_prime> b1 = aie::load_v<vec_prime>(BF_index_2);
    aie::store_v(BF_index_1,b1);
    aie::store_v(BF_index_2,a1);
  }
}

void BF_calc(int32_t *list, int32_t *buff_factor, int32_t factor_stage,int32_t cores_elements_log,int32_t modulo_q,int32_t time) {
  // event0();
  aie::vector<int32_t, vec_prime>q_vector = aie::broadcast<int32_t, vec_prime>(modulo_q);
  aie::vector<int32_t, vec_prime>u_vector = aie::broadcast<int32_t, vec_prime>(barret_u);
  aie::vector<int32_t, vec_prime> factor_vector = aie::load_v<vec_prime>(buff_factor);
  for(int i=0; i< time;i++){
    int32_t *__restrict pA_i = list + i * vec_prime;
    aie::vector<int32_t, vec_prime> v0 = aie::load_v<vec_prime>(pA_i);
    aie::vector<int32_t, vec_prime> barret = vector_barrett(v0, q_vector,  factor_vector, u_vector ,barret_w);
    aie::store_v(pA_i, barret);
  
  }
  // event1();
}


void NTT_stage_down(int32_t *buff_in,int32_t * buff_out,int32_t *factor_buff,int32_t *factor_fifo_buff,int32_t stage,int32_t all_size_log,int32_t cores_size_log,int32_t modulo_q, int32_t barret_w, int32_t barret_u){
  // event0();
  
  aie::vector<int32_t, vec_prime> q_vector = aie::broadcast<int32_t, vec_prime>(modulo_q);
  aie::vector<int32_t, vec_prime_half> q_vector_half = aie::broadcast<int32_t, vec_prime_half>(modulo_q);
  aie::vector<int32_t, vec_prime> u_vector = aie::broadcast<int32_t, vec_prime>(barret_u);
  aie::vector<int32_t, vec_prime_half> u_vector_half = aie::broadcast<int32_t, vec_prime_half>(barret_u);
  aie::vector<int32_t, vec_prime> factor_vec_1;
  aie::vector<int32_t, vec_prime> factor_vec_2;
  

  aie::vector<int32_t, vec_prime> factor_vec;
  if (stage==1){
    factor_vec = aie::broadcast<int32_t, vec_prime>(1);
  }
  else{
    aie::vector<int32_t, vec_prime_half>factor_vec_1_half = aie::load_v<vec_prime_half>(factor_buff);
    factor_vec_1 = aie::load_v<vec_prime>(factor_buff);
    aie::vector<int32_t, vec_prime> factor_vec_stage = aie::broadcast<int32_t, vec_prime>(factor_fifo_buff[all_size_log-(stage)]);
    aie::vector<int32_t, vec_prime_half> factor_vec_stage_half = aie::broadcast<int32_t, vec_prime_half>(factor_fifo_buff[all_size_log-(stage)]);
    factor_vec_2 = vector_barrett(factor_vec_1, q_vector,factor_vec_stage,u_vector,barret_w);
    aie::vector<int32_t, vec_prime_half>  factor_vec_2_half = vector_barrett_half(factor_vec_1_half, q_vector_half,factor_vec_stage_half,u_vector_half,barret_w);
    auto [res, res2] = aie::interleave_zip(factor_vec_1_half, factor_vec_2_half, 1);
    factor_vec =  aie::concat(res, res2);
  }

  aie::store_v(factor_buff, factor_vec);
  int32_t w_stage_cnt = 1 << (all_size_log - (stage-1));
  int32_t gap = 1 << ((stage-1) - 1);
  int32_t BF_elements = 1 << (stage-1);
  int32_t core_half_size = 1<<(cores_size_log-1);

  
  if(stage==1){
    for(int i=0;i<(1 << (cores_size_log-5));i++){
      int32_t *BF_index_in_1 = buff_in + i * vec_prime;
      int32_t *BF_index_in_2 = buff_in + i * vec_prime + core_half_size;
      aie::vector<int32_t, vec_prime> a1 = aie::load_v<vec_prime>(BF_index_in_1);
      aie::vector<int32_t, vec_prime> a2 = aie::load_v<vec_prime>(BF_index_in_2);

      aie::vector<int32_t, vec_prime> add = vector_modadd(a1, a2, q_vector);
      aie::vector<int32_t, vec_prime> sub = vector_modsub(a1, a2, q_vector);

      int32_t *BF_index_out_1 = buff_out + i * vec_prime;
      int32_t *BF_index_out_2 = buff_out + i * vec_prime + core_half_size;
      aie::store_v(BF_index_out_1, add);
      aie::store_v(BF_index_out_2, sub);
    }
  }
 
  if(stage!=1){
    for(int i=0;i<(1 << (cores_size_log-6));i++){
      int32_t *BF_index_in_1 = buff_in + i * vec_prime*2;
      int32_t *BF_index_in_2 = buff_in + i * vec_prime*2 + vec_prime;
      aie::vector<int32_t, vec_prime> a1 = aie::load_v<vec_prime>(BF_index_in_1);
      aie::vector<int32_t, vec_prime_half> a1_half = aie::filter_even(a1,gap);
      aie::vector<int32_t, vec_prime> a2 = aie::load_v<vec_prime>(BF_index_in_2);
      aie::vector<int32_t, vec_prime_half> a2_half = aie::filter_even(a2,gap);

      aie::vector<int32_t, vec_prime> b1 = aie::shuffle_down(a1, gap);
      aie::vector<int32_t, vec_prime_half> b1_half = aie::filter_even(b1,gap);
      aie::vector<int32_t, vec_prime> b2 = aie::shuffle_down(a2, gap);
      aie::vector<int32_t, vec_prime_half> b2_half = aie::filter_even(b2,gap);

      aie::vector<int32_t, vec_prime> a =  aie::concat(a1_half, a2_half);
      aie::vector<int32_t, vec_prime> b =  aie::concat(b1_half, b2_half);

      if(stage != 2){
        b = vector_barrett(b, q_vector, factor_vec_1,u_vector, barret_w);
      }
      aie::vector<int32_t, vec_prime> add = vector_modadd(a, b, q_vector);
      aie::vector<int32_t, vec_prime> sub = vector_modsub(a, b, q_vector);


      auto [res, res2] = aie::interleave_zip(add, sub, gap);
      int32_t *BF_index_out_1 = buff_out + i * vec_prime*2;
      int32_t *BF_index_out_2 = buff_out + i * vec_prime*2 + vec_prime;
      aie::store_v(BF_index_out_1, res);
      aie::store_v(BF_index_out_2, res2);
    }

    for(int i=0;i<(1 << (cores_size_log-6));i++){
      int32_t *BF_index_in_1 = buff_in + i * vec_prime*2 + core_half_size;
      int32_t *BF_index_in_2 = buff_in + i * vec_prime*2 + vec_prime + core_half_size;

      aie::vector<int32_t, vec_prime> a1 = aie::load_v<vec_prime>(BF_index_in_1);
      aie::vector<int32_t, vec_prime_half> a1_half = aie::filter_even(a1,gap);
      aie::vector<int32_t, vec_prime> a2 = aie::load_v<vec_prime>(BF_index_in_2);
      aie::vector<int32_t, vec_prime_half> a2_half = aie::filter_even(a2,gap);

      aie::vector<int32_t, vec_prime> b1 = aie::shuffle_down(a1, gap);
      aie::vector<int32_t, vec_prime_half> b1_half = aie::filter_even(b1,gap);
      aie::vector<int32_t, vec_prime> b2 = aie::shuffle_down(a2, gap);
      aie::vector<int32_t, vec_prime_half> b2_half = aie::filter_even(b2,gap);

      aie::vector<int32_t, vec_prime> a =  aie::concat(a1_half, a2_half);
      aie::vector<int32_t, vec_prime> b =  aie::concat(b1_half, b2_half);

      b = vector_barrett(b, q_vector, factor_vec_2,u_vector, barret_w);

      aie::vector<int32_t, vec_prime> add = vector_modadd(a, b, q_vector);
      aie::vector<int32_t, vec_prime> sub = vector_modsub(a, b, q_vector);


      auto [res, res2] = aie::interleave_zip(add, sub, gap);
      int32_t *BF_index_out_1 = buff_out + i * vec_prime*2 + core_half_size;
      int32_t *BF_index_out_2 = buff_out + i * vec_prime*2 + vec_prime+ core_half_size;
      aie::store_v(BF_index_out_1, res);
      aie::store_v(BF_index_out_2, res2);
    }
  }
  // event1();
}


void NTT_stage_up(int32_t *buff_in,int32_t *buff_out,int32_t *factor_buff,int32_t *factor_fifo_buff,int32_t stage, int32_t all_size_log,int32_t cores_size_log,int32_t modulo_q, int32_t barret_w, int32_t barret_u){
  // event0();
  
  aie::vector<int32_t, vec_prime> q_vector = aie::broadcast<int32_t, vec_prime>(modulo_q);
  aie::vector<int32_t, vec_prime_half> q_vector_half = aie::broadcast<int32_t, vec_prime_half>(modulo_q);
  aie::vector<int32_t, vec_prime> u_vector = aie::broadcast<int32_t, vec_prime>(barret_u);
  aie::vector<int32_t, vec_prime_half> u_vector_half = aie::broadcast<int32_t, vec_prime_half>(barret_u);
  
  
  int32_t  w_stage_cnt = 1 << (cores_size_log-(stage-1));
  int32_t gap = 1 << ((stage-1)-1);
  int32_t BF_elements = 1 << (stage-1);
  int32_t cores_half_size = 1<< (cores_size_log-1);

  aie::vector<int32_t, vec_prime> factor_vec_stage = aie::broadcast<int32_t, vec_prime>(factor_fifo_buff[all_size_log-stage]);
  // 前からやっていくと消す可能性あるけど後ろからやっていけば消えないのでは？？
  for (int index_reverse=0;index_reverse < (1<< (stage-6));index_reverse++){
    int32_t index = (1<< (stage-6)) - index_reverse -1;
    int32_t *factor_temp_index = factor_buff + vec_prime*index;
    aie::vector<int32_t, vec_prime> factor_vec_1 = aie::load_v<vec_prime>(factor_temp_index);
    aie::vector<int32_t, vec_prime> factor_vec_2 = vector_barrett(factor_vec_stage, q_vector, factor_vec_1,u_vector, barret_w);
    // エラー出るから足してみた
    for (int BF_set=0;BF_set< (w_stage_cnt>>1);BF_set++){
      int32_t *BF_index_in_1 = buff_in + BF_elements*BF_set + index * vec_prime;
      int32_t *BF_index_in_2 = buff_in + BF_elements*BF_set + index * vec_prime + cores_half_size;
      aie::vector<int32_t, vec_prime> a1 = aie::load_v<vec_prime>(BF_index_in_1);
      aie::vector<int32_t, vec_prime> b1 = aie::load_v<vec_prime>(BF_index_in_1+gap);
      aie::vector<int32_t, vec_prime> barret = vector_barrett(b1, q_vector, factor_vec_1,u_vector, barret_w);
      aie::vector<int32_t, vec_prime> add = vector_modadd(a1, barret, q_vector);
      aie::vector<int32_t, vec_prime> sub = vector_modsub(a1, barret, q_vector);
      int32_t *BF_index_out_1 = buff_out + BF_elements*BF_set + index * vec_prime;
      int32_t *BF_index_out_gap_1 = buff_out + BF_elements*BF_set + index * vec_prime + gap;
      aie::store_v(BF_index_out_1, add);
      aie::store_v(BF_index_out_gap_1,sub);

      // これ再度定義しないとだめ
      aie::vector<int32_t, vec_prime>a2 = aie::load_v<vec_prime>(BF_index_in_2);
      aie::vector<int32_t, vec_prime>b2 = aie::load_v<vec_prime>(BF_index_in_2+gap);
      aie::vector<int32_t, vec_prime>barret_2 = vector_barrett(b2, q_vector, factor_vec_2,u_vector, barret_w);
      aie::vector<int32_t, vec_prime>add_2 = vector_modadd(a2, barret_2, q_vector);
      aie::vector<int32_t, vec_prime>sub_2 = vector_modsub(a2, barret_2, q_vector);
      int32_t *BF_index_out_2 = buff_out + BF_elements*BF_set + index * vec_prime + cores_half_size;
      int32_t *BF_index_out_gap_2 = buff_out + BF_elements*BF_set + index * vec_prime + gap + cores_half_size;
      aie::store_v(BF_index_out_2,add_2);
      aie::store_v(BF_index_out_gap_2,sub_2);
    }

    auto [res, res2] = aie::interleave_zip(factor_vec_1, factor_vec_2, 1);
    aie::store_v(factor_buff + index*vec_prime*2 , res);
    aie::store_v(factor_buff + index*vec_prime*2 + vec_prime, res2);
  }
  
  

  // event1();
}



void NTT_stage_next_up_down(int32_t *buff_in_1,int32_t *buff_in_2,int32_t *buff_out_1,int32_t *buff_out_2,int32_t *factor_buff,int32_t *factor_fifo_buff,int32_t factor_scalar,int32_t half_bool,int32_t stage, int32_t all_size_log,int32_t cores_size_log,int32_t times,int32_t modulo_q, int32_t barret_w, int32_t barret_u){
  // factor_scale : 基準のfactor_buffに "factor_scale倍して計算をしていく"
  // CT3()ComputeTile_2では
  // 1回目の時 1 = W^0 
  // 2回目の時　(W^(cores_elements)*1+cores_elements/(16*2)*0 )前半は 2(mod 4) > 1 後半は　1(mod 2) < 1のため
  // この計算はPythonサイドで行いたい
  // halfは計算のスタートをbuffの半分より上から取り出すか否かの boolen
  // 
  // event0();
  
  aie::vector<int32_t, vec_prime> q_vector = aie::broadcast<int32_t, vec_prime>(modulo_q);
  aie::vector<int32_t, vec_prime_half> q_vector_half = aie::broadcast<int32_t, vec_prime_half>(modulo_q);
  aie::vector<int32_t, vec_prime> u_vector = aie::broadcast<int32_t, vec_prime>(barret_u);
  aie::vector<int32_t, vec_prime_half> u_vector_half = aie::broadcast<int32_t, vec_prime_half>(barret_u);
  

  aie::vector<int32_t, vec_prime_half> factor_vec_1 = aie::load_v<vec_prime_half>(factor_buff);
  aie::vector<int32_t, vec_prime_half> factor_vec_stage_half = aie::broadcast<int32_t, vec_prime_half>(factor_fifo_buff[all_size_log-stage]);

  // aie::vector<int32_t, vec_prime> factor_vec_stage_full = aie::broadcast<int32_t, vec_prime>(factor_fifo_buff[all_size_log-stage]);
  aie::vector<int32_t, vec_prime_half> factor_vec_2 = vector_barrett_half(factor_vec_1, q_vector_half,factor_vec_stage_half,u_vector_half,barret_w);
  auto [res, res2] = aie::interleave_zip(factor_vec_1, factor_vec_2, 1);
  aie::vector<int32_t, vec_prime> factor_vec =  aie::concat(res, res2);
  aie::store_v(factor_buff, factor_vec);

  // ここは上下で変わる
  aie::vector<int32_t, vec_prime> factor_scalar_vec = aie::broadcast<int32_t, vec_prime>(factor_scalar);
  factor_vec = vector_barrett(factor_scalar_vec, q_vector, factor_vec,u_vector, barret_w);
  aie::vector<int32_t, vec_prime> factor_vec_stage_2_full = aie::broadcast<int32_t, vec_prime>(factor_fifo_buff[all_size_log-stage+4]);
  
  int32_t half = half_bool*(1 << (cores_size_log-1));
  // int32_t half = 0;

  for (int index=0;index < times;index++){
    int32_t *BF_index_in_1 = buff_in_1+  index * vec_prime + half;
    int32_t *BF_index_in_2 = buff_in_2 + index * vec_prime + half;
    aie::vector<int32_t, vec_prime> a1 = aie::load_v<vec_prime>(BF_index_in_1);
    aie::vector<int32_t, vec_prime> b1 = aie::load_v<vec_prime>(BF_index_in_2);
    
    aie::vector<int32_t, vec_prime> barret = vector_barrett(b1, q_vector, factor_vec,u_vector, barret_w);
    aie::vector<int32_t, vec_prime> add = vector_modadd(a1, barret, q_vector);
    aie::vector<int32_t, vec_prime> sub = vector_modsub(a1, barret, q_vector);

    int32_t *BF_index_out_1 = buff_out_1+  index * vec_prime + half;
    int32_t *BF_index_out_2 = buff_out_2 + index * vec_prime + half;

    aie::store_v(BF_index_out_1, add);
    aie::store_v(BF_index_out_2,sub);
    factor_vec = vector_barrett(factor_vec, q_vector,factor_vec_stage_2_full,u_vector,barret_w);
  }
  // event1();
}





} // extern "C"

/*

