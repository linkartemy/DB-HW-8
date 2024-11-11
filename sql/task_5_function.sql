CREATE
OR REPLACE FUNCTION get_job_count (p_employee_id INTEGER) RETURNS INTEGER LANGUAGE plpgsql AS $$
DECLARE
    v_job_count INTEGER;
BEGIN
    IF NOT EXISTS (SELECT 1 FROM employees WHERE employee_id = p_employee_id) THEN
        RAISE EXCEPTION 'Employee с ID % не существует.', p_employee_id;
    END IF;

    SELECT COUNT(*) INTO v_job_count
    FROM (
        SELECT DISTINCT job_id
        FROM job_history
        WHERE employee_id = p_employee_id
        UNION
        SELECT job_id
        FROM employees
        WHERE employee_id = p_employee_id
    ) AS distinct_jobs;

    RETURN v_job_count;
EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Ошибка: %', SQLERRM; -- Можно было написать RAISE NOTICE
        RETURN NULL;
END;
$$;