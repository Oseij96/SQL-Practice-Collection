# 🧩 SQL Practice Collection – Part 8 (Advanced)

### Author: **Joel Osei**  
### Database: **MySQL**

---

## 📘 Overview

Part 8 focuses on **advanced managerial and departmental SQL queries**, including:

- **Salary-based analyses** (above average, median, highest/second-highest)  
- **Manager-team relationships** (direct reports, team totals, min/max/avg salaries)  
- **Departmental benchmarks**  
- **Ranking and window functions** (DENSE_RANK, PERCENT_RANK)  

These queries are designed to **simulate real-world business scenarios** and strengthen skills for **complex SQL analytics and interviews**.

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
| Q1 | Employees > 70k with Manager | Employees who have a manager and earn > 70,000 |
| Q2 | No Subordinates > 50k | Employees with no subordinates earning > 50,000 |
| Q3 | Managers with Direct Reports > Company Avg | Managers who have at least one direct report earning above the company average |
| Q4 | Departments with Employee > 100k | Departments that have at least one employee earning > 100,000 |
| Q5 | Only Employee & No Manager | Employees who are the only one in their department and have no manager |
| Q6 | Managers with Max Salary > 90k | Managers whose team’s maximum salary is above 90,000 |
| Q7 | Managers with Min Salary ≥ 60k | Managers whose team’s minimum salary is at least 60,000 |
| Q8 | Managers with Total Team Salary > 150k | Managers whose total team salary exceeds 150,000 |
| Q9 | Managers with Avg Team Salary > Manager | Managers whose team’s average salary is higher than their own salary |
| Q10 | Managers with Direct Report > Self | Managers who have a direct report earning more than themselves |
| Q11 | Second Highest Salary Company | Find the second highest salary in the company |
| Q12 | Second Highest Salary per Dept | Find the second highest salary in each department |
| Q13 | Salary Above Dept Avg < Max Company | Employees earning above department average but below company max salary |
| Q14 | Median Salary per Dept | Find the median salary per department |
| Q15 | Rank Employees by Salary per Hire Year | Rank employees by salary, resetting the rank each year of hire |

---

## ⚙️ Setup

1. Ensure **MySQL 8.0+** is installed.  
2. Load the database schema and sample data:

```sql
-- Create tables
SOURCE ../sample_data/create_tables.sql;

-- Insert sample data
SOURCE ../sample_data/sample_data.sql;

-- Run advanced queries (Q1–Q15)
SOURCE advanced-sql-practice-part_8.sql;
```
[⬅️ Back to Main SQL Practice Collection](https://github.com/Oseij96/SQL-Practice-Collection/blob/main/readme.md)