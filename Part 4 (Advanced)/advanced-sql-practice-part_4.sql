-- 1.Find employees who earn exactly 60,000.

SELECT emp_name 
FROM employees
WHERE salary = 60000;


-- 2. List employees who were hired in 2023.

SELECT emp_name, hire_date
FROM employees 
WHERE YEAR(hire_date) = 2023;

-- 3. Show employees who do not have a manager assigned.

SELECT emp_name, manager_id
FROM employees
WHERE manager_id IS NULL;


-- 4. List employees in the "Marketing" or "Sales" departments.

SELECT e.emp_name, d.dept_name
FROM employees e
JOIN departments d
ON e.dept_id = d.dept_id
WHERE d.dept_name = 'Marketing' OR d.dept_name = 'Sales';


-- 5. Find employees whose name starts with "A".

SELECT emp_name
FROM employees
WHERE emp_name like 'A%';


-- 6. Find employees whose salary is less than their department’s average.

SELECT *
FROM(
	SELECT emp_name,
		   salary,
           dept_id,
           AVG(salary) OVER(PARTITION BY dept_id) AS avg_dept_sal
	FROM employees
) average
WHERE salary < average.avg_dept_sal;

-- 7. Show employees who share the same manager as "Bob".

SELECT e.emp_name, e.manager_id
FROM employees e
JOIN employees m
ON e.manager_id = m.emp_id
WHERE e.manager_id IN(
	SELECT e2.manager_id
    FROM employees e2
    WHERE e2.emp_name = 'Bob'
);

-- 8. List managers who have at least 3 direct reports.

SELECT m.emp_name AS manager
FROM employees m
WHERE EXISTS(
	SELECT 1
    FROM employees e
    WHERE e.manager_id = m.emp_id
    GROUP BY e.manager_id
    HAVING COUNT(*) >= 3
);

-- 9. Show departments that have exactly 1 employee.

SELECT d.dept_name
FROM departments d
JOIN employees e
ON d.dept_id = e.dept_id
GROUP BY d.dept_id, d.dept_name
HAVING COUNT(*) = 1;

-- 10. Find employees hired before their manager’s hire date.

SELECT e.emp_name AS employee, e.hire_date, m.emp_name AS manager, m.hire_date
FROM employees e
JOIN employees m
ON e.manager_id = m.emp_id
WHERE e.hire_date < m.hire_date;

-- 11. Find employees whose salary is higher than the average salary of all departments except their own.

SELECT e.emp_name AS employee, e.salary, e.dept_id
FROM employees e
WHERE e.salary > (
	SELECT AVG(e2.salary) 
    FROM employees e2
    WHERE e2.dept_id <> e.dept_id
    );

-- 12. List employees whose salary is equal to another employee in a different department.

SELECT DISTINCT e.emp_name, e.salary
FROM employees e
JOIN employees e2
ON e.salary = e2.salary
WHERE e.dept_id <> e2.dept_id;


-- 13. Find the highest-paid employee in each department.

SELECT *
FROM(
	SELECT emp_name,
		   salary,
           DENSE_RANK() OVER(PARTITION BY dept_id ORDER BY salary DESC) AS rnk
	FROM employees
) ranked
WHERE rnk = 1;


-- 14. Show employees whose hire date is earlier than the earliest hire date in the IT department.

SELECT e.emp_name, e.hire_date
FROM employees e
WHERE e.hire_date < (
	SELECT MIN(e2.hire_date)
    FROM employees e2
    JOIN departments d
    ON e2.dept_id = d.dept_id
    AND e2.dept_id = e.dept_id
    WHERE d.dept_name = 'IT'
);

-- 15. Find the third highest salary in the company.

SELECT *
FROM(
	SELECT emp_name,
		   salary,
           DENSE_RANK() OVER(ORDER BY salary DESC) AS rnk
	FROM employees
) ranked
WHERE rnk = 3;


-- 16. List the second highest salary per department.

SELECT *
FROM(
	SELECT emp_name,
		   salary,
           DENSE_RANK() OVER(PARTITION BY dept_id ORDER BY salary DESC) AS rnk
	FROM employees
) ranked
WHERE rnk = 2;


-- 17. Find employees who earn more than every employee in another department.

SELECT e.emp_name, e.salary
FROM employees e
WHERE e.salary > (
	SELECT MAX(e2.salary)
    FROM employees e2
    WHERE e2.dept_id <> e.dept_id
);

-- 18. Find managers whose team’s total salary is the highest among all managers.

SELECT *
FROM (
    SELECT 
        e.emp_name AS employee,
        e.salary,
        m.emp_name AS manager,
        DENSE_RANK() OVER (PARTITION BY m.emp_id ORDER BY e.salary DESC) AS rnk
    FROM employees e
    JOIN employees m
        ON e.manager_id = m.emp_id
) ranked
WHERE rnk = 1;

-- 19. Find employees whose salary is above their department’s average but below their manager’s salary.


SELECT average.emp_name,
       average.salary,
       average.avg_dept_sal,
       m.emp_name AS manager,
       m.salary AS manager_salary
FROM (
    SELECT emp_name,
           salary,
           dept_id,
           manager_id,
           AVG(salary) OVER(PARTITION BY dept_id) AS avg_dept_sal
    FROM employees
) average
JOIN employees m
  ON average.manager_id = m.emp_id
WHERE average.salary > average.avg_dept_sal
  AND average.salary < m.salary;




-- 20. List employees who do not have any coworkers in their department.

SELECT e.emp_name
FROM employees e
WHERE NOT EXISTS(
	SELECT 1
    FROM employees e2
    WHERE e2.dept_id = e.dept_id
    AND e2.emp_id <> e.emp_id
);


-- 21. Find departments where all employees earn above 60,000.

SELECT d.dept_name
FROM departments d
WHERE d.dept_id IN(
	SELECT e.dept_id
    FROM employees e
    GROUP BY e.dept_id
    HAVING MIN(e.salary) > 60000
);

-- 22. Find employees whose salary is between the lowest and second-lowest salaries in their department.


-- 23. List employees whose hire date is earlier than all employees in a specific department, e.g., HR.

SELECT e.emp_name, e.hire_date
FROM employees e
WHERE e.hire_date < (
	SELECT MIN(e2.hire_date)
    FROM employees e2
    JOIN departments d
		ON e2.dept_id = d.dept_id
	WHERE d.dept_name = 'HR'
);