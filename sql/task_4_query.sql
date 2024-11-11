-- Invoke the GET_YEARS_SERVICE function in a call to DBMS_OUTPUT.PUT_LINE for an employee with ID 999.
DO $$
DECLARE
    v_years INTEGER;
BEGIN
    v_years := get_years_service(999);
    RAISE EXCEPTION 'Employee с ID 999 имеет % лет стажа.', v_years;
EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Ошибка: %', SQLERRM;
END;
$$;

-- Display the number of years of service for employee 106 with DBMS_OUTPUT.PUT_LINE invoking the GET_YEARS_SERVICE function.
DO $$
DECLARE
    v_years INTEGER;
BEGIN
    v_years := get_years_service(106);
    RAISE NOTICE 'Employee с ID 106 имеет лет стажа: %.', v_years;
END;
$$;

-- Query the JOB_HISTORY and EMPLOYEES tables for the specified employee to verify that the modifications are accurate.
SELECT *
FROM job_history
WHERE employee_id = 106;

SELECT *
FROM employees
WHERE employee_id = 106;