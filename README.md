# Number Theoretic Transform (NTT) Acceleration on AMD AI Engine

## Repository Overview

| | AIE Array Size | NTT Size |
|---|----------------|----------------|
| `src/ntt/` | 4x4 | 2^9 to 2^16 |
| `src/divided_ntt/` | 4x4 | 2^5 to 2^12 |


```
cd src/ntt
make run
```

```
cd src/divided_ntt
make run
```

```
cd src/cpu
test-ntt
test-ntt-divided
```
