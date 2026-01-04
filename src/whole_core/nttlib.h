#pragma once

void ntt_cpu(int *data, int logN, int W, int MOD, bool inverse, int stop_stage_for_debug = -1);
int power(int base, int exp, int mod);

int bit_reverse(int x, int logN);
void vector_bit_reverse(int *data, int logN);
void vector_bit_reverse_and_separate(int *data, int logN, int logN_per_core);