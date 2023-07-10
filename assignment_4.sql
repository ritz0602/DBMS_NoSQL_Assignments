-- MySQL

-- 1. From the following tables write a SQL query to find the details of an employee.
-- Return full name, email, salary, Department Name, postal code, and City.
SELECT
	CONCAT(first_name, ' ', last_name) AS full_name,
  email,
  salary,
  department_name,
  pincode,
  city
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN locations l ON d.location_id = l.location_id;

-- 2. From the following tables write a SQL query to find the departments whose location is
-- in "Jammu Kashmir" or "Jharkhand". Return Department Name, state_province,
-- street_address.
SELECT department_name, state_province, street_address
FROM departments d
JOIN locations l ON d.location_id = l.location_id
WHERE state_province IN ('Jammu Kashmir', 'Jharkhand');

-- 3. From the following tables write a SQL query to find the count of employees present
-- in different jobs whose average salary is greater than 10,000. Return all the jobs with
-- employee count, Job Name, and average salary.
SELECT job_title, COUNT(*) AS employee_count, AVG(salary) as avg_salary
FROM jobs j
JOIN employees e ON j.job_id = e.job_id
GROUP BY job_title
HAVING AVG(salary) > 10000;

-- 4. From the following table write a SQL query to find all the first_names and
-- last_names in both dependents and employees tables. Return the duplicate records as
-- well and order the records in descending order of the last_name column.
SELECT first_name, last_name
FROM dependents
UNION ALL
SELECT first_name, last_name
FROM employees
ORDER BY last_name DESC;

-- 5. From the following table write a SQL query to list every employee that has a manager
-- with the name of his or her manager.
SELECT
  CONCAT(e1.first_name, ' ', e1.last_name) AS employee,
  CONCAT(e2.first_name, ' ', e2.last_name) AS manager
FROM employees e1
JOIN employees e2 ON e2.employee_id = e1.manager_id;


-- 6. Find the departments that have more than 5 employees earning a salary greater than
-- 50,000 and are located in either New York or California. Include the department name,
-- location, and the number of employees meeting the criteria.
SELECT d.department_name, l.state_province, count(*) AS no_of_employees
FROM departments d
JOIN employees e ON e.department_id = d.department_id
JOIN locations l ON d.location_id = l.location.id
WHERE e.salary > 50000 AND l.state_province IN ('New York', 'California')
GROUP BY d.department_name
HAVING count(*) > 5;


-- 7. List any employees who have dependents and have a job title that includes the word
-- 'manager', and sort the results by department name in ascending order.
-- SELECT CONCAT(e.first_name, ' ',e.last_name) AS employee_name
-- FROM employees e
-- JOIN jobs j ON e.job_id = j.job_id
-- JOIN departments dept ON e.department_id = dept.department_id
-- WHERE e.employee_id IN (
-- 		SELECT employee_id
--         FROM dependents
-- 	)
-- 	AND j.job_title LIKE '%manager%'
-- ORDER BY dept.department_name;

SELECT
  CONCAT(e.first_name, ' ', e.last_name) AS employee,
  j.job_title, d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN jobs j ON e.job_id = j.job_id
WHERE e.employee_id IN (
    SELECT DISTINCT employee_id
    FROM dependents
  )
  AND j.job_title LIKE '%manager%'
ORDER BY d.department_name ASC;

-- 8. Add a column in the dependent table called “city” depicting their current location of
-- stay.
-- Find all employees who have been hired in the past 3 years and have dependents
-- living in a city that is different from the city they work in (if I work in Kolkata, then my
-- dependent should not be in Kolkata).
-- Additionally, only include employees whose salary is greater than the average salary of
-- their job title(suppose, my job_title is ”developer” and the salary is 80k, and the average
-- salary under the same job_title “developer” is 70k), and whose manager's job title
-- includes the word 'director'. Finally, include the department name and location of each
-- employee, and sort the results by department name in ascending order

-- adding column 'city' to dependents table
ALTER TABLE dependents 
  ADD column city VARCHAR(50);

-- filling up city column
UPDATE dependents 
SET city ='New York' WHERE dependent_id = 1;
UPDATE dependents 
SET city = 'Lagos' WHERE dependent_id = 2;
UPDATE dependents 
SET city = 'Berlin' WHERE dependent_id = 3;
UPDATE dependents 
SET city = 'Sao Paulo' WHERE dependent_id = 4;
UPDATE dependents 
SET city = 'Kolkata' WHERE dependent_id = 5;

SELECT
  CONCAT(e.first_name,' ',e.last_name) AS employee,
FROM employees e
JOIN dependents d ON e.employee_id = d.employee_id
JOIN departments d2 ON e.department_id = d2.department_id 
JOIN locations l ON d2.location_id = l.location_id
JOIN jobs j ON j.job_id = e.job_id 
WHERE e.hire_date >= DATE_SUB(CURDATE(), INTERVAL 3 YEAR)
AND l.city <> d.city
AND e.salary > (
  SELECT AVG(salary)
  FROM employees
  WHERE job_title = j.job_title
)
AND e.employee_id IN (
  SELECT e1.employee_id
  FROM employees e1
  JOIN employees m ON e1.manager_id = m.employee_id
  JOIN jobs j ON m.job_id = j.job_id
  WHERE j.job_title LIKE '%director%')
ORDER BY d2.department_name
;