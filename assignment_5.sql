-- MySQL

-- 1) Find all the departments where the minimum salary is less than 2000.
SELECT department_name
FROM departments d
JOIN employees e ON e.department_id = d.department_id
GROUP BY department_name
HAVING MIN(salary) < 2000;

-- 2) Find all the countries where no employees exist.
SELECT c.country_name
FROM countries c
LEFT JOIN locations l ON c.country_id = l.country_id
LEFT JOIN departments d ON l.location_id = d.location_id
LEFT JOIN employees e ON d.department_id = e.department_id
WHERE e.employee_id IS NULL;

-- 3) From the following tables write a query to find all the jobs, having at least 2 employees in a
-- single department.(don’t use joins)
SELECT job_title
FROM jobs
WHERE job_id IN (
  SELECT job_id
  FROM employees
  GROUP BY job_id, department_id
  HAVING COUNT(*) >= 2
);

-- 4)From the following tables write a query to find all the countries, having cities with all the city
-- names starting with 'a'.(don’t use joins)
SELECT country_name
FROM countries
WHERE country_id IN (
  SELECT country_id
  FROM locations
  GROUP BY country_id
  HAVING COUNT(*) = SUM(CASE WHEN city LIKE 'a%' THEN 1 ELSE 0 END)
);

-- 5)From the following tables write a query to find all the departments, having no cities.
SELECT department_name
FROM departments
WHERE location_id IN (
  SELECT location_id
  FROM locations
  WHERE city IS NULL
);