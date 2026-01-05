#include <cmath>
#include <cstdint>
#include <cstdio>
#include <algorithm>

bool debug = false;

int power(int base, int exp, int mod)
{
    int res = 1;
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

int modInverse(int n, int mod)
{
    return power(n, mod - 2, mod);
}

int bit_reverse(int x, int logN)
{
    int res = 0;
    for (int i = 0; i < logN; ++i)
    {
        res <<= 1;
        res |= (x & 1);
        x >>= 1;
    }
    return res;
}

void vector_bit_reverse(int *data, int logN)
{
    const int N = 1 << logN;
    int *buff = new int[N];
    for (int i = 0; i < N; ++i)
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

int mod_mul(int a, int b, int mod)
{
    return ((uint64_t)a * b) % mod;
}

// NTT
// data: bit-reversed input/output array
// stop_stage_for_debug: 1-origin stage index
void ntt_cpu(int *data, int logN, int W, int MOD, bool inverse, int stop_stage_for_debug)
{
    int N = 1 << logN;
    int current_W = W;
    if (inverse)
    {
        current_W = modInverse(W, MOD);
    }

    int pow_step = 1LL << logN;
    int idx_step = 1LL;

    int ws, half, wi, u, v, term;
    for (int s = 0; s < logN; ++s)
    {
        if (debug == true)
        {
            printf("=============================================\n");
            printf("NTT Stage %d/%d\n", s + 1, logN);
            printf("=============================================\n");
        }
        pow_step >>= 1;
        ws = power(current_W, pow_step, MOD);

        half = idx_step;
        idx_step <<= 1;

        for (int p = 0; p < N; p += idx_step)
        {
            wi = 1;
            int wi_index = 0;
            for (int i = p; i < p + half; ++i)
            {
                int j = i + half;

                u = data[i];
                v = data[j];

                term = mod_mul(wi, v, MOD);

                data[i] = (u + term) % MOD;
                data[j] = (u - term + MOD) % MOD;

                if (debug == true) {
                    printf("stage %d butterfly: data[%u]=%u, data[%u]=%u, tw_idx[%d]=%u, from u=%u, v=%u\n", s + 1, i, data[i], j, data[j], wi_index, wi, u, v);
                }

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
        int inv_n = modInverse(N, MOD);
        for (int i = 0; i < N; ++i)
        {
            data[i] = mod_mul(data[i], inv_n, MOD);
        }
    }
    return;
}