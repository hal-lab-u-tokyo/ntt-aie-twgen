#pragma once

void ntt_cpu(uint32_t *data, uint32_t logN, uint32_t W, uint32_t MOD, bool inverse);
uint32_t power(uint32_t base, uint32_t exp, uint32_t mod);

uint32_t bit_reverse(uint32_t x, int logN);
void vector_bit_reverse(uint32_t *data, uint32_t logN);