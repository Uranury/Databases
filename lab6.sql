-- 1 --
CREATE DATABASE LAB6;

-- 2 --
CREATE TABLE locations (
    location_id SERIAL PRIMARY KEY,
    street_address VARCHAR(25),
    postal_code VARCHAR(12),
    city VARCHAR(30),
    state_province VARCHAR(12)
);

CREATE TABLE departments (
    department_id SERIAL PRIMARY KEY,
    department_name VARCHAR(50) UNIQUE,
    budget INTEGER,
    location_id INTEGER REFERENCES locations
);

CREATE TABLE employees(
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(50),
    phone_number VARCHAR(20),
    salary INTEGER,
    department_id INTEGER REFERENCES departments
);

INSERT INTO locations (street_address, postal_code, city, state_province) VALUES
('123 Main St', '12345', 'New York', 'NY'),
('456 Elm St', '67890', 'Los Angeles', 'CA'),
('789 Maple Ave', '10112', 'Chicago', 'IL');

INSERT INTO departments (department_name, budget, location_id) VALUES
('HR', 50000, 1),
('Engineering', 200000, 2),
('Marketing', 150000, 3);

INSERT INTO employees (first_name, last_name, email, phone_number, salary, department_id) VALUES
('John', 'Doe', 'johndoe@example.com', '555-1234', 60000, 1),
('Jane', 'Smith', 'janesmith@example.com', '555-5678', 90000, 2),
('Alice', 'Johnson', 'alicej@example.com', '555-8765', 85000, 2),
('Bob', 'Williams', 'bobw@example.com', '555-4321', 75000, 3);

INSERT INTO departments (department_id, department_name, budget, location_id) VALUES
(80, 'Research', 120000, 1),
(40, 'Sales', 90000, 2);

INSERT INTO employees (first_name, last_name, email, phone_number, salary, department_id) VALUES
('Michael', 'Brown', 'michaelb@example.com', '555-3344', 70000, 80),
('Sarah', 'Green', 'sarahg@example.com', '555-5566', 65000, 80),
('James', 'White', 'jamesw@example.com', '555-7788', 72000, 40),
('Laura', 'Black', 'laurab@example.com', '555-9900', 68000, 40);

INSERT INTO employees (first_name, last_name, email, phone_number, salary, department_id) VALUES
('John', 'Doe', 'john.doe@example.com', '555-1234', 50000, NULL),
('Jane', 'Smith', 'jane.smith@example.com', '555-5678', 55000, NULL);

INSERT INTO locations (location_id, street_address, postal_code, city, state_province) VALUES
(4, '789 Innovation Rd', '67890', 'DevCity', 'DC');

-- Insert a department with no employees
INSERT INTO departments (department_name, budget, location_id) VALUES
('Legal', 50000, 3),
('Research and Development', 75000, 4);

-- 3 --
SELECT employees.first_name, employees.last_name, employees.department_id, d.department_name
FROM employees
JOIN departments d on employees.department_id = d.department_id;

-- 4 --
SELECT employees.first_name, employees.last_name, employees.department_id, departments.department_name
FROM employees
JOIN departments ON employees.department_id = departments.department_id
WHERE employees.department_id IN (80, 40);

-- 5 --
SELECT employees.first_name, employees.last_name, d.department_name, l.city, l.state_province
FROM employees
JOIN departments d on d.department_id = employees.department_id
JOIN locations l on l.location_id = d.location_id;

-- 6 --
SELECT departments.department_name, e.first_name, e.last_name
FROM departments
LEFT JOIN employees e on departments.department_id = e.department_id;

-- 7 --
SELECT employees.first_name, employees.last_name, employees.department_id, d.department_name
FROM employees
LEFT JOIN departments d on employees.department_id = d.department_id;