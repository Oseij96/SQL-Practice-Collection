-- ================================================
-- 🏗️  Database Setup Script
-- Author: Joel Osei
-- Description: Creates the tables used in the
-- Advanced SQL Practice Collection
-- ================================================

CREATE TABLE departments (
  dept_id INT PRIMARY KEY,
  dept_name VARCHAR(50)
);

CREATE TABLE employees (
  emp_id INT PRIMARY KEY,
  emp_name VARCHAR(50),
  role VARCHAR(50),
  salary DECIMAL(10,2),
  manager_id INT,
  dept_id INT,
  hire_date DATE,
  FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);