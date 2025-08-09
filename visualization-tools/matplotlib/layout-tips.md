# Matplotlib Layout and Formatting Tips

Matplotlib provides fine-grained control over the layout of plots. Use the following techniques to improve the appearance of your charts and dashboards.

## Figure Size and Resolution

Specify the figure size (width, height in inches) when creating a figure:

```python
import matplotlib.pyplot as plt

plt.figure(figsize=(8, 5))
plt.plot(x, y)
plt.title('Example Plot')
plt.show()
```

For higher resolution images, save the figure with the `dpi` parameter:

```python
plt.savefig('output.png', dpi=300)
```

## Subplots and Grid Layouts

Use `plt.subplots()` to create a grid of subplots and control spacing:

```python
fig, axes = plt.subplots(2, 2, figsize=(10, 6))
axes[0, 0].plot(x1, y1)
axes[0, 0].set_title('Plot 1')
# ... create other subplots ...

fig.tight_layout()  # adjusts spacing automatically
plt.show()
```

For more complex grids, use `matplotlib.gridspec.GridSpec` to precisely position axes.

## Adjusting Spacing

Control the spacing between subplots with `plt.subplots_adjust()`:

```python
fig, axes = plt.subplots(1, 2)
fig.subplots_adjust(wspace=0.3, hspace=0.4)
```

## Axis Labels and Titles

Always label your axes and provide a title to give context:

```python
plt.xlabel('Time (days)')
plt.ylabel('Revenue ($)')
plt.title('Daily Revenue Over Time')
```

## Tick Labels and Rotation

Customize tick labels for clarity:

```python
plt.xticks(rotation=45)
plt.yticks(fontsize=12)
```

Use `ax.set_xticklabels()` or `ax.set_yticklabels()` on individual axes for more control.

## Legends and Annotations

Position the legend in a non-overlapping location:

```python
plt.legend(loc='upper left')
```

Add annotations to highlight specific data points:

```python
plt.annotate('Peak', xy=(x_peak, y_peak), xytext=(x_peak, y_peak + 10),
             arrowprops=dict(arrowstyle='->'))
```

## Consistent Styling

- Use a consistent color palette (avoid using too many random colors).
- Increase line width or marker size for better visibility on presentations.
- Use `plt.style.use('ggplot')` or another style to quickly apply aesthetically pleasing defaults.

These layout techniques will help you create clear, professional-looking visualizations with Matplotlib.
