# Calculated Fields in Tableau

Calculated fields in Tableau allow you to create new data from existing data by applying expressions, functions, and aggregations. They can be used in dimensions, measures, filters, or even as part of Level of Detail (LOD) expressions.

## Creating a Calculated Field

1. In Tableau Desktop, right‑click in the **Data** pane and choose **Create Calculated Field**.
2. Enter a descriptive name for the new field.
3. Write the calculation in the editor using Tableau’s syntax.

## Basic Examples

- **Simple arithmetic:**

  ```
  [Profit Margin] = [Profit] / [Sales]
  ```

- **String concatenation:**

  ```
  [Full Name] = [First Name] + ' ' + [Last Name]
  ```

- **Date calculations:**

  ```
  [Days to Ship] = DATEDIFF('day', [Order Date], [Ship Date])
  ```

## Conditional Logic

Use the `IF … THEN … ELSE … END` syntax to create conditional calculated fields:

```
IF [Sales] > 10000 THEN 'High'
ELSEIF [Sales] >= 5000 THEN 'Medium'
ELSE 'Low'
END
```

## Level of Detail (LOD) Expressions

LOD expressions allow you to control the granularity at which aggregations are computed. Common types:

- **Fixed LOD:** Calculates a value at a specified dimension, regardless of view context.

  ```
  {FIXED [Region] : SUM([Sales])}
  ```

- **Include LOD:** Adds dimensions to the existing view level of detail before aggregation.

  ```
  {INCLUDE [Sub-Category] : AVG([Profit])}
  ```

- **Exclude LOD:** Removes dimensions from the view level of detail.

  ```
  {EXCLUDE [Date] : SUM([Sales])}
  ```

## Tips for Using Calculated Fields

- Use descriptive names so others understand what the field represents.
- Test calculations by dragging them into a temporary view to validate results.
- Keep calculations simple and break complex formulas into multiple fields when possible.

Calculated fields are powerful tools that enable complex analysis without modifying your underlying data source.
