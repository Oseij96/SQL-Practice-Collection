# 🧩 SQL Practice Collection – Part 3 (Intermediate)

### Author: **Joel Osei**  
### Database: **MySQL**

---

## 📘 Overview

This part of the SQL Practice Collection continues with **intermediate-level SQL challenges**, focusing on:

- **Window functions** (ROW_NUMBER, DENSE_RANK, AVG OVER, etc.)  
- **Complex joins and subqueries**  
- **Department and manager comparisons**  
- **Salary analysis and ranking**  

The queries here are designed to enhance your analytical skills and **prepare for real-world SQL tasks**, such as reporting, ranking, and departmental analysis.

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
| Q1 | Employees < 40k | Employees earning less than 40,000 |
| Q2 | Hired After 2020 | Employees hired after the year 2020 |
| Q3 | Finance Dept | Employees in the Finance department |
| Q4 | Manager = 201 | Employees whose manager_id is 201 |
| Q5 | Dept Names S% | Departments with names starting with “S” |
| Q6 | Below Company Avg | Employees earning below company average |
| Q7 | Same Hire Date | Employees sharing hire dates with others |
| Q8 | Top-level Managers | Managers who do not report to anyone |
| Q9 | Same Dept as Eve | Employees in the same department as “Eve” |
| Q10 | Dept > 3 Employees | Departments with more than 3 employees |
| Q11 | Above Dept Avg | Employees earning above department average |
| Q12 | Hire Date = Manager | Employees with same hire date as manager |
| Q13 | Dept Max > 90k | Departments with highest salary > 90,000 |
| Q14 | Minimum Salary | Employees earning the minimum salary in the company |
| Q15 | Above HR Max | Employees earning more than all HR employees |
| Q16 | Third Highest Salary | Employee(s) with third highest salary |
| Q17 | Top 2 per Dept | Top 2 highest-paid employees per department |
| Q18 | Above Finance Max | Employees earning more than Finance department max |
| Q19 | Managers w/ 70k+ Reports | Managers with team members earning > 70,000 |
| Q20 | Above Dept Avg < Company Avg | Employees earning above dept avg but below company avg |
| Q21 | Dept All ≥ 50k | Departments where no employee earns below 50,000 |
| Q22 | No Subordinates | Employees with no subordinates |
| Q23 | Earliest Hires Not HR | Earliest hires excluding HR |
| Q24 | Dept Salary > HR | Departments whose total salary exceeds HR |

---

## ⚙️ Setup

1. Ensure **MySQL 8.0+** is installed.  
2. Load the database schema and sample data:

```sql
-- Create tables
SOURCE ../sample_data/create_tables.sql;

-- Insert sample data
SOURCE ../sample_data/sample_data.sql;

-- Run intermediate queries (Q1–Q24)
SOURCE intermediate-sql-practice-part_3.sql;
```
[⬅️ Back to Main SQL Practice Collection](https://github.com/Oseij96/SQL-Practice-Collection/blob/main/readme.md)