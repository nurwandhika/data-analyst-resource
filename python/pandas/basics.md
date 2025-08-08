# Pandas Basics

This beginner-friendly guide introduces core features of the [pandas](https://pandas.pydata.org/) library for data analysis and manipulation.

## Importing pandas

```python
import pandas as pd
```

## Creating Series and DataFrames

### Series

```python
import pandas as pd

s = pd.Series([1, 3, 5, 7], name="numbers")
print(s)
```

### DataFrame

```python
import pandas as pd

data = {
    "name": ["Alice", "Bob", "Charlie"],
    "age": [25, 30, 35]
}

df = pd.DataFrame(data)
print(df)
```

## Reading CSV Files

Use `read_csv` to load data from a CSV file. The example below uses `StringIO` to create a sample CSV in memory.

```python
import pandas as pd
from io import StringIO

csv_data = """name,age,city
Alice,30,New York
Bob,25,Paris
Charlie,35,London
"""

df = pd.read_csv(StringIO(csv_data))
print(df)
```

## Viewing Data

```python
df.head()      # first 5 rows
df.tail()      # last 5 rows
df.info()      # summary of DataFrame
df.describe()  # descriptive statistics
```

## Selecting Columns and Rows

```python
df["name"]              # select a single column
df[["name", "age"]]     # select multiple columns

df.loc[1]               # row by label
df.iloc[0]              # row by integer position
df.loc[0:1, ["name"]]  # rows and columns by label
df.iloc[0:2, 0:2]       # rows and columns by position
```

## Filtering Data

```python
df[df["age"] > 30]
```

## Sorting Values

```python
df.sort_values("age")                # ascending
df.sort_values("age", ascending=False)  # descending
```

## Basic Aggregation

```python
df["age"].mean()       # average age
df["age"].sum()        # total age

df.groupby("city")["age"].mean()  # average age by city
```

