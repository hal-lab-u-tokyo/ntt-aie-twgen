#include <cmath>
#include <cstdint>
#include <cstdio>
#include <algorithm>
#include <vector>

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

int rotl(int x, int i, int m)
{
    int mask = (1 << m) - 1;
    return ((x << i) | (x >> (m - i))) & mask;
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


// =======================
// Divided NTT
// =======================
inline void divided_ntt_inplace_internal(int *ls, int step, int all_len, int W, int MOD, int stage_do, int w_offset_pow)
{
    int m = std::log2(all_len);
    // int l = ls.size();
    if (stage_do >= m)
    {
        stage_do = m;
    }

    int offset_exponent = w_offset_pow << stage_do;
    int pow_step = 1LL << m;
    int idx_step = 1LL;

    int w_offset, ws, half, wi, u, v, term;
    for (int s = 0; s < stage_do; ++s)
    {
        offset_exponent >>= 1;
        w_offset = power(W, offset_exponent, MOD);

        pow_step >>= 1;
        ws = power(W, pow_step, MOD);

        half = idx_step;
        idx_step <<= 1;

        for (int p = 0; p < step; p += idx_step)
        {
            wi = w_offset;
            for (int i = p; i < p + half; ++i)
            {
                int j = i + half;

                u = ls[i];
                v = ls[j];

                term = mod_mul(wi, v, MOD);

                ls[i] = (u + term) % MOD;
                ls[j] = (u - term % MOD + MOD) % MOD;

                wi = mod_mul(wi, ws, MOD);
            }
        }
    }
}

void divided_ntt_inplace(std::vector<int> &data, int logN, int W, int MOD, int stage_limit, bool inverse)
{
    int n = 1 << logN;
    int m = logN;

    // bit-reverse
    vector_bit_reverse(data.data(), logN);

    int current_W = W;
    if (inverse)
    {
        current_W = modInverse(W, MOD);
    }

    int stage_remain = m;
    if (stage_remain <= stage_limit)
    {
        stage_limit = stage_remain;
    }

    std::vector<int> new_res;
    while (stage_remain > 0)
    {
        int stage_do = std::min(stage_limit, stage_remain);
        int step = 1 << stage_do;
        int stage_will_remain = stage_remain - stage_do;

        new_res = data;

        for (int l = 0; l < n / step; ++l)
        {
            int start = l * step;
            int end = start + step;

            int t = ((int)start >> stage_remain) << stage_will_remain;
            int w_offset_pow = t;

            divided_ntt_inplace_internal(new_res.data() + start, step, n, current_W, MOD, stage_do, w_offset_pow);
        }

        for (int i = 0; i < n; ++i)
        {
            data[i] = new_res[rotl(i, stage_do, m)];
        }

        stage_remain = stage_will_remain;
    }

    if (inverse)
    {
        int inv_n = modInverse(n, MOD);
        for (int &r : data)
        {
            r = mod_mul(r, inv_n, MOD);
        }
    }
    return;
}
