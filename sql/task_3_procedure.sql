CREATE OR REPLACE PROCEDURE upd_jobsal(
    p_job_id VARCHAR(10),
    p_min_salary INTEGER,
    p_max_salary INTEGER
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF p_max_salary < p_min_salary THEN
        RAISE EXCEPTION 'Максимальная зарплата не может быть меньше минимальной.';
    END IF;
    
    UPDATE jobs
    SET min_salary = p_min_salary,
        max_salary = p_max_salary
    WHERE job_id = p_job_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Job с таким ID не найдена.';
    END IF;

EXCEPTION
    WHEN lock_not_available THEN
        RAISE EXCEPTION 'Таблица заблокирована.';
END;
$$;