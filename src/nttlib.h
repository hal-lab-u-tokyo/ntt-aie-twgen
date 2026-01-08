#pragma once

void ntt_cpu(int *data, int logN, int W, int MOD, bool inverse, int stop_stage_for_debug = -1);
void divided_ntt_inplace(int *data, int logN, int W, int MOD, int stage_limit, bool inverse);
int power(int base, int exp, int mod);
int rotl(int x, int i, int m);
int bit_reverse(int x, int logN);
void vector_bit_reverse(int *data, int logN);
