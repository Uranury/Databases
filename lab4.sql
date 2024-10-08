-- 1 --
CREATE DATABASE lab4;

-- 2 --
CREATE TABLE warehouses (
    code_integer SERIAL PRIMARY KEY,
    location VARCHAR(255),
    capacity INTEGER
);

CREATE TABLE boxes (
    code_character VARCHAR(4) PRIMARY KEY,
    contents VARCHAR(255),
    value_real INTEGER,
    warehouse_integer INTEGER,
    FOREIGN KEY (warehouse_integer) REFERENCES warehouses(code_integer)
);

-- 3 --
INSERT INTO warehouses
VALUES
    (default, 'Chicago', 3),
    (default, 'Chicago', 4),
    (default, 'New York', 7),
    (default, 'Los Angeles', 2),
    (default, 'San Francisco', 8);

INSERT INTO boxes
VALUES
    ('OMN7', 'Rocks', 180, 3),
    ('4H8P', 'Rocks', 250, 1),
    ('4RT3', 'Scissors', 190, 4),
    ('7G3H', 'Rocks', 200, 1),
    ('8JN6', 'Papers', 75, 1),
    ('8Y6U', 'Papers', 50, 3),
    ('9J6F', 'Papers', 175, 2),
    ('LLO8', 'Rocks', 140, 4),
    ('POH6', 'Scissors', 125, 1),
    ('P2T6', 'Scissors', 150, 2),
    ('TU55', 'Papers', 90, 5);

-- 4 --
SELECT * FROM warehouses;

-- 5 --
SELECT * FROM boxes
WHERE value_real > 150;

-- 6 --
SELECT DISTINCT ON (contents) *
FROM boxes;

-- 7 --
SELECT warehouse_integer, COUNT(*) AS box_count
FROM boxes
GROUP BY warehouse_integer;

-- 8 --
SELECT warehouse_integer, COUNT(*) AS box_count
FROM boxes
GROUP BY warehouse_integer
HAVING COUNT(*) > 2;

-- 9 --
INSERT INTO warehouses
VALUES (default, 'New York', 3);

-- 10 --
INSERT INTO boxes
VALUES ('H5RT', 'Papers', 200, 2);

-- 11 --
UPDATE boxes
SET value_real = value_real * 0.85
WHERE code_character = (
    SELECT code_character
    FROM boxes
    ORDER BY value_real DESC
    OFFSET 2 LIMIT 1
);

-- 12 --
DELETE FROM boxes
WHERE value_real < 150;

-- 13 --
DELETE FROM boxes
USING warehouses
WHERE boxes.warehouse_integer = warehouses.code_integer
AND warehouses.location = 'New York'
RETURNING *;



