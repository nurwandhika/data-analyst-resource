# Database Normalization Principles

Proper database design reduces redundancy and improves data integrity. Normalization is a systematic approach to decomposing tables to eliminate undesirable characteristics like insertion, update, and deletion anomalies. Below are the key normal forms with simple explanations.

## First Normal Form (1NF)

- Each table cell contains only a single value (no repeating groups or arrays).
- Each record is unique and identified by a primary key.

**Example:**

A table containing customer purchases should not have multiple products in one column. Instead, each product purchase should be a separate row.

## Second Normal Form (2NF)

- The table must be in 1NF.
- All non-key attributes must depend on the *entire* primary key (no partial dependency on a subset of a composite key).

**Example:**

Suppose you have a composite primary key `(student_id, course_id)` and an attribute `student_name`. Since `student_name` depends only on `student_id`, move it to a separate `students` table to satisfy 2NF.

## Third Normal Form (3NF)

- The table must be in 2NF.
- All non-key attributes must depend *only* on the primary key (no transitive dependencies).

**Example:**

If a `orders` table contains `customer_id`, `customer_name`, and `customer_address`, the last two attributes depend on `customer_id`, not directly on `order_id`. Move customer details to a separate `customers` table.

## Benefits of Normalization

- Eliminates redundant data, saving storage and reducing anomalies.
- Simplifies enforcement of integrity constraints.
- Improves consistency and maintainability.

## When to Denormalize

- Read performance can suffer if too many joins are required. Sometimes denormalization (duplicating certain fields) is acceptable for read-heavy workloads. Evaluate based on use case and performance requirements.
