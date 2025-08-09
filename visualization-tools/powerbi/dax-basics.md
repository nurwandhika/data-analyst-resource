# DAX Basics for Power BI

DAX (Data Analysis Expressions) is a formula language used in Power BI, Excel Power Pivot, and Analysis Services Tabular models to define custom calculations and queries. Understanding DAX is essential for building powerful measures and calculated columns.

## Calculated Columns vs Measures

- **Calculated columns** are computed row by row at data refresh time and stored in the model. They behave like regular columns.
- **Measures** (also known as calculated fields) are calculated on the fly, based on the filter context created by the report visuals.

## Common DAX Functions

- `SUM(Column)` – Adds up all values in a numeric column.
- `COUNT(Column)` – Counts non-blank values in a column.
- `DISTINCTCOUNT(Column)` – Counts unique values in a column.
- `AVERAGE(Column)` – Computes the average of a numeric column.
- `MIN()`, `MAX()` – Returns the minimum or maximum value.

## Filter Context vs Row Context

- **Row context** applies when calculating values row by row (e.g., in calculated columns). You can reference other columns in the same row.
- **Filter context** applies when evaluating measures within a report visual. Slicers, filters, and visual categories define which rows are included in the calculation.

## CALCULATE Function
        
`CALCULATE` modifies the filter context for a measure. It is one of the most powerful functions in DAX.

```DAX
TotalSales := SUM(Sales[Amount])

TotalSales2025 := CALCULATE([TotalSales], YEAR(Sales[OrderDate]) = 2025)
```

`CALCULATE` takes an existing measure and applies one or more filter expressions. It can also change the filter context by removing filters using `ALL()`.

## Relationship Functions

- `RELATED(Table[Column])` – Returns a related value from another table via the relationship defined in the model.
- `RELATEDTABLE(Table)` – Returns a table of related rows for many-to-one relationships (often used inside iterators).

## Example Measures

```DAX
-- Total quantity sold
TotalQuantity := SUM(Sales[Quantity])

-- Average order value
AverageOrderValue := DIVIDE([TotalSales], DISTINCTCOUNT(Sales[OrderID]))

-- Percentage of total sales by product
ProductShare := DIVIDE([TotalSales], CALCULATE([TotalSales], ALL(Products)))
```

Use this primer to start writing your own DAX expressions. As you build more complex models, explore functions like `EARLIER`, `FILTER`, and time intelligence functions (e.g., `SAMEPERIODLASTYEAR`).
