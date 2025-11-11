# Advanced SQL Practice – Part 5

## Overview
This part contains SQL queries focusing on **subqueries, aggregation, and window functions**.  
It demonstrates analyzing employee salaries, departmental stats, and manager-subordinate relationships.

## Tables Used
- `employees`
- `departments`

## Queries
- Q1: Employees earning more than the company average salary
- Q2: Employees in the same department as Alice
- Q3: Departments with at least one employee
- Q4: Employees without a manager
- Q5: Employees earning above their department’s average
- Q6: Employees hired before the earliest hire date in HR
- Q7: Employees sharing a salary with someone in another department
- Q8: Departments where no employee earns below 50,000
- Q9: Employees earning more than their manager
- Q10: Employees with at least one direct report
- Q11: Employees without any subordinates
- Q12: Managers whose team salary exceeds 100,000
- Q13: Departments with no employees assigned
- Q14: Employees hired after their manager
- Q15: Employees earning more than all Finance employees
- Q16: Second highest salary in the company
- Q17: Second highest salary per department
- Q18: Employees above department average but below their manager
- Q19: Managers whose team’s average salary exceeds company average
- Q20: Employees with no coworkers in their department

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


SOURCE advanced-sql-practice-part_5.sql;
```
[⬅️ Back to Main SQL Practice Collection](../README.md)