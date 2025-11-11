# Advanced SQL Practice – Part 6

## Overview
This part focuses on **subqueries, aggregation, window functions, and conditional filtering**.  
It demonstrates salary comparisons, departmental analysis, and hierarchical employee queries.

## Tables Used
- `employees`
- `departments`

## Queries
- Q1: Employees earning below the company average salary
- Q2: Employees in the same department as Bob
- Q3: Departments with more than 5 employees
- Q4: Employees who have a manager
- Q5: Employees earning the maximum salary in their department
- Q6: Employees hired after the latest hire date in Finance
- Q7: Employees with a salary matching someone in Sales but not in Sales
- Q8: Departments where every employee earns at least 60,000
- Q9: Employees earning less than their manager
- Q10: Managers with subordinates in different departments
- Q11: Employees who don’t manage anyone
- Q12: Managers whose team’s minimum salary > 55,000
- Q13: Departments with no employees earning over 100,000
- Q14: Employees hired before their manager
- Q15: Employees earning more than all HR employees
- Q16: Third highest salary in the company
- Q17: Top 2 salaries per department
- Q18: Employees above department average but below the company max
- Q19: Managers whose team salary < company average
- Q20: Employees who are the only person in their department and have no manager

## Difficulty
Advanced

## ⚙️ Setup

1. Ensure **MySQL 8.0+** is installed.  
2. Load the database schema and sample data:

```sql
-- Create tables
SOURCE ../sample_data/create_tables.sql;

-- Insert sample data
SOURCE ../sample_data/sample_data.sql;


SOURCE advanced-sql-practice-part_6.sql;
```
[⬅️ Back to Main SQL Practice Collection](https://github.com/Oseij96/SQL-Practice-Collection/blob/main/readme.md)
