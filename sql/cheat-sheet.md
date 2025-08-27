# The Ultimate SQL Cheat Sheet for Data Analysts

This cheat sheet summarizes the most commonly used SQL commands and patterns, organized by task. It is intended as a quick reference for analysts who work with relational databases.

## 1\. Data Query Language (DQL) - Retrieving Data 🔎

This is the core of data analysis—selecting, filtering, and ordering data.

### Basic `SELECT` Statements

  * **Select all columns from a table:**
    ```sql
    SELECT * FROM table_name;
    ```
  * **Select specific columns:**
    ```sql
    SELECT column1, column2 FROM table_name;
    ```
  * **Select unique values:**
    ```sql
    SELECT DISTINCT category FROM products;
    ```
  * **Alias columns and tables for readability:**
    ```sql
    SELECT
      c.customer_name AS name,
      o.order_date AS date
    FROM
      customers AS c;
    ```
  * **Limit the number of results (essential for previewing data):**
    ```sql
    -- For MySQL / PostgreSQL
    SELECT * FROM sales LIMIT 10;

    -- For SQL Server
    SELECT TOP 10 * FROM sales;
    ```

### Filtering with `WHERE`

  * **Basic filtering:**
    ```sql
    SELECT * FROM customers WHERE age >= 21;
    ```
  * **Conditional Operators:**
      * **`AND`, `OR`, `NOT`**: Combine multiple conditions.
        ```sql
        SELECT * FROM customers WHERE age > 25 AND city = 'Jakarta';
        ```
      * **`IN`**: Match any value in a list.
        ```sql
        SELECT * FROM orders WHERE status IN ('shipped', 'delivered');
        ```
      * **`BETWEEN`**: Filter within a range (inclusive).
        ```sql
        SELECT * FROM products WHERE price BETWEEN 100 AND 500;
        ```
      * **`LIKE`**: Match a string pattern (`%` for multiple characters, `_` for a single character).
        ```sql
        SELECT * FROM users WHERE email LIKE '%@gmail.com';
        ```
      * **`IS NULL` / `IS NOT NULL`**: Find empty or non-empty values.
        ```sql
        SELECT * FROM employees WHERE manager_id IS NULL;
        ```
      * **`EXISTS`**: Check for the existence of rows in a subquery.
        ```sql
        SELECT name FROM customers c
        WHERE EXISTS (SELECT 1 FROM orders o WHERE o.customer_id = c.id);
        ```

### Sorting with `ORDER BY`

  * Sort results in ascending (`ASC`) or descending (`DESC`) order.
    ```sql
    SELECT product_name, price FROM products
    ORDER BY price DESC, product_name ASC;
    ```

## 2\. Joining Tables 🤝

Joins combine rows from two or more tables based on a related column.

  * **`INNER JOIN`**: Returns only the matching rows from both tables.
  * **`LEFT JOIN`**: Returns all rows from the left table and the matched rows from the right table.
  * **`RIGHT JOIN`**: Returns all rows from the right table and the matched rows from the left table.
  * **`FULL OUTER JOIN`**: Returns all rows when there is a match in either table.

<!-- end list -->

```sql
SELECT
  o.order_id,
  c.customer_name,
  p.product_name
FROM
  orders AS o
INNER JOIN
  customers AS c ON o.customer_id = c.customer_id
LEFT JOIN
  products AS p ON o.product_id = p.product_id;
```

## 3\. Aggregating & Grouping Data 📊

Aggregate functions perform a calculation on a set of values and return a single value.

  * **`COUNT()`**: Counts the number of rows. `COUNT(DISTINCT column)` counts unique values.
  * **`SUM()`**: Calculates the sum of a numeric column.
  * **`AVG()`**: Calculates the average of a numeric column.
  * **`MIN()` / `MAX()`**: Finds the minimum or maximum value.

The **`GROUP BY`** clause groups rows that have the same values into summary rows. The **`HAVING`** clause is used to filter these groups.

```sql
SELECT
  category,
  AVG(price) AS average_price,
  COUNT(*) AS number_of_products
FROM
  products
WHERE
  is_active = TRUE
GROUP BY
  category
HAVING
  COUNT(*) > 10;
```

## 4\. Advanced Querying 🚀

### `CASE` Statements

Create new categories based on conditional logic.

```sql
SELECT
  order_id,
  amount,
  CASE
    WHEN amount > 1000 THEN 'High Value'
    WHEN amount > 500 THEN 'Medium Value'
    ELSE 'Low Value'
  END AS order_category
FROM
  orders;
```

### Subqueries (Nested Queries)

A query nested inside another query. Often used in the `WHERE`, `FROM`, or `SELECT` clause.

```sql
-- Find customers who have placed an order
SELECT customer_name FROM customers
WHERE customer_id IN (SELECT DISTINCT customer_id FROM orders);
```

### Window Functions

Perform calculations across a set of table rows. Unlike `GROUP BY`, they do not collapse rows.

  * **`ROW_NUMBER()`, `RANK()`, `DENSE_RANK()`**: Assign ranks to rows.
  * **`LAG()`, `LEAD()`**: Access data from previous or subsequent rows.
  * **`SUM()`, `AVG()`, `COUNT()` as window functions**: Calculate running totals, moving averages, etc.

<!-- end list -->

```sql
-- Calculate a 7-day moving average of sales
SELECT
  sale_date,
  daily_revenue,
  AVG(daily_revenue) OVER (
    ORDER BY sale_date
    ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
  ) AS seven_day_moving_avg
FROM
  daily_sales;
```

### Set Operators

Combine the results of two or more `SELECT` statements.

  * **`UNION`**: Combines result sets and removes duplicates.
  * **`UNION ALL`**: Combines result sets and includes all duplicates.
  * **`INTERSECT`**: Returns only rows that appear in both result sets.
  * **`EXCEPT` / `MINUS`**: Returns rows from the first result set that are not in the second.

## 5\. Data Manipulation Language (DML) - Modifying Data ✍️

  * **Insert new rows:**

    ```sql
    INSERT INTO customers (customer_name, city)
    VALUES ('Nurwandhika', 'Tangerang');
    ```

  * **Update existing rows:**

    ```sql
    UPDATE customers
    SET city = 'South Tangerang'
    WHERE customer_name = 'Nurwandhika';
    ```

  * **Delete rows:**

    ```sql
    DELETE FROM customers WHERE customer_name = 'Nurwandhika';
    ```

    **⚠️ Warning:** `DELETE FROM customers;` without a `WHERE` clause will delete **all rows** in the table.

  * **Truncate a table (delete all data quickly):**

    ```sql
    TRUNCATE TABLE table_name;
    ```

## 6\. Data Definition Language (DDL) - Structuring Data 🏗️

  * **Create a table:**
    ```sql
    CREATE TABLE employees (
      id INT PRIMARY KEY,
      name VARCHAR(100),
      hire_date DATE
    );
    ```
  * **Alter a table (add/remove columns):**
    ```sql
    ALTER TABLE employees ADD COLUMN salary DECIMAL(10, 2);
    ALTER TABLE employees DROP COLUMN hire_date;
    ```
  * **Drop a table (permanently delete):**
    ```sql
    DROP TABLE employees;
    ```
  * **Create an index (speed up queries):**
    ```sql
    CREATE INDEX idx_employee_name ON employees (name);
    ```
  * **Create a view (a stored, virtual table):**
    ```sql
    CREATE VIEW active_customers AS
    SELECT * FROM customers WHERE is_active = TRUE;
    ```
