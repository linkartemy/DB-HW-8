-- Execute the UPD_JOBSAL procedure by using a job ID of 'SY_ANAL', a minimum salary of 7000, and a maximum salary of 140.
CALL upd_jobsal('SY_ANAL', 7000, 140);

-- Disable triggers on the EMPLOYEES and JOBS tables.
ALTER TABLE employees DISABLE TRIGGER ALL;
ALTER TABLE jobs DISABLE TRIGGER ALL;

-- Execute the UPD_JOBSAL procedure using a job ID of 'SY_ANAL', a minimum salary of 7000, and a maximum salary of 14000.
CALL upd_jobsal('SY_ANAL', 7000, 14000);

-- Query the JOBS table to view your changes, and then commit the changes.
SELECT *
FROM jobs
WHERE job_id = 'SY_ANAL';
COMMIT;

-- Enable the triggers on the EMPLOYEES and JOBS tables.
ALTER TABLE employees ENABLE TRIGGER ALL;
ALTER TABLE jobs ENABLE TRIGGER ALL;
