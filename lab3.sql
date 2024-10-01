-- 1 --
CREATE DATABASE lab3;

-- 2 --
CREATE TABLE departments (
  code INTEGER PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  budget DECIMAL NOT NULL
);

CREATE TABLE employees (
  ssn INTEGER PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  lastname VARCHAR(255) NOT NULL,
  department INTEGER NOT NULL,
  city VARCHAR(255),
  FOREIGN KEY (department) REFERENCES departments(code)
);

CREATE TABLE customers (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  lastname VARCHAR(255) NOT NULL,
  city VARCHAR(255)
);

INSERT INTO departments(code, name, budget) VALUES
(14, 'IT', 65000),
(37, 'Accounting', 15000),
(59, 'Human Resources', 240000),
(77, 'Research', 55000),
(45, 'Management', 155000),
(11, 'Sales', 85000);

INSERT INTO employees(ssn, name, lastname, department, city) VALUES
(123234877, 'Michael', 'Rogers', 14, 'Almaty'),
(152934485, 'Anand', 'Manikutty', 14, 'Shymkent'),
(222364883, 'Carol', 'Smith', 37, 'Astana'),
(326587417, 'Joe', 'Stevens', 37, 'Almaty'),
(332154719, 'Mary-Anne', 'Foster', 14, 'Astana'),
(332569843, 'George', 'ODonnell', 77, 'Astana'),
(546523478, 'John', 'Doe', 59, 'Shymkent'),
(631231482, 'David', 'Smith', 77, 'Almaty'),
(654873219, 'Zacary', 'Efron', 59, 'Almaty'),
(745685214, 'Eric', 'Goldsmith', 59, 'Atyrau'),
(845657245, 'Elizabeth', 'Doe', 14, 'Almaty'),
(845657246, 'Kumar', 'Swamy', 14, 'Almaty');

INSERT INTO customers(name, lastname, city) VALUES
('John', 'Wills', 'Almaty'),
('Garry', 'Foster', 'London'),
('Amanda', 'Hills', 'Almaty'),
('George', 'Doe', 'Tokyo'),
('David', 'Little', 'Almaty'),
('Shawn', 'Efron', 'Astana'),
('Eric', 'Gomez', 'Shymkent'),
('Elizabeth', 'Tailor', 'Almaty'),
('Julia', 'Adams', 'Astana');

-- 3 --
SELECT lastname FROM employees;

-- 4 --
SELECT DISTINCT lastname FROM employees;

-- 5 --
SELECT * FROM employees WHERE lastname = 'Smith';

-- 6 --
SELECT * FROM employees WHERE lastname IN ('Smith', 'Doe');

-- 7 --
SELECT * FROM employees WHERE department = 14;

-- 8 --
SELECT * FROM employees WHERE department IN (37, 77);

-- 9 --
SELECT SUM(budget) FROM departments;

-- 10 --
SELECT department, COUNT(*) AS employee_count FROM employees GROUP BY department;

-- 11 --
SELECT department FROM employees GROUP BY department HAVING COUNT(*) > 2;

-- 12 --
SELECT name FROM departments ORDER BY budget DESC LIMIT 1 OFFSET 1;

-- 13 --
SELECT e.name, e.lastname FROM employees e
JOIN departments d ON e.department = d.code
WHERE d.budget = (SELECT MIN(budget) FROM departments);

-- 14 --
SELECT name FROM employees WHERE city = 'Almaty'
UNION
SELECT name FROM customers WHERE city = 'Almaty';

-- 15 --
SELECT * FROM departments WHERE budget > 60000 ORDER BY budget ASC, code DESC;

-- 16 --
UPDATE departments SET budget = budget * 0.9 WHERE budget = (SELECT MIN(budget) FROM departments);

-- 17 --
UPDATE employees SET department = (SELECT code FROM departments WHERE name = 'IT')
WHERE department = (SELECT code FROM departments WHERE name = 'Research');

-- 18 --
DELETE FROM employees WHERE department = (SELECT code FROM departments WHERE name = 'IT');

-- 19 --
DELETE FROM employees;