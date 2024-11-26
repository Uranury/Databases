-- Laboratory Work #9

-- 1 --
CREATE OR REPLACE FUNCTION increase_value(input_value INTEGER)
RETURNS INTEGER AS $$
BEGIN
    RETURN input_value + 10;
END;
$$ LANGUAGE plpgsql;

-- 2 --
CREATE OR REPLACE FUNCTION compare_numbers(num1 INTEGER, num2 INTEGER)
RETURNS TEXT AS $$
DECLARE
    result TEXT;
BEGIN
    IF num1 > num2 THEN
        result := 'Greater';
    ELSIF num1 = num2 THEN
        result := 'Equal';
    ELSE
        result := 'Lesser';
    END IF;
    RETURN result;
END;
$$ LANGUAGE plpgsql;

-- 3 --
CREATE OR REPLACE FUNCTION number_series(n INTEGER)
RETURNS TABLE(num INTEGER) AS $$
BEGIN
    FOR num IN 1..n LOOP
        RETURN NEXT num;
    END LOOP;
END;
$$ LANGUAGE plpgsql;

-- 4 --
CREATE OR REPLACE FUNCTION find_employee(emp_name VARCHAR)
RETURNS TABLE(employee_id INTEGER, first_name VARCHAR, last_name VARCHAR, email VARCHAR, salary INTEGER) AS $$
BEGIN
    RETURN QUERY
    SELECT employee_id, first_name, last_name, email, salary
    FROM employees
    WHERE first_name ILIKE emp_name OR last_name ILIKE emp_name;
END;
$$ LANGUAGE plpgsql;

-- 5 --
CREATE OR REPLACE FUNCTION list_products(category_name VARCHAR)
RETURNS TABLE(product_id INTEGER, product_name VARCHAR, price NUMERIC, category VARCHAR) AS $$
BEGIN
    RETURN QUERY
    SELECT product_id, product_name, price, category
    FROM products
    WHERE category = category_name;
END;
$$ LANGUAGE plpgsql;

-- 6 --
CREATE OR REPLACE FUNCTION calculate_bonus(employee_id INTEGER)
RETURNS NUMERIC AS $$
DECLARE
    bonus NUMERIC;
BEGIN
    SELECT salary * 0.1 INTO bonus
    FROM employees
    WHERE employee_id = employee_id;
    RETURN bonus;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_salary(employee_id INTEGER)
RETURNS VOID AS $$
DECLARE
    bonus NUMERIC;
BEGIN
    bonus := calculate_bonus(employee_id);
    UPDATE employees
    SET salary = salary + bonus
    WHERE employee_id = employee_id;
END;
$$ LANGUAGE plpgsql;

-- 7 --
CREATE OR REPLACE FUNCTION complex_calculation(input_num INTEGER, input_text VARCHAR)
RETURNS TEXT AS $$
DECLARE
    num_result INTEGER;
    text_result TEXT;
BEGIN
    <<NumericBlock>>
    BEGIN
        num_result := input_num * input_num; -- Square of the number
    END;

    <<StringBlock>>
    BEGIN
        text_result := CONCAT('Processed-', input_text);
    END;

    -- Combine Results
    RETURN CONCAT('Numeric Result: ', num_result, ', Text Result: ', text_result);
END;
$$ LANGUAGE plpgsql;
