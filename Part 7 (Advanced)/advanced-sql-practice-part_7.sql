-- Part 7 – Advanced SQL Queries
-- Focus: Recursive CTEs, window functions, trend analysis, and multi-level joins

-- Q1. Department Salary Comparison
WITH avg_dept AS (
    SELECT dept_id, AVG(salary) AS dept_avg
    FROM employees
    GROUP BY dept_id
)
SELECT e.emp_name AS employee,
       d.dept_name AS department,
       e.salary - a.dept_avg AS salary_diff
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
JOIN avg_dept a ON e.dept_id = a.dept_id
ORDER BY salary_diff DESC;


-- Q2. Manager Salary Ranking
WITH team_avg AS (
    SELECT m.emp_name AS manager,
           AVG(e.salary) AS avg_team_sal
    FROM employees m
    JOIN employees e ON m.emp_id = e.manager_id
    GROUP BY m.emp_id, m.emp_name
)
SELECT manager,
       avg_team_sal,
       DENSE_RANK() OVER (ORDER BY avg_team_sal DESC) AS rnk
FROM team_avg;


-- Q3. Hiring Trend by Year
WITH hiring_year AS (
    SELECT YEAR(hire_date) AS hire_year, COUNT(*) AS hire_count
    FROM employees
    GROUP BY hire_year
),
yearly_growth AS (
    SELECT hire_year,
           hire_count,
           LAG(hire_count) OVER (ORDER BY hire_year) AS prev_year_hires
    FROM hiring_year
)
SELECT hire_year, hire_count, prev_year_hires
FROM yearly_growth
WHERE hire_count > prev_year_hires;


-- Q4. Department Growth (Last 5 Years)
WITH last_five_years AS (
    SELECT dept_id, COUNT(*) AS dept_hires
    FROM employees
    WHERE hire_date >= DATE_SUB(CURDATE(), INTERVAL 5 YEAR)
    GROUP BY dept_id
)
SELECT d.dept_id,
       d.dept_name AS department,
       l.dept_hires
FROM departments d
JOIN last_five_years l ON d.dept_id = l.dept_id
WHERE l.dept_hires > 10;


-- Q5. Manager vs Subordinates Salary Gap
WITH average AS (
    SELECT m.emp_name AS manager,
           m.salary AS managers_sal,
           AVG(e.salary) AS avg_team_sal
    FROM employees m
    JOIN employees e ON m.emp_id = e.manager_id
    GROUP BY m.emp_id, m.emp_name
)
SELECT manager, managers_sal, avg_team_sal
FROM average
WHERE managers_sal < avg_team_sal;


-- Q6. Salary Percentiles (Quartiles)
WITH quarts AS (
    SELECT emp_name AS employee,
           salary,
           NTILE(4) OVER (ORDER BY salary DESC) AS sal_quarts
    FROM employees
)
SELECT employee, salary, sal_quarts
FROM quarts
WHERE sal_quarts = 1;


-- Q7. Tenure and Department Average
WITH tenure AS (
    SELECT d.dept_name AS department,
           d.dept_id,
           TIMESTAMPDIFF(YEAR, e.hire_date, CURDATE()) AS years_served
    FROM departments d
    JOIN employees e ON d.dept_id = e.dept_id
)
SELECT dept_id, department, AVG(years_served) AS avg_tenure
FROM tenure
GROUP BY dept_id
HAVING AVG(years_served) > 7;


-- Q8. Consecutive Hiring Years
WITH dept_years AS (
    SELECT DISTINCT e.dept_id,
           d.dept_name AS department,
           YEAR(e.hire_date) AS hire_year
    FROM departments d
    JOIN employees e ON d.dept_id = e.dept_id
),
numbered AS (
    SELECT dept_id,
           department,
           hire_year,
           ROW_NUMBER() OVER (PARTITION BY dept_id ORDER BY hire_year) AS rn
    FROM dept_years
)
SELECT department,
       MIN(hire_year) AS start_year,
       MAX(hire_year) AS end_year
FROM numbered
GROUP BY dept_id, department, (hire_year - rn)
HAVING COUNT(*) >= 3;


-- Q9. Employee Retention Insight
WITH hire_group AS (
    SELECT YEAR(hire_date) AS hire_year,
           AVG(salary) AS avg_sal,
           COUNT(*) AS emp_count
    FROM employees
    GROUP BY hire_year
)
SELECT hire_year, avg_sal, emp_count
FROM hire_group
WHERE avg_sal < (SELECT AVG(salary) FROM employees);


-- Q10. Nested CTE Challenge (Top 3 Departments by Total Salary)
WITH dept_total AS (
    SELECT dept_id, SUM(salary) AS dept_sum
    FROM employees
    GROUP BY dept_id
),
ranker AS (
    SELECT dt.dept_id,
           dt.dept_sum,
           d.dept_name AS department,
           DENSE_RANK() OVER (ORDER BY dt.dept_sum DESC) AS rnk
    FROM dept_total dt
    JOIN departments d ON dt.dept_id = d.dept_id
)
SELECT r.department AS department,
       r.dept_sum AS dept_sum,
       e.emp_name AS employee
FROM ranker r
JOIN employees e ON e.dept_id = r.dept_id
WHERE r.rnk <= 3;
