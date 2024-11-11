-- 1 --
CREATE INDEX idx_countries_name ON countries (name);

-- 2 --
CREATE INDEX idx_employees_name_surname ON employees (name, surname);

-- 3 --
CREATE UNIQUE INDEX idx_employees_salary_range ON employees (salary);

-- 4 --
CREATE INDEX idx_employees_name_substr ON employees ((substring(name from 1 for 4)));

-- 5 --
CREATE INDEX idx_employees_departments_budget_salary ON employees (department_id);
CREATE INDEX idx_departments_budget ON departments (budget);
