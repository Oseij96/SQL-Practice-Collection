# 🧠 Advanced SQL Practice Collection

### Author: **Joel Osei**
### Database: **MySQL 8.0+**
### File: [`advanced-sql-practice.sql`](advanced-sql-practice.sql)

---

## 📘 Overview

This module is part of the **SQL Practice Collection** and focuses on mastering *advanced* SQL concepts used in analytics, data engineering, and technical interviews.  
It includes real-world queries demonstrating advanced MySQL techniques such as:

- Recursive Common Table Expressions (CTEs)
- Window functions (RANK, LAG, NTILE, etc.)
- Subqueries and `EXISTS` logic
- Cohort and growth analysis
- Salary analytics and management hierarchy insights
- Department projections using recursion

All exercises assume the following tables are already created and populated using the project’s root setup scripts:
- `employees(emp_id, emp_name, salary, hire_date, manager_id, dept_id)`
- `departments(dept_id, dept_name)`

---

## ⚙️ Setup

Before running these queries:

```sql
SOURCE ../create_tables.sql;
SOURCE ../sample_data_tables.sql;
Then run:

sql
Copy code
SOURCE advanced-sql-practice.sql;


## 📂 Contents
No.	Topic	Description
Q1	Recursive CTE – Management Chain	Display each employee and their full chain of managers
Q2	Running Total	Calculate cumulative salary totals by hire date
Q3	Top Earners per Department	Identify the top 2 earners and their % of total department salary
Q4	Hiring Growth	Find 3 consecutive years of increasing hires
Q5	Recursive Year Expansion	Generate a list of years from the earliest hire to the current year
Q6	Employee Growth Trend	Display yearly hires and cumulative total hires
Q7	Department Projection	Project department employee counts assuming 10% attrition per year
Q8	Top Managers	Find top 3 managers with the highest average team salary
Q9	Hiring Cohort Analysis	Group employees by decade of hire and analyze average salary

## 🧩 Example Highlights
🔁 Recursive CTE for Management Chain
sql
Copy code
WITH RECURSIVE management_chain AS (
  SELECT emp_id, emp_name, manager_id, emp_name AS chain
  FROM employees
  WHERE manager_id IS NULL
  UNION ALL
  SELECT e.emp_id, e.emp_name, e.manager_id,
         CONCAT_WS('->', e.emp_name, mc.chain) AS chain
  FROM employees e
  JOIN management_chain mc ON e.manager_id = mc.emp_id
)
SELECT * FROM management_chain;
```
This query elegantly explores hierarchical data, showing every employee’s path up to their top-level manager.

## 🧮 Learning Outcomes
By completing these queries, you’ll strengthen your understanding of:

Recursive and hierarchical data modeling

Complex aggregations and analytical window functions

Trend and projection analysis using SQL logic

Real-world MySQL query design and optimization patterns

## 💡 Tip
Experiment with modifying filters (e.g., specific departments or salary ranges) to test your understanding of window functions and recursive queries.

## 🧠 About
This practice collection was built by Joel Osei as part of a structured SQL learning journey — from fundamentals to advanced analytics.
It’s ideal for:

Technical interview preparation

Data analysis challenges

SQL mastery for backend or analytics roles

[⬅️ Back to Main SQL Practice Collection](https://github.com/Oseij96/SQL-Practice-Collection/blob/main/readme.md)