# 🧩 SQL Practice Collection – Part 2 (Intermediate)

### Author: **Joel Osei**  
### Database: **MySQL**

---

## 📘 Overview

This part of the SQL Practice Collection focuses on **intermediate-level SQL techniques**.  
It introduces more complex filtering, grouping, and data comparisons using **aggregations**, **subqueries**, and **joins** to solve realistic analytical problems.

You’ll explore:
- Correlated subqueries  
- Aggregation by groups and categories  
- Conditional filtering with HAVING  
- Comparing performance across departments and employees  

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
| Q1 | Dept Salary Summary | Show total, avg, min, and max salary per department |
| Q2 | Above Dept Avg | Employees earning above their department average |
| Q3 | Top Department by Avg Salary | Department with the highest average salary |
| Q4 | Manager Comparison | Find managers who earn less than their subordinates |
| Q5 | Salary Gap | Show salary difference between highest and lowest earner per department |
| Q6 | Early Hires by Dept | Earliest hire date per department |
| Q7 | Employees per Dept | Count employees in each department |
| Q8 | Manager Report Count | Show number of direct reports per manager |
| Q9 | Department Ranking | Rank departments by total salary expenditure |
| Q10 | Employee Salary Percentile | Compute salary percentiles using window functions |
| Q11 | Above Company Avg | Employees earning above overall company average |
| Q12 | Young Departments | Departments where avg hire date is after 2018 |
| Q13 | Salary Distribution | Show number of employees per salary bracket |
| Q14 | Equal Avg Salary | Departments with the same average salary |
| Q15 | Salary Growth | Compare current vs previous year's total salaries |
| Q16 | Bonus Allocation | Add 10% bonus for employees below dept average |
| Q17 | Shared Dept Heads | Managers overseeing multiple departments |
| Q18 | Top 3 Departments | Departments with top 3 highest total salaries |

---

## ⚙️ Setup

1. Ensure you have **MySQL 8.0+** installed (for window and ranking functions).  
2. Create your schema and load the `employees` and `departments` tables.  
3. Run the following scripts in order:

```sql
-- Create tables
SOURCE ../sample_data/create_tables.sql;

-- Insert sample data
SOURCE ../sample_data/sample_data.sql;

-- Run intermediate queries (Q1–Q18)
SOURCE intermediate-sql-practice-part_2.sql;
```
[⬅️ Back to Main SQL Practice Collection](../README.md)
