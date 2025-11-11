-- Part 5 – Advanced SQL Queries
-- Focus: Subqueries, aggregation, and window functions

-- Q1: Employees earning more than the company average salary
SELECT emp_name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

-- Q2: Employees in the same department as Alice
SELECT emp_name, dept_id
FROM employees
WHERE dept_id IN (
    SELECT dept_id
    FROM employees
    WHERE emp_name = 'Alice'
) AND emp_name <> 'Alice';

-- Q3: Departments with at least one employee
SELECT d.dept_name
FROM departments d
WHERE EXISTS (
    SELECT 1
    FROM employees e
    WHERE e.dept_id = d.dept_id
    GROUP BY e.dept_id
    HAVING COUNT(*) >= 1
);

-- Q4: Employees without a manager
SELECT emp_name, manager_id
FROM employees
WHERE manager_id IS NULL;

-- Q5: Employees earning above their department’s average
SELECT *
FROM (
    SELECT emp_name, salary, dept_id,
           AVG(salary) OVER(PARTITION BY dept_id) AS avg_dept_sal
    FROM employees
) t
WHERE salary > avg_dept_sal;

-- Q6: Employees hired before the earliest hire date in HR
SELECT e.emp_name, e.hire_date, d.dept_name
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
WHERE e.hire_date < (
    SELECT MIN(e2.hire_date)
    FROM employees e2
    JOIN departments d2 ON e2.dept_id = d2.dept_id
    WHERE d2.dept_name = 'HR'
);

-- Q7: Employees sharing a salary with someone in another department
SELECT e.emp_name, e.salary
FROM employees e
JOIN employees e2 ON e.salary = e2.salary
WHERE e.dept_id <> e2.dept_id;

-- Q8: Departments where no employee earns below 50,000
SELECT d.dept_name
FROM departments d
JOIN employees e ON d.dept_id = e.dept_id
GROUP BY d.dept_id, d.dept_name
HAVING MIN(e.salary) >= 50000;

-- Q9: Employees earning more than their manager
SELECT e.emp_name AS employee, e.salary
FROM employees e
JOIN employees m ON e.manager_id = m.emp_id
WHERE e.salary > m.salary;

-- Q10: Employees with at least one direct report
SELECT m.emp_name AS manager
FROM employees m
WHERE EXISTS (
    SELECT 1
    FROM employees e
    WHERE e.manager_id = m.emp_id
);

-- Q11: Employees without any subordinates
SELECT e.emp_name AS employee
FROM employees e
WHERE NOT EXISTS (
    SELECT 1
    FROM employees sub
    WHERE sub.manager_id = e.emp_id
);

-- Q12: Managers whose team salary exceeds 100,000
SELECT m.emp_name AS manager
FROM employees m
JOIN employees e ON m.emp_id = e.manager_id
GROUP BY m.emp_id, m.emp_name
HAVING SUM(e.salary) > 100000;

-- Q13: Departments with no employees assigned
SELECT d.dept_name
FROM departments d
WHERE NOT EXISTS (
    SELECT 1
    FROM employees e
    WHERE e.dept_id = d.dept_id
    GROUP BY e.dept_id
    HAVING COUNT(*) >= 1
);

-- Q14: Employees hired after their manager
SELECT e.emp_name AS employee, e.hire_date, m.emp_name AS manager, m.hire_date
FROM employees e
JOIN employees m ON e.manager_id = m.emp_id
WHERE e.hire_date > m.hire_date;

-- Q15: Employees earning more than all Finance employees
SELECT e.emp_name, e.salary
FROM employees e
WHERE e.salary > (
    SELECT MAX(e2.salary)
    FROM employees e2
    JOIN departments d ON e2.dept_id = d.dept_id
    WHERE d.dept_name = 'Finance'
);

-- Q16: Second highest salary in the company
SELECT *
FROM (
    SELECT emp_name, salary,
           DENSE_RANK() OVER(ORDER BY salary DESC) AS rnk
    FROM employees
) t
WHERE rnk = 2;

-- Q17: Second highest salary per department
SELECT *
FROM (
    SELECT emp_name, salary, dept_id,
           DENSE_RANK() OVER(PARTITION BY dept_id ORDER BY salary DESC) AS rnk
    FROM employees
) t
WHERE rnk = 2;

-- Q18: Employees above department average but below their manager
SELECT emp_name, salary, dept_id, avg_dept_sal
FROM (
    SELECT e.emp_name, e.salary, e.dept_id, e.manager_id,
           AVG(e.salary) OVER(PARTITION BY e.dept_id) AS avg_dept_sal
    FROM employees e
) dept_avg
JOIN employees m ON dept_avg.manager_id = m.emp_id
WHERE dept_avg.salary > dept_avg.avg_dept_sal
  AND dept_avg.salary < m.salary;

-- Q19: Managers whose team’s average salary exceeds company average
SELECT m.emp_name
FROM employees m
JOIN employees e ON m.emp_id = e.manager_id
GROUP BY m.emp_id, m.emp_name
HAVING AVG(e.salary) > (SELECT AVG(salary) FROM employees);

-- Q20: Employees with no coworkers in their department
SELECT e.emp_name, e.dept_id
FROM employees e
WHERE NOT EXISTS (
    SELECT 1
    FROM employees e2
    WHERE e2.dept_id = e.dept_id
    AND e.emp_id <> e2.emp_id
);