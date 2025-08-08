# Matplotlib Quick Guide

Matplotlib is a popular plotting library in Python. This guide covers the basics needed to create common visualizations.

## Importing `matplotlib.pyplot`

```python
import matplotlib.pyplot as plt
```

Use the alias `plt` for convenience, following community convention.

## Line Plot

```python
import matplotlib.pyplot as plt

x = [1, 2, 3, 4, 5]
y = [2, 3, 5, 7, 11]

plt.plot(x, y, color='green', marker='o', linestyle='-', linewidth=2)
plt.title('Prime Numbers')
plt.xlabel('Position')
plt.ylabel('Value')
plt.legend(['Primes'])
plt.savefig('line_plot.png')
plt.show()
```

This creates a simple line plot with custom color, markers, line style and width. The plot is saved as `line_plot.png` before being displayed.

## Bar Plot

```python
import matplotlib.pyplot as plt

categories = ['A', 'B', 'C']
values = [5, 7, 3]

plt.bar(categories, values, color=['red', 'blue', 'orange'])
plt.title('Category Counts')
plt.xlabel('Category')
plt.ylabel('Count')
plt.savefig('bar_plot.png')
plt.show()
```

Each bar can be assigned a different color. Titles and labels make the chart easier to read.

## Histogram

```python
import matplotlib.pyplot as plt
import numpy as np

np.random.seed(0)
data = np.random.randn(1000)

plt.hist(data, bins=30, color='skyblue', edgecolor='black')
plt.title('Distribution')
plt.xlabel('Value')
plt.ylabel('Frequency')
plt.savefig('histogram.png')
plt.show()
```

A histogram shows the distribution of data. Adjust `bins` to change the granularity.

## Scatter Plot

```python
import matplotlib.pyplot as plt

x = [5, 7, 8, 7, 2, 17, 2, 9, 4, 11]
y = [99, 86, 87, 88, 100, 86, 103, 87, 94, 78]

plt.scatter(x, y, color='purple', s=100, marker='x')
plt.title('Height vs. Weight')
plt.xlabel('Height')
plt.ylabel('Weight')
plt.savefig('scatter_plot.png')
plt.show()
```

`scatter` allows customization of marker size (`s`), color, and style. Useful for visualizing relationships between two numeric variables.

## Customizing Style

Matplotlib offers many options to change the appearance of plots:

```python
plt.plot(x, y, color='#FF5733', linestyle='--', linewidth=3)
plt.rcParams['figure.figsize'] = (8, 4)
```

Use color codes, line styles (`'-'`, `'--'`, `':'`, `'-.'`), markers (`'o'`, `'s'`, `'x'`), and change figure size with `plt.rcParams` or `plt.figure(figsize=(width, height))`.

## Saving Plots

Before displaying a plot with `plt.show()`, call `plt.savefig('filename.png')` to store the figure as an image file. You can specify formats like PNG, JPG, or PDF:

```python
plt.savefig('my_plot.pdf', dpi=300)
```

The `dpi` parameter sets the resolution of the saved image.

---

With these basics, you can create and customize many types of plots for data analysis.
