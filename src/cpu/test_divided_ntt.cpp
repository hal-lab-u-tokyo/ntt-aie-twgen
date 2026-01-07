#include <iostream>
#include <vector>
#include <random>
#include <chrono>
#include <cmath>
#include <algorithm>

#include "../nttlib.h"

using namespace std;

template <typename T>
bool are_vectors_equal(const vector<T> &a, const vector<T> &b)
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

    const int logN = 15;
    const int N = 1 << logN;

    std::cout << "Testing Divided NTT with N = " << N << ", MOD = " << MOD << ", W = " << W_ROOT << std::endl;

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
   
    std::cout << "Performing Divided NTT..." << std::endl;
    const int stage_limit = (logN + 1) / 2;
    divided_ntt_inplace(a, logN, w, MOD, stage_limit, false);

    std::cout << "Performing inverse Divided NTT..." << std::endl;
    divided_ntt_inplace(a, logN, w, MOD, stage_limit, true);

    // Check results
    are_vectors_equal(a, a_ref) ? cout << "Divided NTT and inverse NTT successful!" << endl
                                 : cout << "Mismatch in Divided NTT results!" << endl;

    return 0;
}
