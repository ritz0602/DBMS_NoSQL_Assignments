-- MySQL

-- 1. Creating Schema

-- creating jobs table
CREATE TABLE jobs (
  job_id INT,
  job_title VARCHAR(255),
  min_salary INT,
  max_salary INT,
  PRIMARY KEY (job_id)
);

-- creating regions table
CREATE TABLE regions (
	region_id INT,
  region_name VARCHAR(255),
  PRIMARY KEY (region_id)
);

-- creating countries table
CREATE TABLE countries (
	country_id INT,
  country_name VARCHAR(255),
  region_id INT,
  PRIMARY KEY (country_id),
  FOREIGN KEY (region_id) REFERENCES regions(region_id)
);

-- creating locations table
CREATE TABLE locations (
	location_id INT,
  street_address VARCHAR(255),
  postal_code VARCHAR(10),
  city VARCHAR(50),
  state_province VARCHAR(50),
  country_id INT,
  PRIMARY KEY (location_id),
  FOREIGN KEY (country_id) REFERENCES countries(country_id)
);

-- creating departments table
CREATE TABLE departments (
	department_id INT,
  department_name VARCHAR(50),
  location_id INT,
  PRIMARY KEY (department_id),
  FOREIGN KEY (location_id) REFERENCES locations(location_id)
);

-- creating employees table
CREATE TABLE employees (
	employee_id INT,
  first_name VARCHAR(20),
  last_name VARCHAR(20),
  email VARCHAR(100),
  phone_number VARCHAR(20),
  hire_date DATE,
  job_id INT,
  salary INT,
  manager_id INT,
  department_id INT,
  PRIMARY KEY (employee_id),
  FOREIGN KEY (job_id) REFERENCES jobs(job_id),
  FOREIGN KEY (manager_id) REFERENCES employees(employee_id),
  FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

-- creating dependents table
CREATE TABLE dependents (
	dependent_id INT,
  first_name VARCHAR(20),
  last_name VARCHAR(20),
  relationship VARCHAR(20),
  employee_id INT,
  PRIMARY KEY (dependent_id),
  FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

-- 2. Insert 5 rows in the jobs, dependents, regions, countries, locations, departments tables
-- and 10 rows in the Employee table.

-- inserting 5 rows into the jobs table
INSERT INTO jobs (job_id, job_title, min_salary, max_salary)
VALUES
  (1, 'Manager', 5000, 10000),
  (2, 'Developer', 3000, 8000),
  (3, 'Analyst', 2500, 6000),
  (4, 'Designer', 2000, 5000),
  (5, 'Administrator', 2000, 4500);

-- inserting 5 rows into the regions table
INSERT INTO regions (region_id, region_name)
VALUES
  (1, 'North America'),
  (2, 'Europe'),
  (3, 'Asia'),
  (4, 'South America'),
  (5, 'Africa');

-- inserting 5 rows into the countries table
INSERT INTO countries (country_id, country_name, region_id)
VALUES
  (1, 'United States', 1),
  (2, 'Germany', 2),
  (3, 'India', 3),
  (4, 'Brazil', 4),
  (5, 'Nigeria', 5);

-- inserting 5 rows into the locations table
INSERT INTO locations (location_id, street_address, postal_code, city, state_province, country_id)
VALUES
  (1, '123 Main St', '12345', 'New York', 'NY', 1),
  (2, '456 Elm St', '67890', 'Berlin', 'Berlin', 2),
  (3, 'Park St', '54321', 'Kolkata', 'WB', 3),
  (4, '456 Pine St', '98765', 'Sao Paulo', 'Sao Paulo', 4),
  (5, '789 Maple St', '13579', 'Lagos', 'Lagos', 5);

-- inserting 5 rows into the departments table
INSERT INTO departments (department_id, department_name, location_id)
VALUES
  (1, 'Finance', 1),
  (2, 'IT', 2),
  (3, 'Marketing', 3),
  (4, 'HR', 4),
  (5, 'Operations', 5);

-- inserting 10 rows into the employees table
INSERT INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, manager_id, department_id)
VALUES
  (1, 'John', 'Doe', 'johndoe@example.com', '123456789', '2022-01-01', 1, 8000, NULL, 1),
  (2, 'Jane', 'Smith', 'janesmith@example.com', '987654321', '2022-02-01', 2, 6000, 1, 2),
  (3, 'Michael', 'Johnson', 'michaeljohnson@example.com', '567890123', '2022-03-01', 3, 5000, 1, 2),
  (4, 'Emily', 'Davis', 'emilydavis@example.com', '234567890', '2022-04-01', 2, 4000, 2, 3),
  (5, 'Olivia', 'Wilson', 'oliviawilson@example.com', '908765432', '2022-05-01', 3, 3500, 2, 3),
  (6, 'Sophia', 'Brown', 'sophiabrown@example.com', '876543210', '2022-06-01', 4, 3000, 3, 4),
  (7, 'James', 'Taylor', 'jamestaylor@example.com', '456789012', '2022-07-01', 4, 2500, 3, 4),
  (8, 'Benjamin', 'Thomas', 'benjaminthomas@example.com', '543210987', '2023-01-01', 5, 2000, 3, 5),
  (9, 'Liam', 'Anderson', 'liamanderson@example.com', '345678901', '2023-06-01', 1, 1800, 4, 5),
  (10, 'Mia', 'Martinez', 'miamartinez@example.com', '109876543', '2023-05-01', 2, 1600, 4, 5);

-- inserting 5 rows into the dependents table
INSERT INTO dependents (dependent_id, first_name, last_name, relationship, employee_id)
VALUES
  (1, 'Sarah', 'Thompson', 'Child', 1),
  (2, 'David', 'Anderson', 'Child', 1),
  (3, 'Emma', 'Johnson', 'Child', 2),
  (4, 'Liam', 'Davis', 'Child', 2),
  (5, 'Sophia', 'Martinez', 'Spouse', 3);

-- 3. Column:
-- a. In departments table, add a new field ‘manager_name’ of type VARCHAR
ALTER TABLE departments
	ADD COLUMN manager_name VARCHAR(40);

-- b. REMOVE field max_salary from jobs.
ALTER TABLE jobs
	DROP COLUMN MAX_SALARY;

-- c. In the locations table, rename postal_code column to pincode.
ALTER TABLE locations
	RENAME COLUMN postal_code TO pincode;

-- 4. Constraints:
-- a. First_name and last_name should not be null
ALTER TABLE employees
  MODIFY COLUMN first_name VARCHAR(20) NOT NULL,
  MODIFY COLUMN last_name VARCHAR(20) NOT NULL;

ALTER TABLE dependents
  MODIFY COLUMN first_name VARCHAR(20) NOT NULL,
  MODIFY COLUMN last_name VARCHAR(20) NOT NULL;

-- b. Min_salary must be greater than 1000
ALTER TABLE jobs
  ADD CONSTRAINT check_salary CHECK (min_salary > 1000);

-- c. Max length of postal_code should be 10.
ALTER TABLE locations
  MODIFY COLUMN pincode VARCHAR(10);