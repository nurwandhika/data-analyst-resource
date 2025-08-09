-- SQL Window Function Examples

-- Row number ordered by order date
SELECT order_id, order_date,
       ROW_NUMBER() OVER (ORDER BY order_date) AS row_num
FROM orders;

-- Rank and dense rank based on sales amount
SELECT customer_id, amount,
       RANK()       OVER (ORDER BY amount DESC) AS rank,
       DENSE_RANK() OVER (ORDER BY amount DESC) AS dense_rank
FROM invoices;

-- Lag and lead to compare current row to previous/next row
SELECT order_date, amount,
       LAG(amount)  OVER (ORDER BY order_date) AS previous_amount,
       LEAD(amount) OVER (ORDER BY order_date) AS next_amount
FROM sales;

-- Moving average over 7-day window
SELECT order_date, amount,
       AVG(amount) OVER (
         ORDER BY order_date
         ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
       ) AS seven_day_avg
FROM daily_sales;
