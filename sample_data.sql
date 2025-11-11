-- ================================================
-- 🧪 Sample Data for Advanced SQL Practice
-- Author: Joel Osei
-- Description: Provides sample rows for employees and departments
-- ================================================

-- Insert departments
INSERT INTO departments (dept_id, dept_name) VALUES
(1, 'Engineering'),
(2, 'Marketing'),
(3, 'Sales'),
(4, 'HR');

-- Insert employees
INSERT INTO employees (emp_id, emp_name, salary, hire_date, manager_id, dept_id) VALUES
(1, 'Alice Johnson', 120000.00, '2015-03-15', NULL, 1),   -- Top manager, Engineering
(2, 'Bob Smith', 90000.00, '2016-07-10', 1, 1),
(3, 'Carol Lee', 95000.00, '2017-01-20', 1, 1),
(4, 'David Kim', 80000.00, '2018-05-05', 2, 1),
(5, 'Eva Chen', 85000.00, '2019-02-12', 2, 1),
(6, 'Frank Moore', 70000.00, '2015-06-18', NULL, 2),      -- Top manager, Marketing
(7, 'Grace Liu', 65000.00, '2016-08-22', 6, 2),
(8, 'Hannah Patel', 60000.00, '2017-09-30', 6, 2),
(9, 'Ian Thompson', 75000.00, '2018-03-15', NULL, 3),     -- Top manager, Sales
(10, 'Jackie Wu', 72000.00, '2019-10-01', 9, 3),
(11, 'Karen Adams', 68000.00, '2020-01-10', 9, 3),
(12, 'Liam Brown', 50000.00, '2021-04-12', NULL, 4),      -- Top manager, HR
(13, 'Mia Green', 48000.00, '2022-06-05', 12, 4),
(14, 'Noah White', 46000.00, '2023-07-20', 12, 4);
