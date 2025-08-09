# SQL Cheat Sheet for Data Analysts

This cheat sheet summarizes the most commonly used SQL syntax and patterns for data analysis. It is intended as a quick reference for analysts who work with relational databases.

## Selecting Data

- **Select all columns:**

```sql
SELECT *
FROM table_name;
```

- **Select specific columns:**

```sql
SELECT column1, column2, …
FROM table_name;
```

- **Alias columns:**

```sql
SELECT column1 AS alias_name
FROM table_name;
```

## Filtering Rows

- **Basic filtering using `WHERE`:**

```sql
SELECT *
FROM table_name
WHERE condition;
```

Example filtering by equality and comparison:

```sql
SELECT name, age
FROM customers
WHERE age >= 18 AND status = 'active';
```

- **Using operators:**
  - `AND`, `OR`, `NOT` to combine conditions
  - `IN` to test membership in a list
  - `BETWEEN` for range comparisons
  - `LIKE` with `%` wildcard for pattern matching

Example using `IN` and `LIKE`:

```sql
SELECT order_id
FROM orders
WHERE status IN ('shipped', 'delivered')
  AND customer_name LIKE 'A%';
```

## Sorting Results

Use `ORDER BY` to sort query results:

```sql
SELECT *
FROM sales
ORDER BY sale_date DESC, amount ASC;
```

Add `DESC` for descending order and `ASC` (or omit) for ascending order.

## Aggregation and Grouping

Aggregate functions compute a single result from multiple rows:

- `COUNT()`, `SUM()`, `AVG()`, `MIN()`, `MAX()`

Example summarizing total revenue per category:

```sql
SELECT category,
       SUM(revenue) AS total_revenue,
       COUNT(*)     AS num_sales
FROM sales
GROUP BY category
HAVING SUM(revenue) > 1000;
```

Use `HAVING` to filter groups (it works like `WHERE` but after aggregation).

## Joining Tables

Joins combine rows from two or more tables based on a related column.

- **INNER JOIN** – returns only matching rows from both tables.
- **LEFT JOIN (LEFT OUTER JOIN)** – returns all rows from the left table plus matching rows from the right table; missing values from the right table are `NULL`.
- **RIGHT JOIN (RIGHT OUTER JOIN)** – returns all rows from the right table plus matching rows from the left.
- **FULL OUTER JOIN** – returns all rows when there is a match in either table.
- **CROSS JOIN** – returns the Cartesian product of the two tables.

Example of an inner join:

```sql
SELECT o.order_id, c.customer_name, o.total
FROM orders AS o
INNER JOIN customers AS c
  ON o.customer_id = c.customer_id;
```

## Subqueries

Use subqueries (queries nested inside another query) to perform advanced filtering or calculations.

Example selecting customers who spent more than the average order amount:

```sql
SELECT customer_id,
       SUM(amount) AS total_spent
FROM orders
GROUP BY customer_id
HAVING SUM(amount) > (
    SELECT AVG(amount)
    FROM orders
);
```

## Window Functions

Window functions perform calculations across a set of rows related to the current row and require an `OVER()` clause. They do not collapse rows like aggregations.

Examples:

- **ROW_NUMBER()** assigns a unique number to each row in the result set:

```sql
SELECT order_id,
       ROW_NUMBER() OVER (ORDER BY order_date) AS row_num
FROM orders;
```

- **RANK()** and **DENSE_RANK()** rank rows with handling for ties:

```sql
SELECT customer_id,
       amount,
       RANK() OVER (ORDER BY amount DESC) AS rank,
       DENSE_RANK() OVER (ORDER BY amount DESC) AS dense_rank
FROM invoices;
```

- **LAG()** and **LEAD()** access data from preceding or following rows:

```sql
SELECT order_date,
       amount,
       LAG(amount) OVER (ORDER BY order_date)  AS previous_amount,
       LEAD(amount) OVER (ORDER BY order_date) AS next_amount
FROM sales;
```

- **Moving averages** using `AVG()` with `ROWS BETWEEN`:

```sql
SELECT order_date,
       amount,
       AVG(amount) OVER (
         ORDER BY order_date
         ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
       ) AS seven_day_avg
FROM daily_sales;
```

## Set Operations

Combine result sets with set operators:

- `UNION` – combines two result sets and removes duplicates.
- `UNION ALL` – combines and keeps duplicates.
- `INTERSECT` – returns rows present in both result sets.
- `EXCEPT` – returns rows from the first query not present in the second.

```sql
SELECT id FROM table_a
UNION ALL
SELECT id FROM table_b;
```

Keep this cheat sheet handy while writing SQL queries for quick reference!
