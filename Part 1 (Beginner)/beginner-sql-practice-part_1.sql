-- 1. Find employees who earn more than 50,000.

SELECT emp_name, salary
FROM employees
WHERE salary > 50000;


-- 2. Show employees whose manager is not assigned (manager_id IS NULL).

SELECT emp_name, manager_id
FROM employees
WHERE manager_id IS NULL;


-- 3. Find employees who earn more than their manager.

SELECT e.emp_name
FROM employees e
WHERE e.salary >
	(SELECT m.salary FROM employees m WHERE m.emp_id = e.manager_id);
    
    
-- OR    
    
SELECT e.emp_name
FROM employees e
JOIN employees m
ON e.manager_id = m.emp_id
WHERE e.salary > m.salary;    
    
    
-- 4. List employees who were hired before their manager.

SELECT e.emp_name, e.hire_date
FROM employees e
WHERE e.hire_date <
	(SELECT m.hire_date FROM employees m WHERE m.emp_id = e.manager_id);
    
    
-- OR    
    
SELECT e.emp_name, e.hire_date
FROM employees e
JOIN employees m
ON e.manager_id = m.emp_id
WHERE e.hire_date < m.hire_date;
    

-- 5. Show departments that have at least one employee.

SELECT DISTINCT dept_id
FROM employees;


-- OR 

SELECT d.dept_id, d.dept_name
FROM departments d
WHERE EXISTS (
    SELECT 1 
    FROM employees e 
    WHERE e.dept_id = d.dept_id
);


-- 6. Find employees who share the same manager.

SELECT e.emp_name
FROM employees e
WHERE e.manager_id IN
	(SELECT d.manager_id FROM employees d GROUP BY d.manager_id HAVING COUNT(*) > 1);
    


-- 7. Show managers who have at least 2 direct reports.

SELECT m.emp_name AS manager, COUNT(e.emp_id) AS direct_reports
FROM employees m
JOIN employees e
ON m.emp_id = e.manager_id
GROUP BY m.emp_id, m.emp_name
HAVING COUNT(e.emp_id) >= 2;


-- 8. Find employees who earn more than the average salary of their department.

SELECT e.emp_name, e.salary
FROM employees e
WHERE e.salary > 
	(SELECT AVG(salary) FROM employees d WHERE e.dept_id = d.dept_id);
    
    
-- 9. List employees who share the same salary as someone in another department.

SELECT e1.emp_name, e1.salary
FROM employees e1
WHERE EXISTS(
	SELECT 1 
	FROM employees e2
    WHERE e1.salary = e2.salary
    AND e1.dept_id <> e2.dept_id
    );
    
    
    
-- 10. Find employees who are the highest-paid in their department.

SELECT e.emp_name, e.salary
FROM employees e
WHERE salary =
	(SELECT MAX(salary) FROM employees d WHERE e.dept_id = d.dept_id);
    
    
-- 11. Show departments that have no employees.

SELECT dept_id, dept_name
FROM departments d
WHERE d.dept NOT IN
	(SELECT e.emp_name FROM employees e WHERE e.dept_id IS NULL);
    
    
-- 12. Find employees whose hire date is earlier than all employees in HR.

SELECT e.emp_name, e.hire_date
FROM employees e
WHERE e.hire_date < ALL
	(SELECT hr.hire_date
	FROM employees hr
    JOIN departments d
    ON hr.dept_id = d.dept_id
    WHERE d.dept_name = 'HR'
    );
    
    
-- 13. Find the second highest salary in the company.

SELECT MAX(salary) AS second_highest
FROM employees
WHERE salary < 
		(SELECT MAX(salary) FROM employees);
        
        
-- 14. Find the second highest salary per department.

SELECT * FROM(
	SELECT
		emp_name,
		salary,
		ROW_NUMBER() OVER(PARTITION BY dept_id ORDER BY salary DESC) rn
	FROM
		employees) ranked
WHERE rn = 2;


-- 15. Find employees who earn more than every employee in another department.

SELECT e.emp_name, e.salary, e.dept_id
FROM employees e
JOIN (
	SELECT dept_id, MAX(salary) AS max
    FROM employees
    GROUP BY dept_id
) d
ON e.salary > d.max
AND e.dept_id <> d.dept_id;


-- 16. Find employees whose salary is above their department’s average but still below their manager’s salary.

SELECT e.emp_name
FROM employees e
WHERE e.salary > 
	(SELECT AVG(salary) FROM employees d WHERE e.dept_id = d.dept_id)
AND 
	e.salary < 
		(SELECT salary FROM employees m WHERE e.manager_id = m.emp_id);


-- 17. List employees who do not have any coworkers in their department.

SELECT e.emp_name
FROM employees e
WHERE e.dept_id IN (
    SELECT d.dept_id
    FROM employees d
    GROUP BY d.dept_id
    HAVING COUNT(*) = 1
);

-- 18. Find departments where all employees earn more than the company average salary.

SELECT d.dept_name
FROM departments d
JOIN employees e
ON d.dept_id = e.dept_id
GROUP BY d.dept_id, d.dept_name
HAVING MIN(e.salary) > (SELECT AVG(salary) FROM employees);