-- SQL Join Examples

-- Inner Join: return rows where there is a match in both tables
SELECT o.order_id, c.customer_name, o.total
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id;

-- Left Join: return all rows from left table with matching rows from right table
SELECT c.customer_name, o.order_id, o.total
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id;

-- Right Join: return all rows from right table with matching rows from left table
SELECT o.order_id, o.total, c.customer_name
FROM orders o
RIGHT JOIN customers c ON o.customer_id = c.customer_id;

-- Full Outer Join: return rows when there is a match in either table
SELECT c.customer_name, o.order_id, o.total
FROM customers c
FULL OUTER JOIN orders o ON c.customer_id = o.customer_id;

-- Cross Join: return Cartesian product (use with caution)
SELECT c.customer_name, p.product_name
FROM customers c
CROSS JOIN products p;
