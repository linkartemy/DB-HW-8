-- Test the trigger using the SY_ANAL job, setting the new minimum salary to 5000 and the new maximum salary to 7000

-- Query to display current min and max salaries for SY_ANAL
SELECT job_id, job_title, min_salary, max_salary
FROM jobs
WHERE job_id = 'SY_ANAL';

-- Query to display employee details for SY_ANAL
SELECT employee_id, last_name, salary
FROM employees
WHERE job_id = 'SY_ANAL';

-- Attempt to update the salary range for SY_ANAL
UPDATE jobs
SET min_salary = 5000, max_salary = 7000
WHERE job_id = 'SY_ANAL';

-- Query to verify the updated salary range for SY_ANAL
SELECT job_id, job_title, min_salary, max_salary
FROM jobs
WHERE job_id = 'SY_ANAL';

-- Using the job SY_ANAL, set the new minimum salary to 7000 and the new maximum salary to 18000. Explain the results.
UPDATE jobs
SET min_salary = 7000, max_salary = 18000
WHERE job_id = 'SY_ANAL';

-- Query to verify the updated salary range for SY_ANAL
SELECT job_id, job_title, min_salary, max_salary
FROM jobs
WHERE job_id = 'SY_ANAL';