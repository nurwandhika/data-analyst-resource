# Fintech Transaction Analysis Project

This project simulates an end-to-end workflow for a data analyst working at a fintech company.  It covers data exploration, SQL queries, and Python analysis using pandas and matplotlib to derive insights from a mock digital wallet transaction dataset.

## 🎯 Objectives

- Understand the structure of a typical fintech transactions dataset.
- Write SQL queries to answer business questions such as total transaction volume, average transaction size, and daily active users.
- Use Python to load the data, perform data cleaning, compute metrics, and create simple visualizations.
- Provide an example of how SQL and Python can complement each other in a daily analytics workflow.

## 💾 Mock Dataset

### `transactions` table

| transaction_id | user_id | merchant_id | transaction_date | amount | status | payment_method |
| --- | --- | --- | --- | --- | --- | --- |
| T001 | U001 | M001 | 2025‑07‑01 | 50000 | completed | wallet |
| T002 | U002 | M002 | 2025‑07‑01 | 200000 | completed | debit_card |
| T003 | U001 | M003 | 2025‑07‑02 | 100000 | failed | wallet |
| T004 | U003 | M001 | 2025‑07‑03 | 75000 | completed | wallet |
| T005 | U002 | M003 | 2025‑07‑04 | 150000 | completed | credit_card |

### `users` table

| user_id | registration_date | gender | birth_year | city |
| --- | --- | --- | --- | --- |
| U001 | 2025‑01‑15 | F | 1995 | Jakarta |
| U002 | 2025‑02‑20 | M | 1990 | Bandung |
| U003 | 2025‑03‑05 | F | 1987 | Surabaya |

### `merchants` table

| merchant_id | merchant_name | category |
| --- | --- | --- |
| M001 | TopUp Mobile | telco |
| M002 | Online Shop | e‑commerce |
| M003 | Food Delivery | food |

These small mock tables illustrate common columns you might encounter in a production data warehouse.

## 🧺 Example SQL Queries

Here are some SQL queries you might run to answer common business questions.

### 1. Total and average transaction amounts

```sql
-- Total and average transaction amount for completed transactions
SELECT
    COUNT(*) AS total_transactions,
    SUM(amount) AS total_amount,
    AVG(amount) AS average_amount
FROM transactions
WHERE status = 'completed';
```

### 2. Daily transaction volume

```sql
-- Daily transaction volume and number of unique users
SELECT
    transaction_date,
    COUNT(*) AS transaction_count,
    COUNT(DISTINCT user_id) AS active_users,
    SUM(amount) AS total_amount
FROM transactions
WHERE status = 'completed'
GROUP BY transaction_date
ORDER BY transaction_date;
```

### 3. Transaction amount by payment method

```sql
-- Sum and average amount per payment method
SELECT
    payment_method,
    COUNT(*) AS count_transactions,
    SUM(amount) AS total_amount,
    AVG(amount) AS average_amount
FROM transactions
WHERE status = 'completed'
GROUP BY payment_method;
```

### 4. Join with users for demographic analysis

```sql
-- Average transaction amount by user gender
SELECT
    u.gender,
    COUNT(t.transaction_id) AS num_transactions,
    AVG(t.amount) AS avg_amount
FROM transactions t
JOIN users u
  ON t.user_id = u.user_id
WHERE t.status = 'completed'
GROUP BY u.gender;
```

### 5. Top merchants by revenue

```sql
-- Top merchants by total amount
SELECT
    m.merchant_name,
    SUM(t.amount) AS total_amount
FROM transactions t
JOIN merchants m ON t.merchant_id = m.merchant_id
WHERE t.status = 'completed'
GROUP BY m.merchant_name
ORDER BY total_amount DESC
LIMIT 5;
```

These queries can be adapted for a larger dataset stored in your data warehouse.

## 🐍 Python Analysis

Below is an example Python script using pandas to load the mock data and perform similar analyses.  In practice, you would connect to your database or load from CSV files.

```python
import pandas as pd
import matplotlib.pyplot as plt

# Mock data as dictionaries (in reality, read from CSV or SQL)
transactions = pd.DataFrame([
    {"transaction_id": "T001", "user_id": "U001", "merchant_id": "M001", "transaction_date": "2025-07-01", "amount": 50000, "status": "completed", "payment_method": "wallet"},
    {"transaction_id": "T002", "user_id": "U002", "merchant_id": "M002", "transaction_date": "2025-07-01", "amount": 200000, "status": "completed", "payment_method": "debit_card"},
    {"transaction_id": "T003", "user_id": "U001", "merchant_id": "M003", "transaction_date": "2025-07-02", "amount": 100000, "status": "failed", "payment_method": "wallet"},
    {"transaction_id": "T004", "user_id": "U003", "merchant_id": "M001", "transaction_date": "2025-07-03", "amount": 75000, "status": "completed", "payment_method": "wallet"},
    {"transaction_id": "T005", "user_id": "U002", "merchant_id": "M003", "transaction_date": "2025-07-04", "amount": 150000, "status": "completed", "payment_method": "credit_card"},
])

users = pd.DataFrame([
    {"user_id": "U001", "registration_date": "2025-01-15", "gender": "F", "birth_year": 1995, "city": "Jakarta"},
    {"user_id": "U002", "registration_date": "2025-02-20", "gender": "M", "birth_year": 1990, "city": "Bandung"},
    {"user_id": "U003", "registration_date": "2025-03-05", "gender": "F", "birth_year": 1987, "city": "Surabaya"},
])

merchants = pd.DataFrame([
    {"merchant_id": "M001", "merchant_name": "TopUp Mobile", "category": "telco"},
    {"merchant_id": "M002", "merchant_name": "Online Shop", "category": "e-commerce"},
    {"merchant_id": "M003", "merchant_name": "Food Delivery", "category": "food"},
])

# Convert dates to datetime
transactions['transaction_date'] = pd.to_datetime(transactions['transaction_date'])
users['registration_date'] = pd.to_datetime(users['registration_date'])

# Filter only completed transactions
completed = transactions[transactions['status'] == 'completed'].copy()

# Total and average amount
total_amount = completed['amount'].sum()
avg_amount = completed['amount'].mean()
print(f"Total amount: {total_amount}, Average amount: {avg_amount:.2f}")

# Daily transaction stats
daily = completed.groupby('transaction_date').agg(
    transaction_count=('transaction_id', 'count'),
    active_users=('user_id', 'nunique'),
    total_amount=('amount', 'sum')
).reset_index()

print(daily)

# Plot daily total amount
daily.plot(x='transaction_date', y='total_amount', kind='bar')
plt.title('Daily Transaction Volume')
plt.xlabel('Date')
plt.ylabel('Total Amount (IDR)')
plt.xticks(rotation=45)
plt.tight_layout()
plt.show()

# Join with users for gender analysis
merged = completed.merge(users, on='user_id', how='left')
gender_stats = merged.groupby('gender')['amount'].agg(['count', 'mean'])
print(gender_stats)
```

### What this script does:
- Creates mock pandas DataFrames to mimic SQL tables.
- Converts date columns to `datetime` dtype.
- Filters completed transactions.
- Computes total and average amount spent.
- Aggregates daily transaction statistics and plots them using Matplotlib.
- Merges transactions with user demographics and calculates stats by gender.

## ✅ Summary

This project provides a realistic example of a data analyst's workload at a fintech company. You define data structures, write SQL queries to answer business questions, and then move to Python to perform deeper analysis and visualization.  By working through this project, you practice both **database querying** and **programmatic data analysis**, which are key skills for any data analyst in the fintech sector.
