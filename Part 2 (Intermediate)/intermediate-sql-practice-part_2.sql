-- 1. Find employees whose salary is less than 40,000.

SELECT emp_name, salary
FROM employees
WHERE salary < 40000;

-- 2. Show employees who were hired after the year 2020.

SELECT emp_name, hire_date
FROM employees
WHERE YEAR(hire_date) > 2020;

-- 3. List employees who work in the "Finance" department.

SELECT e.emp_name
FROM employees e
JOIN departments d
ON e.dept_id = d.dept_id
WHERE dept_name = 'Finance';

-- 4. Find employees whose manager_id equals 201.

SELECT emp_name, manager_id
FROM employees
WHERE manager_id = '201';

-- 5. Show departments with names starting with the letter "S".

SELECT dept_name
FROM departments
WHERE dept_name like 'S%';

-- 6. Find employees who earn less than the average salary of the company.

SELECT emp_name, salary
FROM employees
WHERE salary < (SELECT AVG(salary) FROM employees);

-- 7. List employees who were hired on the same date as someone else.

SELECT e1.emp_name, e2.hire_date
FROM employees e1
JOIN employees e2
ON e1.hire_date = e2.hire_date
AND e1.emp_id <> e2.emp_id;

-- 8. Show managers who do not report to anyone (i.e., they are top-level).

SELECT emp_name, manager_id
FROM employees
WHERE manager_id IS NULL;


-- 9. Find employees who work in the same department as "Eve".

SELECT emp_name, dept_id
FROM employees
WHERE dept_id = 
	(SELECT dept_id FROM employees WHERE emp_name = 'Eve');


-- 10. List departments that have more than 3 employees.

SELECT dept_name
FROM departments d
JOIN employees e
ON e.dept_id = d.dept_id
GROUP BY d.dept_id, d.dept_name
HAVING COUNT(*) > 3;


-- 11. Find employees whose salary is above their department’s average salary.

SELECT *
FROM (
	SELECT emp_name,
		   salary,
           dept_id,
           AVG(salary) OVER(PARTITION BY dept_id) dept_avg
	FROM employees
    ) e
WHERE salary > dept_avg;


-- 12. Show employees who have the same hire date as their manager.


