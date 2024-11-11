ALTER TABLE employees DISABLE TRIGGER ALL;

ALTER TABLE jobs DISABLE TRIGGER ALL;

ALTER TABLE job_history DISABLE TRIGGER ALL;

-- Execute the procedure with employee ID 106 and job ID 'SY_ANAL' as parameters.
CALL add_job_hist (106, 'SY_ANAL');

-- Query the JOB_HISTORY and EMPLOYEES tables to view your changes for employee 106, and then commit the changes.
SELECT
    *
FROM
    job_history
WHERE
    employee_id = 106;

SELECT
    *
FROM
    employees
WHERE
    employee_id = 106;

COMMIT;

-- Reenable the triggers on the EMPLOYEES, JOBS, and JOB_HISTORY tables.
ALTER TABLE employees ENABLE TRIGGER ALL;

ALTER TABLE jobs ENABLE TRIGGER ALL;

ALTER TABLE job_history ENABLE TRIGGER ALL;