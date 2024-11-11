CREATE OR REPLACE FUNCTION check_sal_range_func()
RETURNS trigger AS $$
BEGIN
IF (NEW.min_salary IS DISTINCT FROM OLD.min_salary) OR
    (NEW.max_salary IS DISTINCT FROM OLD.max_salary) THEN
    IF NEW.min_salary > NEW.max_salary THEN
        RAISE EXCEPTION 'Минимальная зарплата (%) не может быть больше максимальной зарплаты (%) для job с ID %.', NEW.min_salary, NEW.max_salary, NEW.job_id;
    END IF;

    IF EXISTS (
        SELECT 1 FROM employees
        WHERE job_id = NEW.job_id
              AND (salary < NEW.min_salary OR salary > NEW.max_salary)
    ) THEN
        RAISE EXCEPTION 'Нельзя обновить минимальную и максимальную зарплату для job с ID "%", потому что есть employees, у которых зарплата вне данного диапазона (% - %).',
            NEW.job_id, NEW.min_salary, NEW.max_salary;
    END IF;
END IF;

RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER check_sal_range
BEFORE UPDATE OF min_salary, max_salary
ON jobs
FOR EACH ROW
EXECUTE FUNCTION check_sal_range_func();