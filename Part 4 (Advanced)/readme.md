# 🧩 SQL Practice Collection – Part 4 (Advanced)

### Author: **Joel Osei**  
### Database: **MySQL**

---

## 📘 Overview

Part 4 contains **advanced-level SQL challenges**, focusing on:

- **Complex window functions** (DENSE_RANK, AVG OVER, etc.)  
- **Managerial and departmental comparisons**  
- **Salary hierarchy and coworker analysis**  
- **Subqueries and EXISTS/NOT EXISTS patterns**  

These queries simulate **real-world business scenarios** and prepare you for **advanced SQL interviews** and analytics tasks.

---

## 🧩 Database Schema

### **`employees`**
| Column | Type | Description |
|:--------|:------|:------------|
| emp_id | INT | Unique employee ID |
| emp_name | VARCHAR | Employee name |
| salary | DECIMAL | Current salary |
| hire_date | DATE | Date of hire |
| manager_id | INT | References another employee (their manager) |
| dept_id | INT | References the department ID |

### **`departments`**
| Column | Type | Description |
|:--------|:------|:------------|
| dept_id | INT | Unique department ID |
| dept_name | VARCHAR | Department name |

---

## 🗂️ Contents

| # | Topic | Description |
|:-:|:------|:-------------|
| Q1 | Salary = 60k | Employees earning exactly 60,000 |
| Q2 | Hired in 2023 | Employees hired in 2023 |
| Q3 | No Manager | Employees without an assigned manager |
| Q4 | Marketing or Sales | Employees in Marketing or Sales departments |
| Q5 | Name Starts with A | Employees whose name starts with "A" |
| Q6 | Below Dept Avg | Employees earning below their department average |
| Q7 | Same Manager as Bob | Employees sharing the same manager as "Bob" |
| Q8 | Managers ≥ 3 Reports | Managers with at least 3 direct reports |
| Q9 | Departments with 1 Employee | Departments that have exactly 1 employee |
| Q10 | Hired Before Manager | Employees hired before their manager |
| Q11 | Above Avg Other Depts | Employees earning above the average of all other departments |
| Q12 | Same Salary Other Dept | Employees whose salary equals someone in another department |
| Q13 | Highest Paid per Dept | Highest-paid employee in each department |
| Q14 | Earliest Hire IT Comparison | Employees hired before the earliest hire in IT |
| Q15 | Third Highest Salary | Employee(s) with the third highest salary |
| Q16 | Second Highest per Dept | Second highest salary per department |
| Q17 | Above Every Employee Other Dept | Employees earning more than every employee in another department |
| Q18 | Managers with Highest Team Salary | Managers whose team has the highest total salary |
| Q19 | Above Dept Avg Below Manager | Employees earning above department avg but below their manager |
| Q20 | No Coworkers | Employees without coworkers in their department |
| Q21 | Dept All > 60k | Departments where all employees earn above 60,000 |
| Q22 | Between Lowest & 2nd-Lowest | Employees earning between the lowest and second-lowest in their department |
| Q23 | Earliest Hire Not HR | Earliest hires excluding HR |

---

## ⚙️ Setup

1. Ensure **MySQL 8.0+** is installed.  
2. Load the database schema and sample data:

```sql
-- Create tables
SOURCE ../sample_data/create_tables.sql;

-- Insert sample data
SOURCE ../sample_data/sample_data.sql;

-- Run advanced queries (Q1–Q23)
SOURCE advanced-sql-practice-part_4.sql;
```
[⬅️ Back to Main SQL Practice Collection](../README.md)