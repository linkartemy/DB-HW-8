CREATE OR REPLACE FUNCTION get_years_service(p_employee_id INTEGER)
RETURNS INTEGER
LANGUAGE plpgsql
AS $$
DECLARE
    v_total_days INTEGER := 0;
    v_current_hire_date DATE;
    v_job_history_days INTEGER;
BEGIN
    SELECT hire_date INTO v_current_hire_date
    FROM employees
    WHERE employee_id = p_employee_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Employee с таким ID не существует.';
    END IF;

    SELECT COALESCE(SUM(end_date - start_date), 0) INTO v_job_history_days -- COALESCE - если нет записей, то вернет 0
    FROM job_history
    WHERE employee_id = p_employee_id;

    v_total_days := v_job_history_days + (CURRENT_DATE - v_current_hire_date); -- Записи работ + количество дней с текущей работы

    RETURN FLOOR(v_total_days / 365);
EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Возникла ошибка: %', SQLERRM;
        RETURN NULL;
END;
$$;
