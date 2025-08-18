---

# 🌬️ Apache Airflow – Workflow Orchestration Documentation

---

## 📌 1. Introduction

**Apache Airflow** is an **open-source workflow orchestration tool** used to programmatically author, schedule, and monitor data pipelines.

In this role, Airflow is mainly used to:

* **Automate ETL pipelines** (Extract → Transform → Load).
* **Schedule recurring jobs** (e.g., daily ingestion from Alibaba Cloud MaxCompute).
* **Orchestrate multi-step workflows** (SQL queries, Python scripts, file transfers).
* Provide a **visual UI** to track tasks and debug failures.

---

## ⚙️ 2. Installation & Setup

### 🔽 Local Installation (for practice)

```bash
# Install Airflow using pip
pip install apache-airflow

# Initialize database
airflow db init

# Start webserver
airflow webserver --port 8080

# Start scheduler (separate terminal)
airflow scheduler
```

Access the **Web UI**: [http://localhost:8080](http://localhost:8080)

### 🏗️ Production Setup

* Usually deployed via **Docker, Kubernetes, or Cloud Composer (GCP)**.
* You likely won’t install it yourself → you’ll connect to the team’s managed Airflow environment.

### ⚡ Key Components

* **Webserver** → UI for DAGs and tasks.
* **Scheduler** → Triggers tasks according to schedule.
* **Worker** → Executes tasks.
* **Metadata DB** → Stores DAG runs and task states.

---

## 📂 3. Core Concepts

### **DAG (Directed Acyclic Graph)**

* Defines the **workflow structure**.
* Each DAG = a Python script.
* DAGs contain **Tasks** connected via dependencies.

```python
from airflow import DAG
from airflow.operators.bash import BashOperator
from datetime import datetime

with DAG(
    dag_id="example_dag",
    start_date=datetime(2025, 8, 18),
    schedule_interval="@daily",
    catchup=False
) as dag:
    
    task1 = BashOperator(
        task_id="print_hello",
        bash_command="echo 'Hello Airflow'"
    )
```

---

### **Task**

* The smallest unit of execution.
* Can be Bash, Python, SQL, Spark, etc.

### **Operators**

* Predefined templates for tasks.
* Examples:

  * `BashOperator` → run shell commands
  * `PythonOperator` → run Python functions
  * `DummyOperator` → placeholder/no-op
  * `SQLOperator` → run SQL queries

---

### **Task Dependencies**

```python
task1 >> task2    # task1 runs before task2
task2 << task3    # task3 runs before task2
```

---

## ⏰ 4. Scheduling & Execution

### Cron Expressions

Airflow schedules follow **cron-like syntax**:

| Schedule   | Cron        | Meaning               |
| ---------- | ----------- | --------------------- |
| `@once`    | –           | Run only once         |
| `@hourly`  | `0 * * * *` | Every hour            |
| `@daily`   | `0 0 * * *` | Every day midnight    |
| `@weekly`  | `0 0 * * 0` | Every Sunday midnight |
| `@monthly` | `0 0 1 * *` | First day of month    |

---

### Catchup

* **Default = True** → Runs past missed intervals.
* **Best practice**: Set `catchup=False` unless backfilling historical data.

---

## 🧭 5. Monitoring

* **Web UI** → Shows DAGs, task status (success, failed, running).
* **Logs** → Available per-task inside UI.
* **Retry Mechanism** → Configure `retries=3` with exponential backoff.

```python
task = BashOperator(
    task_id="unstable_task",
    bash_command="python unstable.py",
    retries=3,
    retry_delay=timedelta(minutes=5)
)
```

---

## 🛡️ 6. Best Practices

* ✅ Use **clear naming** for DAGs & tasks (`etl_user_activity_daily`).
* ✅ Always set `start_date` in the past, never in the future.
* ✅ Use `catchup=False` unless explicitly backfilling.
* ✅ Parameterize SQL queries with Jinja templates.

```python
query = """
SELECT COUNT(*) 
FROM users 
WHERE date = '{{ ds }}'
"""
```

* ✅ Store credentials in **Airflow Connections/Variables**, not in code.
* ✅ Use **XComs** (cross-communication) to pass data between tasks.
* ✅ Modularize DAGs → don’t put business logic directly in operators.

---

## 🐞 7. Troubleshooting

| Issue                   | Root Cause                      | Solution                                           |
| ----------------------- | ------------------------------- | -------------------------------------------------- |
| DAG not appearing in UI | Syntax error / wrong folder     | Check logs, ensure `.py` file in `dags/` directory |
| Task stuck in `queued`  | Worker not running              | Restart scheduler/worker                           |
| Task fails repeatedly   | Script bug / wrong connection   | Check task logs in Web UI                          |
| Slow DAG execution      | Bad parallelism config          | Tune `parallelism`, `concurrency` in config        |
| Backfill overload       | Catchup=True on old start\_date | Disable catchup or set recent start\_date          |

---

## 📖 8. Technical Fundamentals

### Execution Flow

1. **Scheduler** scans DAGs folder.
2. Triggers DAG runs according to schedule.
3. Tasks sent to **Executor** (Celery, Local, Kubernetes).
4. **Workers** execute tasks.
5. Results & logs saved in **Metadata DB**.

### Executors

* **SequentialExecutor** (default, for testing).
* **LocalExecutor** (parallel on one machine).
* **CeleryExecutor** (distributed workers).
* **KubernetesExecutor** (scalable cloud-native).

### Task Lifecycle

* `none → scheduled → queued → running → success/failed → retry (if enabled)`

---

## 📋 9. Quick Reference Cheatsheet

| Action            | Code/Command                                            |
| ----------------- | ------------------------------------------------------- |
| Start webserver   | `airflow webserver -p 8080`                             |
| Start scheduler   | `airflow scheduler`                                     |
| List DAGs         | `airflow dags list`                                     |
| Trigger DAG       | `airflow dags trigger <dag_id>`                         |
| Pause DAG         | `airflow dags pause <dag_id>`                           |
| Resume DAG        | `airflow dags unpause <dag_id>`                         |
| List tasks        | `airflow tasks list <dag_id>`                           |
| Run specific task | `airflow tasks run <dag_id> <task_id> <execution_date>` |

---

## 🔗 10. References

* [Official Airflow Docs](https://airflow.apache.org/docs/)
* [Airflow Scheduler Basics](https://airflow.apache.org/docs/apache-airflow/stable/scheduler.html)
* [Astronomer’s Airflow Guide](https://www.astronomer.io/guides/)
* [Cron Expression Cheatsheet](https://crontab.guru/)

---

✅ This documentation gives you:

* Fundamentals (**DAGs, tasks, operators, scheduling**)
* Best practices (naming, catchup, retries, credentials)
* Execution flow (Scheduler → Worker → DB)
* Troubleshooting common problems
* Quick CLI cheatsheet

---
