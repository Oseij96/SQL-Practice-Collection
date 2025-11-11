# 🧩 SQL Practice Collection – Part 1 (Beginner)

### Author: **Joel Osei**  
### Database: **MySQL**

---

## 📘 Overview

This part of the SQL Practice Collection focuses on **core SQL fundamentals** — filtering, joins, grouping, subqueries, and logical comparisons.  
It is designed to strengthen query-building confidence using simple yet practical business problems.

You’ll explore tasks such as:
- Comparing employees’ salaries and hire dates  
- Identifying managers and direct reports  
- Working with departments and shared attributes  
- Using aggregate functions and subqueries  

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
| Q1 | Salary Filter | Find employees earning more than 50 000 |
| Q2 | No Manager | Show employees without an assigned manager |
| Q3 | Salary vs Manager | Find employees who earn more than their manager |
| Q4 | Early Hire | List employees hired before their manager |
| Q5 | Active Departments | Show departments that have at least one employee |
| Q6 | Shared Manager | Find employees who share the same manager |
| Q7 | Manager Reports | Show managers who have ≥ 2 direct reports |
| Q8 | Above Dept Average | Find employees earning above their department average |
| Q9 | Cross-Dept Same Pay | Employees with the same salary in different departments |
| Q10 | Top Earners | Find employees who are the highest-paid in their department |
| Q11 | Empty Departments | Show departments with no employees |
| Q12 | Pre-HR Hire | Find employees hired before everyone in HR |
| Q13 | Second Highest | Find the second-highest salary company-wide |
| Q14 | Second Highest by Dept | Find the second-highest salary per department |
| Q15 | Cross-Dept Comparison | Employees earning more than any other department |
| Q16 | Salary Between Dept Avg and Manager | Above dept average but below manager salary |
| Q17 | Solo Employees | Employees with no coworkers in their department |
| Q18 | High-Performing Departments | Departments where all salaries > company average |

---

## ⚙️ Setup

1. Ensure you have **MySQL 8.0+** installed (for window functions and subquery support).  
2. Create your schema and load the `employees` and `departments` tables.  
3. Run the following scripts in order:

```sql
-- Create tables
SOURCE ../sample_data/create_tables.sql;

-- Insert sample data
SOURCE ../sample_data/sample_data.sql;

-- Run beginner queries (Q1–Q18)
SOURCE beginner-sql-practice-part_1.sql;
```
[⬅️ Back to Main SQL Practice Collection](https://github.com/Oseij96/SQL-Practice-Collection/blob/main/readme.md)