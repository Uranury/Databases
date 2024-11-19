-- 1 --
CREATE DATABASE LAB8;

-- 2 --
CREATE TABLE salesman (
    salesman_id integer primary key,
    name VARCHAR(20),
    city VARCHAR(20),
    commission float
);

CREATE TABLE customers (
    customer_id integer primary key,
    cust_name VARCHAR(20),
    city VARCHAR(20),
    grade integer,
    salesman_id integer,
    foreign key (salesman_id) references salesman(salesman_id)
);

CREATE TABLE orders (
    ord_no integer primary key,
    purch_amt numeric,
    ord_date date,
    customer_id integer,
    salesman_id integer,
    foreign key (customer_id) references customers(customer_id),
    foreign key (salesman_id) references salesman(salesman_id)
);


INSERT INTO salesman (salesman_id, name, city, commission) VALUES
(5001, 'James Hoog', 'New York', 0.15),
(5002, 'Nail Knite', 'Paris', 0.13),
(5005, 'Pit Alex', 'London', 0.11),
(5006, 'Mc Lyon', 'Paris', 0.14),
(5003, 'Lauson Hen', null, 0.12),
(5007, 'Paul Adam', 'Rome', 0.13);

INSERT INTO customers (customer_id, cust_name, city, grade, salesman_id) VALUES
(3002, 'Nick Rimando', 'New York', 100, 5001),
(3005, 'Graham Zusi', 'California', 200, 5002),
(3001, 'Brad Guzan', 'London', null, 5005),
(3004, 'Fabian Johns', 'Paris', 300, 5006),
(3007, 'Brad Davis', 'New York', 200, 5001),
(3009, 'Geoff Camero', 'Berlin', 100, 5003),
(3008, 'Julian Green', 'London', 300, 5002);

INSERT INTO orders (ord_no, purch_amt, ord_date, customer_id, salesman_id) VALUES
(70001, 150.5, '2012-10-05', 3005, 5002),
(70009, 270.65, '2012-09-10', 3001, 5005),
(70002, 65.26, '2012-10-05', 3002, 5001),
(70004, 110.5, '2012-08-17', 3009, 5003),
(70007, 948.5, '2012-09-10', 3005, 5002),
(70005, 2400.6, '2012-07-27', 3007, 5001),
(70008, 5760, '2012-09-10', 3002, 5001);

-- 3 --
CREATE ROLE junior_dev login;

-- 4 --
CREATE VIEW new_york_salesman AS
    SELECT * FROM salesman
WHERE city LIKE 'New York';

-- 5 --
CREATE VIEW order_details AS
SELECT
    o.ord_no AS order_number,
    o.purch_amt AS purchase_amount,
    o.ord_date AS order_date,
    c.cust_name AS customer_name,
    s.name AS salesman_name
FROM
    orders o
LEFT JOIN
    customers c ON o.customer_id = c.customer_id
LEFT JOIN
    salesman s on o.salesman_id = s.salesman_id;

GRANT ALL PRIVILEGES ON DATABASE LAB8 TO junior_dev;

-- 6 --
CREATE VIEW top_grade_customers AS
SELECT * FROM customers
WHERE grade = (SELECT MAX(grade) FROM customers);

GRANT SELECT ON ALL TABLES IN SCHEMA public TO junior_dev;

-- 7 --
CREATE VIEW number_of_salesman AS
SELECT city, COUNT(*) AS salesman_count
FROM salesman
GROUP BY city;

-- 8 --
CREATE VIEW more_than_one_customer AS
SELECT s.name AS salesman_name, COUNT(c.customer_id) AS customer_count
FROM salesman s
LEFT JOIN customers c on s.salesman_id = c.salesman_id
GROUP BY s.name
HAVING COUNT(c.customer_id) > 1;

-- 9 --
CREATE ROLE intern;
GRANT junior_dev TO intern;

/*
 -- Revoke specific privileges on a table
REVOKE SELECT, INSERT, UPDATE ON employees FROM intern;

-- Revoke all privileges on all tables in the public schema
REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA public FROM intern;

-- Revoke privileges on the public schema
REVOKE USAGE, CREATE ON SCHEMA public FROM intern;

-- Revoke connect privilege on the database
REVOKE CONNECT ON DATABASE your_database FROM intern;

-- Revoke inheritance from junior_dev
REVOKE junior_dev FROM intern;

-- Revoke all privileges on the database (optional if you want to remove all database-level access)
REVOKE ALL PRIVILEGES ON DATABASE your_database FROM intern;
 */