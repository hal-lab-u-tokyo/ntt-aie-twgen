# Number Theoretic Transform (NTT) Acceleration on AMD AI Engine

## Repository Overview
- `src/whole_core/` computes single NTT using `4x4` AIE arrays.
- `src/each_core/` computes multiple NTTs using `4x4` AIE arrays, each core handling one NTT.
- `src/single_core/` computes single NTT using `1x1` AIE core.

| | AIE Array Size | NTT Size | Number of NTTs | Notes |
|---|----------------|----------------|----------|------|
| `whole_core/` | 4x4 | 2^9 to 2^16 | 1 | |
| `each_core/` | 4x4 | 2^5 to 2^12 | 16 ||
| `single_core/` | 1x1 | 2^5 to 2^12 | 1 ||


## Whole Core NTT

```
cd src/whole_core
make run-10
```

