-- 1. Employees who have a manager and earn more than 70,000.

SELECT e.emp_name, e.salary
FROM employees e
JOIN employees m
ON e.manager_id = m.emp_id
WHERE e.manager_id IS NOT NULL
AND e.salary > 70000;

-- 2. Employees who don’t have any subordinates but their salary is above 50,000.

SELECT e.emp_name
FROM employees e
WHERE EXISTS(
	SELECT 1
    FROM employees sub
    WHERE sub.emp_id = e.manager_id 
)
AND e.salary > 50000;

-- 3. Managers who have at least one direct report earning more than the company average salary.

SELECT m.emp_name
FROM employees m
WHERE EXISTS(
	SELECT 1
    FROM employees e
    WHERE e.manager_id = m.emp_id
    AND e.salary > (SELECT AVG(salary) FROM employees)
);

-- 4. Departments that have at least one employee earning above 100,000.

SELECT d.dept_name
FROM departments d
WHERE EXISTS(
	SELECT 1
    FROM employees e
    WHERE e.dept_id = d.dept_id
    AND e.salary > 100000
);

-- 5. Employees who are the only one in their department and have no manager.

SELECT e.emp_name
FROM employees e
WHERE e.manager_id IS NULL
AND e.emp_id IN
	(SELECT e2.dept_id
    FROM employees e2
    WHERE e2.dept_id = e.dept_id
    GROUP BY e2.dept_id
	HAVING COUNT(*) = 1
);

-- 6. Managers whose team’s maximum salary is above 90,000.

SELECT m.emp_name
FROM employees m
JOIN employees e
ON e.manager_id = m.emp_id
GROUP BY m.emp_id, m.emp_name
HAVING MAX(e.salary) > 90000;

-- 7. Managers whose team’s minimum salary is at least 60,000.

SELECT m.emp_name
FROM employees m
JOIN employees e
ON e.manager_id = m.emp_id
GROUP BY m.emp_id, m.emp_name
HAVING MIN(e.salary) > 60000;

-- 8. Managers whose total team salary exceeds 150,000.

SELECT m.emp_name
FROM employees m
WHERE m.emp_id IN
	(SELECT e.manager_id
    FROM employees e
    WHERE e.manager_id = m.emp_id
    GROUP BY e.manager_id
    HAVING SUM(e.salary) > 150000
    );

-- 9. Managers whose team’s average salary is higher than the manager’s own salary.

SELECT m.emp_name
FROM employees m
WHERE m.emp_id IN(
	SELECT e.manager_id
    FROM employees e
    WHERE e.manager_id = m.emp_id
    GROUP BY e.manager_id
    HAVING AVG(e.salary) > m.salary
);

-- 10. Managers who have a direct report earning more than the manager themselves. 

SELECT m.emp_name
FROM employees m
WHERE EXISTS(
	SELECT 1
    FROM employees e
    WHERE e.manager_id = m.emp_id
    AND e.salary > m.salary
);

-- 11. Find the second highest salary in the company.

SELECT *
FROM(
	SELECT emp_name,
		   salary,
           DENSE_RANK() OVER(ORDER BY salary DESC) AS rnk
	FROM employees
) ranked
WHERE rnk = 2;

-- 12. Find the second highest salary per department.

SELECT *
FROM(
	SELECT emp_name,
		   salary,
           dept_id,
           DENSE_RANK() OVER(PARTITION BY dept_id ORDER BY salary DESC) AS rnk
	FROM employees
) ranked
WHERE rnk = 2;

-- 13. Find employees whose salary is above their department’s average but below the maximum salary in the company.

SELECT *
FROM(
	SELECT e.emp_name,
		   e.salary AS emp_sal,
           AVG(e.salary) OVER(PARTITION BY e.dept_id) AS avg_dept_sal,
           DENSE_RANK() OVER(ORDER BY salary) AS highest_sal
	FROM employees e
) ranked
WHERE emp_sal > avg_dept_sal
AND emp_sal < highest_sal;


-- 14. Find the median salary per department.

SELECT *
FROM(
	SELECT emp_name,
		   salary,
           PERCENT_RANK() OVER(PARTITION BY dept_id) AS pct_rnk
	FROM employees
) ranked
WHERE pct_rnk = 0.5;

-- 15. Rank employees by salary, resetting the rank every year of hire.

SELECT *
FROM(
	SELECT emp_name,
		   salary,
           hire_date,
           DENSE_RANK() OVER(PARTITION BY hire_date ORDER BY salary DESC) rnk
	FROM employees
) ranked
WHERE rnk = 1; 