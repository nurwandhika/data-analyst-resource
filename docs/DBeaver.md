# 🐬 DBeaver – Universal Database Client Documentation

---

## 📌 1. Introduction

**DBeaver** is an **open-source, cross-platform database tool** for developers, analysts, and DBAs.
It supports **all major databases** (SQL & NoSQL) and is widely used for **querying, exploring schema, and managing connections**.

In this role, you will use DBeaver to:

* Connect to **Alibaba Cloud MaxCompute** (main data source) and **Google Cloud Spanner** (secondary source).
* Write and execute **SQL queries** for analysis.
* Explore **database schemas** (tables, views, relationships).
* Export query results for reporting and visualization.

---

## ⚙️ 2. Installation & Setup

### 🔽 Installation

* Download: [https://dbeaver.io/download](https://dbeaver.io/download)
* Choose **DBeaver CE (Community Edition)** unless the team specifies EE (Enterprise).

### 🛠 Database Drivers

* DBeaver uses **JDBC drivers** to connect to databases.
* First-time connection → DBeaver will prompt to download the driver automatically.

### 📂 Supported Databases (Relevant for You)

* **Alibaba Cloud MaxCompute (ODPS)** → Requires MaxCompute JDBC driver.
* **Google Cloud Spanner** → Requires Cloud Spanner JDBC driver.
* Generic databases: PostgreSQL, MySQL, Oracle, etc.

---

## 🔌 3. Connecting to a Database

### Example: Connect to MaxCompute

1. Open DBeaver → **Database → New Database Connection**.
2. Search for **MaxCompute (ODPS)**.
3. Enter:

   ```
   Endpoint: https://service.cn-hangzhou.maxcompute.aliyun.com/api
   Project: <your_project_name>
   Access ID: <your_access_key_id>
   Access Key: <your_access_key_secret>
   ```
4. Test connection → Save.

### Example: Connect to Google Cloud Spanner

1. New connection → Search **Spanner**.
2. Enter:

   ```
   Project ID: <gcp_project_id>
   Instance ID: <spanner_instance_id>
   Database: <database_name>
   ```
3. Use **Google Cloud credentials** (OAuth or service account).

✅ Best practice: Save credentials securely (do not hardcode in queries).

---

## ⌨️ 4. Querying Data

### Running Queries

* Open SQL Editor: `Ctrl+Enter` to execute.
* Highlight a block → execute selection only.

```sql
-- Example: Top 10 users
SELECT user_id, COUNT(*) AS actions
FROM user_activity
GROUP BY user_id
ORDER BY actions DESC
LIMIT 10;
```

### Multiple Result Tabs

* Each query result opens in a new tab.
* You can **pin** important results.

### Export Results

* Right-click → **Export Data** → CSV, Excel, JSON, SQL insert script.

---

## 🧭 5. Schema Exploration

### Database Navigator Panel

* Shows **databases → schemas → tables → columns**.
* Expand a table → see columns, constraints, indexes.

### ER Diagrams

* Right-click on schema → **View Diagram**.
* Useful for understanding relationships between tables.

### Data Preview

* Right-click a table → **View Data** → default LIMIT applied.

---

## 🛡️ 6. Best Practices

* ✅ Use **LIMIT** when exploring tables to avoid huge queries:

  ```sql
  SELECT * FROM big_table LIMIT 100;
  ```
* ✅ Use **aliases** for readability:

  ```sql
  SELECT u.name, o.order_id 
  FROM users u 
  JOIN orders o ON u.id = o.user_id;
  ```
* ✅ Save queries in **SQL Scripts** folder inside DBeaver.
* ✅ Organize connections with **folders** (e.g., Alibaba, GCP).
* ✅ Always check execution plan for long queries (right-click → **Explain Plan**).
* ✅ Use **transactions** (`BEGIN`, `COMMIT`, `ROLLBACK`) where supported.

---

## 🐞 7. Troubleshooting

| Issue                  | Root Cause            | Solution                                   |
| ---------------------- | --------------------- | ------------------------------------------ |
| **Driver not found**   | Missing JDBC          | Download via DBeaver or manual driver JAR  |
| **Connection timeout** | VPN/firewall issue    | Check VPN, whitelist IP, confirm host/port |
| **No tables shown**    | Wrong schema/project  | Switch schema in connection settings       |
| **Slow queries**       | No indexes / bad join | Check **Explain Plan**, optimize joins     |
| **Export fails**       | Large dataset         | Export with LIMIT or chunk queries         |

---

## 📖 8. Technical Fundamentals

### SQL Execution Flow

1. **Parser** → Checks syntax.
2. **Optimizer** → Chooses best query execution plan.
3. **Executor** → Retrieves data.

### Query Optimization Basics

* Use **indexes** when filtering with `WHERE`.
* Avoid `SELECT *`; only select required columns.
* Use **CTEs (WITH)** for readability.
* For massive joins, filter data before joining.

### Connection Management

* DBeaver = client → communicates via JDBC → DB server.
* Connection stays open until you disconnect.
* Multiple queries share the same session context.

---

## 📋 9. Quick Reference Cheatsheet

| Action               | Shortcut/Steps               |
| -------------------- | ---------------------------- |
| Run SQL              | `Ctrl+Enter`                 |
| Run selected block   | Highlight + `Ctrl+Enter`     |
| Commit transaction   | `Ctrl+Shift+Enter`           |
| Rollback transaction | `Ctrl+Alt+Backspace`         |
| Format SQL           | `Ctrl+Shift+F`               |
| Open ER diagram      | Right-click schema → Diagram |
| Export results       | Right-click result → Export  |

---

## 🔗 10. References

* [Official DBeaver Docs](https://dbeaver.io/docs/)
* [Alibaba MaxCompute JDBC Docs](https://www.alibabacloud.com/help/en/maxcompute/latest/jdbc)
* [Google Cloud Spanner JDBC](https://cloud.google.com/spanner/docs/jdbc)
* [SQL Style Guide](https://www.sqlstyle.guide/)

---

✅ This version goes **beyond “how-to”**:

* Fundamentals of SQL execution
* Query optimization practices
* Transaction management
* ER diagrams & schema navigation
