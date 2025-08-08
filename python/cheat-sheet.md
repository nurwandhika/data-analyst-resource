# Python Data Analysis Cheat Sheet

## Variable Assignment
```python
x = 42
name = "Alice"
```

## Data Types
```python
an_int = 7              # int
pi = 3.14              # float
greeting = "hi"        # str
is_valid = True        # bool
nums = [1, 2, 3]       # list
coords = (1, 2)        # tuple
person = {"age": 30}  # dict
unique = {1, 2, 3}     # set

# check type
type(greeting)
```

## Lists, Dictionaries, and Sets
### Lists
```python
fruits = ["apple", "banana"]
fruits.append("orange")
first = fruits[0]
```

### Dictionaries
```python
scores = {"Alice": 90, "Bob": 80}
score = scores["Alice"]
scores["Eve"] = 70
```

### Sets
```python
colors = {"red", "blue"}
colors.add("green")
```

## List Comprehension
```python
squares = [n**2 for n in range(5)]
```

## Functions
```python
def greet(name):
    return f"Hello, {name}!"
```

## Lambda Functions
```python
add = lambda a, b: a + b
add(2, 3)
```

## Importing Libraries
```python
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
```

## DataFrame Creation
```python
data = {"name": ["Alice", "Bob"], "age": [25, 30]}
df = pd.DataFrame(data)

# from NumPy array
arr = np.array([[1, 2], [3, 4]])
df_from_array = pd.DataFrame(arr, columns=["A", "B"])
```

## Basic Plotting
```python
plt.plot(df["name"], df["age"], marker="o")
plt.title("Age by Person")
plt.xlabel("Name")
plt.ylabel("Age")
plt.show()
```
