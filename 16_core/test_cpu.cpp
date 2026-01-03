#include <iostream>
#include <vector>
#include <random>
#include <chrono>
#include <cmath>
#include <algorithm>

#include "nttlib.h"

using namespace std;

bool are_vectors_equal(const vector<int> &a, const vector<int> &b)
{
    int err = 0;
    for (size_t i = 0; i < a.size(); i++)
    {
        if (a[i] != b[i])
        {
            cout << "Mismatch at index " << i << ": " << a[i] << " != " << b[i] << endl;
            err++;
            // return false;
        }
    }
    return err == 0;
}

int main()
{
    // Set up parameters
    const int MOD = 998244353; // : 119*2^23+1
    const int W_ROOT = 31;
    const int M = 23;

    const int logN = 3;
    const int N = 1 << logN;

    // Random number generator
    random_device rd;
    mt19937 gen(rd());
    uniform_int_distribution<int> distrib(0, (1LL << 10) - 1);

    // Initialize input data
    vector<int> a(N);
    vector<int> a_ref(N);
    for (int i = 0; i < N; ++i)
    {
        a[i] = distrib(gen) % MOD;
        a_ref[i] = a[i];
    }

    // Compute w = W^(2^(M-m)) mod MOD
    int w = power(W_ROOT, 1LL << (M - logN), MOD);

    // Perform NTT
    vector_bit_reverse(a.data(), logN);
    std::cout << "After bit-reverse:" << std::endl;
    for (int i = 0; i < N; ++i)
    {
        printf("a[%d] = %u\n", i, a[i]);
    }

    std::cout << "Performing NTT..." << std::endl;
    ntt_cpu(a.data(), logN, w, MOD, false);

    std::cout << "Performing inverse NTT..." << std::endl;
    vector_bit_reverse(a.data(), logN);
    ntt_cpu(a.data(), logN, w, MOD, true);

    // Check results
    are_vectors_equal(a, a_ref) ? cout << "NTT and inverse NTT successful!" << endl
                                : cout << "Mismatch in NTT results!" << endl;

    return 0;
}
