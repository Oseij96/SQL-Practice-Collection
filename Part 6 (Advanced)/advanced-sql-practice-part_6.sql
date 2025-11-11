-- Part 6 – Advanced SQL Queries
-- Focus: Subqueries, aggregation, window functions, and conditional filtering

-- Q1: Employees earning below the company average salary
SELECT emp_name, salary
FROM employees
WHERE salary < (SELECT AVG(salary) FROM employees);

-- Q2: Employees in the same department as Bob
SELECT e.emp_name, e.dept_id
FROM employees e
WHERE e.dept_id IN (
    SELECT e2.dept_id
    FROM employees e2
    WHERE e2.emp_name = 'Bob'
) AND e.emp_name <> 'Bob';

-- Q3: Departments with more than 5 employees
SELECT d.dept_name
FROM departments d
WHERE EXISTS (
    SELECT 1
    FROM employees e
    GROUP BY e.dept_id
    HAVING COUNT(*) > 5
);

-- Q4: Employees who have a manager
SELECT e.emp_name AS employee
FROM employees e
WHERE e.manager_id IS NOT NULL;

-- Q5: Employees earning the maximum salary in their department
SELECT *
FROM (
    SELECT emp_name, salary, dept_id,
           DENSE_RANK() OVER(PARTITION BY dept_id ORDER BY salary DESC) AS rnk
    FROM employees
) t
WHERE rnk = 1;

-- Q6: Employees hired after the latest hire date in Finance
SELECT e.emp_name, e.hire_date
FROM employees e
WHERE e.hire_date > (
    SELECT MAX(e2.hire_date)
    FROM employees e2
    JOIN departments d ON e2.dept_id = d.dept_id
    WHERE d.dept_name = 'Finance'
);

-- Q7: Employees with salary matching someone in Sales but not in Sales
SELECT e.emp_name, e.salary, d.dept_name
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
WHERE e.salary IN (
    SELECT e2.salary
    FROM employees e2
    JOIN departments d2 ON e2.dept_id = d2.dept_id
    WHERE d2.dept_name = 'Sales'
)
AND d.dept_name <> 'Sales';

-- Q8: Departments where every employee earns at least 60,000
SELECT d.dept_name
FROM departments d
WHERE d.dept_id IN (
    SELECT e.dept_id
    FROM employees e
    GROUP BY e.dept_id
    HAVING MIN(e.salary) >= 60000
);

-- Q9: Employees earning less than their manager
SELECT e.emp_name, e.salary
FROM employees e
JOIN employees m ON e.manager_id = m.emp_id
WHERE e.salary < m.salary;

-- Q10: Managers with subordinates in different departments
SELECT DISTINCT m.emp_name AS manager, m.dept_id
FROM employees m
WHERE EXISTS (
    SELECT 1
    FROM employees e
    WHERE e.manager_id = m.emp_id
    AND e.dept_id <> m.dept_id
);

-- Q11: Employees who don’t manage anyone
SELECT e.emp_name AS employee
FROM employees e
WHERE NOT EXISTS (
    SELECT 1
    FROM employees sub
    WHERE sub.manager_id = e.emp_id
);

-- Q12: Managers whose team’s minimum salary > 55,000
SELECT m.emp_name
FROM employees m
JOIN employees e ON m.emp_id = e.manager_id
GROUP BY m.emp_id, m.emp_name
HAVING MIN(e.salary) > 55000;

-- Q13: Departments with no employees earning over 100,000
SELECT d.dept_name
FROM departments d
WHERE NOT EXISTS (
    SELECT 1
    FROM employees e
    WHERE e.dept_id = d.dept_id
    AND e.salary > 100000
);

-- Q14: Employees hired before their manager
SELECT e.emp_name AS employee, e.hire_date, m.emp_name AS manager, m.hire_date
FROM employees e
JOIN employees m ON e.manager_id = m.emp_id
WHERE e.hire_date < m.hire_date;

-- Q15: Employees earning more than all HR employees
SELECT e.emp_name
FROM employees e
WHERE e.salary > (
    SELECT MAX(e2.salary)
    FROM employees e2
    JOIN departments d ON e2.dept_id = d.dept_id
    WHERE d.dept_name = 'HR'
);

-- Q16: Third highest salary in the company
SELECT *
FROM (
    SELECT emp_name, salary,
           DENSE_RANK() OVER(ORDER BY salary DESC) AS rnk
    FROM employees
) t
WHERE rnk = 3;

-- Q17: Top 2 salaries per department
SELECT *
FROM (
    SELECT emp_name, salary, dept_id,
           DENSE_RANK() OVER(PARTITION BY dept_id ORDER BY salary DESC) AS rnk
    FROM employees
) t
WHERE rnk = 1 OR rnk = 2;

-- Q18: Employees above department average but below company max
SELECT emp_name
FROM (
    SELECT emp_name, salary, AVG(salary) OVER(PARTITION BY dept_id) AS avg_dept_sal
    FROM employees
) t
WHERE salary > avg_dept_sal
AND salary < (SELECT MAX(salary) FROM employees);

-- Q19: Managers whose team salary < company average
SELECT m.emp_name
FROM employees m
JOIN employees e ON m.emp_id = e.manager_id
GROUP BY m.emp_id, m.emp_name
HAVING SUM(e.salary) < (SELECT AVG(salary) FROM employees);

-- Q20: Employees who are the only person in their department and have no manager
SELECT e.emp_name
FROM employees e
WHERE e.manager_id IS NULL
AND NOT EXISTS (
    SELECT 1
    FROM employees e2
    WHERE e2.dept_id = e.dept_id
    AND e2.emp_id <> e.emp_id
);
