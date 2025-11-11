# Advanced SQL Practice – Part 7

## Overview
Part 7 dives into **recursive CTEs, complex joins, window functions, and real-world analytical problems**.  
These challenges simulate HR, performance, and trend-based scenarios that combine multi-level logic with practical reporting.

## Tables Used
- `employees`
- `departments`

## Queries
- Q1: Department Salary Comparison  
- Q2: Manager Salary Ranking  
- Q3: Hiring Trend by Year  
- Q4: Department Growth (Last 5 Years)  
- Q5: Manager vs Subordinates Salary Gap  
- Q6: Salary Percentiles (Quartiles)  
- Q7: Tenure and Department Average  
- Q8: Consecutive Hiring Years  
- Q9: Employee Retention Insight  
- Q10: Nested CTE Challenge (Top 3 Departments by Total Salary)

## Difficulty
Advanced – Analytical & Recursive CTE Level

## ⚙️ Setup

1. Ensure you have **MySQL 8.0+** installed (for window functions and subquery support).  
2. Create your schema and load the `employees` and `departments` tables.  
3. Run the following scripts in order:

```sql
-- Create tables
SOURCE ../sample_data/create_tables.sql;

-- Insert sample data
SOURCE ../sample_data/sample_data.sql;


SOURCE advanced-sql-practice-part_7.sql;
```
[⬅️ Back to Main SQL Practice Collection](https://github.com/Oseij96/SQL-Practice-Collection/blob/main/readme.md)