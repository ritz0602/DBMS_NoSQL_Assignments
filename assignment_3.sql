-- MySQL

-- 1. Write the query to get the department and department wise total(sum) salary,
-- display it in ascending order according to salary.
SELECT department_id, SUM(salary) AS total_salary
FROM employees
GROUP BY department_id;

-- 2. Write the query to get the department, total no. employee of each department,
-- total(sum) salary with respect to department from "Employee" table.
SELECT department_id, COUNT(*) AS total_employees, SUM(salary) AS total_salary
FROM employees
GROUP BY department_id;

-- 3. Get department wise maximum salary from "Employee" table order by salary
-- ascending
SELECT department_id, MAX(salary) AS max_salary
FROM employees
GROUP BY department_id
ORDER BY salary;

-- 4. Write a query to get the departments where average salary is more than 60k
SELECT department_id
FROM employees
GROUP BY department_id
HAVING AVG(salary) > 60000;

-- 5. Write down the query to fetch department name assign to more than one
-- Employee
SELECT department_name, COUNT(*) AS employee_count
FROM departments d
JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_id
HAVING COUNT(*) > 1;

-- 6. Write a query to show department_name and assignedTo where assignedTo
-- will be “One candidate” if its assigned to only one employee otherwise
-- “Multiple candidates”
SELECT department_name, 
       CASE 
           WHEN total_employees = 1 THEN 'One candidate'
           ELSE 'Multiple candidates'
       END AS assignedTo
FROM (
    SELECT department_name, COUNT(*) AS total_employees
    FROM departments d
    JOIN employees e ON d.department_id = e.department_id
    GROUP BY d.department_id
) AS department_employees;