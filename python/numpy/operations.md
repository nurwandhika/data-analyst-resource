# NumPy Operations Quick Reference

## Importing NumPy and Creating Arrays
```python
import numpy as np

arr = np.array([1, 2, 3])
```

## Array Indexing and Slicing
```python
arr = np.array([10, 20, 30, 40])
first = arr[0]      # 10
subset = arr[1:3]   # [20 30]
```

## Vectorized Operations
```python
a = np.array([1, 2, 3])
b = np.array([4, 5, 6])

add = a + b         # [5 7 9]
multiply = a * b    # [ 4 10 18]
```

## Reshape, Flatten, Transpose
```python
arr = np.arange(6)       # [0 1 2 3 4 5]
reshaped = arr.reshape(2, 3)
flat = reshaped.flatten()
transposed = reshaped.T
```

## Useful Functions
```python
np.arange(0, 5)          # [0 1 2 3 4]
np.linspace(0, 1, 5)     # [0.   0.25 0.5  0.75 1.  ]
np.zeros((2, 2))         # [[0. 0.]
                          #  [0. 0.]]
np.ones((1, 3))          # [[1. 1. 1.]]
```

## Basic Statistics
```python
arr = np.array([1, 2, 3, 4, 5])
np.mean(arr)      # 3.0
np.median(arr)    # 3.0
np.std(arr)       # 1.4142135623730951
```
