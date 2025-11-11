/*
============================================================
📘 Advanced SQL Practice Collection
Author: Joel Osei
Description:
A comprehensive set of advanced SQL exercises, covering:
- Window functions (RANK, LAG, NTILE, etc.)
- Recursive CTEs for hierarchical and date expansions
- Aggregation, filtering, and cohort analysis
- Subqueries and EXISTS logic
- Analytical insights for hiring, salary, and management trends
- Department projections and growth trends

Tables assumed:
  - employees(emp_id, emp_name, salary, hire_date, manager_id, dept_id)
  - departments(dept_id, dept_name)

Database: MySQL
============================================================
*/



-- Q1.
-- 🧩 Recursive CTE: Find the full management chain for each employee.
-- (Use a recursive CTE to show each employee along with their chain of managers.)

WITH RECURSIVE management_chain AS(
	SELECT emp_id,
		   emp_name,
           manager_id,
           emp_name AS chain
	FROM employees
    WHERE manager_id IS NULL
    
    UNION ALL
    
    SELECT e.emp_id,
           e.emp_name,
           e.manager_id,
           CONCAT_WS('->', e.emp_name, mc.chain) AS chain
	FROM employees e
	JOIN management_chain mc
		ON e.manager_id = mc.emp_id
)
SELECT *
FROM management_chain;

-- Q2.
-- 📈 Running Total: For all employees, display their salary along with
-- a running total of salaries ordered by hire_date.

SELECT emp_name,
	   salary,
       hire_date,
       SUM(salary) OVER(ORDER BY hire_date) AS rolling_salary
FROM employees;


-- Q3.
-- 🏆 Find the top 2 earners per department and calculate their
-- salary as a percentage of their department’s total salary.

WITH ranked AS(
	SELECT emp_name,
		   dept_id,
           salary,
           DENSE_RANK() OVER(PARTITION BY dept_id ORDER BY salary DESC) AS rnk,
           SUM(salary) OVER(PARTITION BY dept_id) AS dept_total
	FROM employees
)
SELECT r.emp_name AS employee,
	   r.salary AS salary,
       d.dept_name AS department,
       r.dept_total AS dept_total,
       ROUND((salary / dept_total * 100), 2) AS salary_percent
FROM ranked r
JOIN departments d
	ON r.dept_id = d.dept_id
WHERE r.rnk <= 2
ORDER BY department, salary;
       
-- Q4.
-- 📊 Identify 3 consecutive years where hiring increased each year.
-- (Hint: Compare hire counts per year using a CTE.)

WITH hcpy AS(
	SELECT YEAR(hire_date) AS hire_year,
		   COUNT(*) AS hire_count
	FROM employees
    GROUP BY hire_year
)
SELECT h1.hire_year AS start_year,
	   h1.hire_count AS year1_hires,
	   h2.hire_year AS mid_year,
       h2.hire_count AS year2_hires,
       h3.hire_year AS end_year,
       h3.hire_count AS year3_hires
FROM hcpy h1
JOIN hcpy h2
	ON h2.hire_year = h1.hire_year + 1
JOIN hcpy h3
	ON h3.hire_year = h1.hire_year + 2
WHERE h1.hire_count < h2.hire_count
AND h2.hire_count < h3.hire_count;

-- Q5.
-- 🔁 Recursive Date Expansion: List all years from the earliest hire date
-- up to the current year.

WITH RECURSIVE year_list AS(
	SELECT YEAR(MIN(hire_date)) AS hire_year
    FROM employees
    
    UNION ALL
    
    SELECT hire_year + 1
    FROM year_list
    WHERE hire_year < YEAR(CURDATE())
)
SELECT *
FROM year_list;

-- Q6.
-- 📅 Employee Growth Trend: Show total hires per year and a cumulative
-- total of all hires up to that year.

WITH hires_per_year AS(
	SELECT YEAR(hire_date) AS hire_year,
		   COUNT(*) AS hire_count
	FROM employees
    GROUP BY hire_year
)
SELECT hire_year,
	   hire_count,
       SUM(hire_count) OVER(ORDER BY hire_year) AS cumulative_hires
FROM hires_per_year
ORDER BY hire_year;

-- Q7.
-- 🧮 Department Projection: Assume 10% of each department’s employees leave every year.
-- Project the remaining number of employees for each department over 5 years.

WITH RECURSIVE dept_projection AS(
	SELECT d.dept_id,
		   d.dept_name AS department,
           COUNT(e.emp_id) AS remaining_employees,
           0 AS year_num
	FROM departments d
    JOIN employees e
		ON d.dept_id = e.dept_id
	GROUP BY d.dept_id, department
    
    UNION ALL
    
    SELECT dp.dept_id,
		   dp.department,
           ROUND((dp.remaining_employees * 0.9), 2) AS remaining_employees,
           dp.year_num + 1 AS year_num
	FROM dept_projection dp
    WHERE dp.year_num < 5
)
SELECT dept_id,
	   department,
       remaining_employees,
       year_num
FROM dept_projection
ORDER BY department, year_num;


-- Q8.
-- 👑 Top Managers: Find the top 3 managers with the highest average
-- team salary (only consider teams with more than 3 members).

SELECT m.emp_id AS manager_id,
	   m.emp_name AS manager,
       COUNT(e.emp_id) AS team_count,
       ROUND(AVG(e.salary), 2) AS avg_team_salary
FROM employees m
JOIN employees e
	ON m.emp_id = e.manager_id
GROUP BY m.emp_id, m.emp_name
HAVING COUNT(e.emp_id) > 3
ORDER BY avg_team_salary DESC
LIMIT 3;


-- Q9.
-- 🧠 Hiring Cohort Analysis: Group employees by decade of hire
-- (e.g., 2000s, 2010s) and show average salary and total employees in each group.

SELECT CONCAT(FLOOR(YEAR(hire_date) / 10) * 10, 's') AS hire_decade,
	   COUNT(*) AS total_employees,
       ROUND(AVG(salary), 2) AS avg_salary
FROM employees
GROUP BY hire_decade
ORDER BY hire_decade;

-- ✅ End of Advanced SQL Queries Collection
-- Created by Joel Osei