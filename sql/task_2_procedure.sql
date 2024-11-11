CREATE OR REPLACE PROCEDURE add_job_hist(
    p_employee_id INTEGER,
    p_new_job_id VARCHAR(10)
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_hire_date DATE;
    v_department_id INTEGER;
    v_min_salary INTEGER;
BEGIN
SELECT hire_date, department_id INTO v_hire_date, v_department_id
FROM employees
WHERE employee_id = p_employee_id;

IF NOT FOUND THEN
    RAISE EXCEPTION 'Employee с таким ID не существует.';
END IF;

SELECT min_salary INTO v_min_salary
FROM jobs
WHERE job_id = p_new_job_id;

IF NOT FOUND THEN
    RAISE EXCEPTION 'Job с таким ID не существует.';
END IF;

INSERT INTO job_history (
    employee_id,
    start_date,
    end_date,
    job_id,
    department_id
)
VALUES (
    p_employee_id,
    v_hire_date,
    CURRENT_DATE,
    p_new_job_id,
    v_department_id
);

UPDATE employees
SET
    hire_date = CURRENT_DATE,
    job_id = p_new_job_id,
    salary = v_min_salary + 500
WHERE employee_id = p_employee_id;
EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Возникла ошибка: %', SQLERRM;
END;
$$;