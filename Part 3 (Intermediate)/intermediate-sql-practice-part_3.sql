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
WHERE manager_id = 201;


--  5. Show departments with names starting with the letter "S".

SELECT dept_name
FROM departments
WHERE dept_name like 'S%';


-- 6. Find employees who earn less than the average salary of the company.

SELECT emp_name
FROM employees
WHERE salary < (SELECT AVG(salary) FROM employees);


-- 7. List employees who were hired on the same date as someone else.

SELECT e.emp_name, e.hire_date
FROM employees e
JOIN employees e2 
	ON e.hire_date = e2.hire_date
AND e.emp_id <> e2.emp_id;


-- 8. Show managers who do not report to anyone (i.e., they are top-level).

SELECT DISTINCT m.emp_name as manager_name, m.emp_id AS managers_id
FROM employees m
WHERE m.manager_id IN(
	SELECT emp_id FROM employees WHERE manager_id IS NULL
    );

-- 9. Find employees who work in the same department as "Eve".

SELECT emp_name, dept_id
FROM employees
WHERE dept_id =
	(SELECT dept_id FROM employees WHERE emp_name = 'Eve');


-- 10. List departments that have more than 3 employees.

SELECT d.dept_name
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
           AVG(salary) OVER(PARTITION BY dept_id) AS avg_dept_sal
	FROM employees
) ranked
WHERE salary > avg_dept_sal;


-- 12. Show employees who have the same hire date as their manager.

SELECT e.emp_name, e.hire_date
FROM employees e
JOIN employees m
	ON e.manager_id = m.emp_id
WHERE e.hire_date = m.hire_date;


-- 13. List departments where the highest salary is greater than 90,000.

SELECT dept_name
FROM departments d
JOIN employees e
	ON e.dept_id = d.dept_id
GROUP BY d.dept_id, d.dept_name 
HAVING MAX(salary) > 90000;

-- 14. Find employees whose salary is equal to the minimum salary in the company.

SELECT emp_name, salary
FROM employees
WHERE salary = (SELECT MIN(salary) FROM employees);

    
-- 15. Show employees whose salary is higher than all employees in HR.

SELECT e.emp_name, d.dept_name, e.salary
FROM employees e
JOIN departments d
	ON e.dept_id = d.dept_id
WHERE e.salary >
	(SELECT MAX(salary) 
	FROM employees e2
    JOIN departments d2
		ON e2.dept_id = d2.dept_id
	WHERE d2.dept_name = 'HR'
    );
    
-- 16. Find the third highest salary in the company.

SELECT *
FROM (
	SELECT emp_name,
		   salary,
           DENSE_RANK() OVER(ORDER BY salary DESC) AS rnk
	FROM employees
) ranked
WHERE rnk = 3;


-- 17.  List the top 2 highest-paid employees in each department

SELECT *
FROM (
	SELECT emp_name,
		   salary,
           DENSE_RANK() OVER(PARTITION BY dept_id ORDER BY salary DESC) AS rnk
	FROM employees
) ranked
WHERE rnk = 1 OR rnk = 2;

-- 18. Find employees who earn more than the highest-paid employee in "Finance".

SELECT e.emp_name
FROM employees e
JOIN departments d
	ON e.dept_id = d.dept_id
WHERE e.salary >
	(SELECT MAX(salary)
    FROM employees e2
    JOIN departments d2
		ON e2.dept_id = d2.dept_id
    WHERE d2.dept_name = 'Finance'
    );
    
    
-- 19. Show managers whose team has at least one employee earning more than 70,000.

SELECT DISTINCT m.emp_name AS managers_name, m.emp_id AS managers_id, e.emp_id, e.emp_name, e.salary
FROM employees m
JOIN employees e
	ON e.manager_id = m.emp_id
WHERE e.salary > 70000;


-- 20. Find employees whose salary is greater than their department’s average but less than the company average.

SELECT *
FROM (
	SELECT emp_name,
		   salary,
           AVG(salary) OVER(PARTITION BY dept_id) AS avg_dept_sal
	FROM employees
) avg_sal
WHERE salary > avg_dept_sal AND salary < (SELECT AVG(salary) FROM employees);

-- 21. List departments where no employee earns below 50,000.

SELECT d.dept_name, d.dept_id
FROM departments d
JOIN employees e
	ON e.dept_id = d.dept_id
GROUP BY d.dept_id, d.dept_name
HAVING MIN(e.salary) >= 50000;

-- 22. Find employees who do not have any subordinates (nobody reports to them).

SELECT emp_name, manager_id
FROM employees
WHERE emp_id NOT IN
	(SELECT DISTINCT manager_id FROM employees WHERE manager_id IS NOT NULL);

    
-- 23. Find employees whose hire date is the earliest in the company, but who are not in HR.

SELECT e.emp_name, e.hire_date
FROM employees e
JOIN departments d
	ON e.dept_id = d.dept_id
WHERE e.hire_date =
	(SELECT MIN(e.hire_date) FROM employees)
AND d.dept_name <> 'HR';

-- 24. Find departments where the total salary is higher than the total salary of HR.

SELECT d.dept_name, SUM(e.salary) AS total_dept_sal
FROM departments d
JOIN employees e
	ON e.dept_id = d.dept_id
GROUP BY d.dept_id, d.dept_name    
HAVING SUM(salary) >
	(SELECT SUM(e2.salary)
    FROM employees e2
    JOIN departments d2
		ON e2.dept_id = d2.dept_id
	WHERE d2.dept_name = 'HR'
    );