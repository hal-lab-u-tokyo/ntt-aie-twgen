#include <cmath>
#include <cstdint>
#include <cstdio>
#include <algorithm>

uint32_t power(uint32_t base, uint32_t exp, uint32_t mod)
{
    uint32_t res = 1;
    base %= mod;
    while (exp > 0)
    {
        if (exp % 2 == 1)
            res = ((uint64_t)res * base) % mod;
        base = ((uint64_t)base * base) % mod;
        exp /= 2;
    }
    return res;
}

uint32_t modInverse(uint32_t n, uint32_t mod)
{
    return power(n, mod - 2, mod);
}

uint32_t bit_reverse(uint32_t x, int logN)
{
    uint32_t res = 0;
    for (int i = 0; i < logN; ++i)
    {
        res <<= 1;
        res |= (x & 1);
        x >>= 1;
    }
    return res;
}

void vector_bit_reverse(uint32_t *data, uint32_t logN)
{
    const uint32_t N = 1 << logN;
    uint32_t *buff = new uint32_t[N];
    for (uint32_t i = 0; i < N; ++i)
    {
        buff[i] = data[i];
    }
    for (int i = 0; i < N; ++i)
    {
        data[i] = buff[bit_reverse(i, logN)];
    }
    delete[] buff;
    return;
}

// Bitreverse and separate odd-even bits
// Excmple:
// input: [0, 1, 2, 3, 4, 5, 6, 7]
// bit-reverse: [0, 4, 2, 6, 1, 5, 3, 7]
// separate odd-even bits: [0, 2, 1, 3, 4, 6, 5, 7]
void vector_bit_reverse_and_separate(uint32_t *data, uint32_t logN, uint32_t logN_per_core)
{
    int N = 1 << logN;
    int32_t single_size = 1 << logN_per_core;
    int32_t *temp_ls = new int32_t[N];
    for (int i = 0; i < N; i++)
    {
        temp_ls[i] = data[i];
    }
    for (int i = 0; i < N; ++i)
    {
        int reversed_index = bit_reverse(i, logN);
        int32_t odd_even_bit = (reversed_index >> (0)) & 1;
        int32_t idx_block = reversed_index / single_size;
        int32_t idx_in_block = reversed_index % single_size;
        int32_t new_index = ((idx_in_block - odd_even_bit) >> 1) + (odd_even_bit * (1 << (logN_per_core - 1))) + idx_block * single_size;
        data[new_index] = temp_ls[i];
    }

    delete[] temp_ls;
}

uint32_t mod_mul(uint32_t a, uint32_t b, uint32_t mod)
{
    return ((uint64_t)a * b) % mod;
}

// NTT
// data: bit-reversed input/output array
void ntt_cpu(uint32_t *data, uint32_t logN, uint32_t W, uint32_t MOD, bool inverse, uint32_t stop_stage_for_debug)
{
    int N = 1 << logN;
    uint32_t current_W = W;
    if (inverse)
    {
        current_W = modInverse(W, MOD);
    }

    uint32_t pow_step = 1LL << logN;
    uint32_t idx_step = 1LL;

    uint32_t ws, half, wi, u, v, term;
    for (uint32_t s = 0; s < logN; ++s)
    {
        pow_step >>= 1;
        ws = power(current_W, pow_step, MOD);

        half = idx_step;
        idx_step <<= 1;

        for (uint32_t p = 0; p < N; p += idx_step)
        {
            wi = 1;
            int wi_index = 0;
            for (uint32_t i = p; i < p + half; ++i)
            {
                uint32_t j = i + half;

                u = data[i];
                v = data[j];

                term = mod_mul(wi, v, MOD);

                data[i] = (u + term) % MOD;
                data[j] = (u - term + MOD) % MOD;

                // printf("butterfly: data[%u]=%u, data[%u]=%u, tw_idx=%d\n", i, data[i], j, data[j], wi_index);

                wi = mod_mul(wi, ws, MOD);
                wi_index += pow_step;
            }
        }

        if (stop_stage_for_debug == (s + 1))
        {
            return;
        }
    }

    if (inverse)
    {
        uint32_t inv_n = modInverse(N, MOD);
        for (uint32_t i = 0; i < N; ++i)
        {
            data[i] = mod_mul(data[i], inv_n, MOD);
        }
    }
    return;
}