-- Advanced SQL Script for Employee Analysis
-- Author: Suroom Khan
-- Date: 03 Feb 2025
-- Description: This script analyzes employee data using aggregate functions, conditional aggregation, and string/date manipulation.

-- Step 1: Calculate department-level metrics
WITH department_metrics AS (
    SELECT
        department,
        COUNT(employee_id) AS employee_count,
        AVG(salary) AS avg_salary,
        SUM(bonus) AS total_bonus,
        -- Calculate the total tenure in years for each department
        SUM(DATE_DIFF(CURRENT_DATE(), hire_date, YEAR)) AS total_tenure_years
    FROM
        employees
    GROUP BY
        department
),

-- Step 2: Calculate employee-level metrics
employee_metrics AS (
    SELECT
        employee_id,
        CONCAT(first_name, ' ', last_name) AS full_name,
        hire_date,
        salary,
        bonus,
        department,
        -- Calculate employee tenure in years
        DATE_DIFF(CURRENT_DATE(), hire_date, YEAR) AS tenure_years,
        -- Categorize employees based on salary
        CASE
            WHEN salary >= 90000 THEN 'High Earner'
            WHEN salary BETWEEN 75000 AND 89999 THEN 'Mid Earner'
            ELSE 'Low Earner'
        END AS salary_category
    FROM
        employees
)

-- Step 3: Combine department and employee metrics for final analysis
SELECT
    dm.department,
    dm.employee_count,
    dm.avg_salary,
    dm.total_bonus,
    dm.total_tenure_years,
    em.full_name,
    em.tenure_years,
    em.salary,
    em.bonus,
    em.salary_category
FROM
    department_metrics dm
JOIN
    employee_metrics em
ON
    dm.department = em.department
ORDER BY
    dm.department,
    em.tenure_years DESC;
