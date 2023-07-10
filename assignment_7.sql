-- MySQL

-- 1. Create a trigger to fill up the full_name column in the dependents table while
-- inserting any new records.

-- adding full_name column to dependents table
ALTER TABLE dependents ADD COLUMN full_name VARCHAR(45);

CREATE TRIGGER fill_full_name
BEFORE INSERT ON dependents
FOR EACH ROW
BEGIN
  SET NEW.full_name = CONCAT(NEW.first_name, ' ', NEW.last_name);
END;

-- 2. Create a trigger that stores the transaction records of each insert, update and
-- delete operations performed on the locations table into locations_info table.

--creating locations_info table
CREATE TABLE locations_info (
operation VARCHAR(10),
location_id INT,
street_address VARCHAR(255),
pincode VARCHAR(10),
city VARCHAR(50),
state_province VARCHAR(50),
country_id INT,
transaction_date date
);

--creating trigger for insertion operation
DELIMITER //
CREATE TRIGGER locations_trigger_insert
AFTER INSERT ON locations
FOR EACH ROW
BEGIN
    INSERT INTO locations_info (operation, location_id, street_address, pincode, city, state_province, country_id, transaction_date)
    VALUES ('INSERT', NEW.location_id, NEW.street_address, NEW.pincode, NEW.city, NEW.state_province, NEW.country_id, NOW());
END //
DELIMITER //

--creating trigger for update operation
DELIMITER //
CREATE TRIGGER locations_trigger_update
AFTER UPDATE ON locations
FOR EACH ROW
BEGIN
    INSERT INTO locations_info (operation, location_id, street_address, pincode, city, state_province, country_id, transaction_date)
    VALUES ('UPDATE', NEW.location_id, NEW.street_address, NEW.pincode, NEW.city, NEW.state_province, NEW.country_id, NOW());
END //
DELIMITER //

--creating trigger for delete operation
DELIMITER //
CREATE TRIGGER locations_trigger_delete
AFTER DELETE ON locations
FOR EACH ROW
BEGIN
    INSERT INTO locations_info (operation, location_id, street_address, pincode, city, state_province, country_id, transaction_date)
    VALUES ('DELETE', OLD.location_id, OLD.street_address, OLD.pincode, OLD.city, OLD.state_province, OLD.country_id, NOW());
END //
DELIMITER //

-- 3. For the following tables create a view named employee_information with
-- employee first name, last name, salary, department name, city, postal code insert
-- only those records whose postal code length is less than 5.
CREATE VIEW employee_information AS
SELECT e.first_name, e.last_name, e.salary, d.department_name, l.city, l.pincode
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN locations l ON d.location_id = l.location_id
WHERE LENGTH(l.pincode) < 5;


-- 4. Explain ACID properties with an example

-- ACID stands for Atomicity, Consistency, Isolation, and Durability. These properties are
-- fundamental to ensuring the reliability and integrity of database transactions.
-- Let's explore each property with an example:

-- Atomicity: Atomicity ensures that a transaction is treated as a single, indivisible unit of
-- work. Either all the operations within the transaction are executed successfully, or none
-- of them are. If any part of the transaction fails, the entire transaction is rolled back,
-- and the database is left unchanged.
-- Example: Consider a banking system where a transfer of funds between two accounts is
-- performed. The atomicity property ensures that either the entire transfer completes 
-- successfully, deducting funds from one account and adding them to another, or no changes 
-- are made if any step fails. If the debit from one account succeeds but the credit to the 
-- other fails, the atomicity property ensures that the debit is rolled back, and the initial
-- state is restored.

-- Consistency: Consistency ensures that a transaction brings the database from one valid 
-- state to another valid state. It guarantees that all the integrity constraints, rules, 
-- and relationships defined in the database schema are maintained before and after the 
-- transaction.
-- Example: Consider a database with a constraint that requires a product's price to be 
-- greater than zero. If a transaction attempts to update the price of a product to a 
-- negative value, the consistency property ensures that the transaction is aborted, and the 
-- database remains in a consistent state without violating the defined constraint.

-- Isolation: Isolation ensures that each transaction is executed in isolation from other 
-- transactions. It prevents interference or undesired effects caused by concurrent execution 
-- of multiple transactions. Each transaction should appear to execute serially, as if it were
-- the only transaction running.
-- Example: Suppose two users concurrently attempt to update the same bank account balance.
-- The isolation property ensures that one user's transaction is not affected by the 
-- concurrent update made by another user. Each transaction is executed independently and 
-- produces a consistent outcome without interfering with other transactions.

-- Durability: Durability guarantees that once a transaction is committed, its effects are 
-- permanent and will persist even in the event of system failures, such as power loss or 
-- crashes. Committed data is stored in non-volatile memory, typically disk storage, to 
-- ensure durability.
-- Example: After a user completes a successful online purchase, the durability property 
-- ensures that the transaction is permanently recorded in the database. Even if a system 
-- failure occurs immediately after the transaction is committed, the purchase information 
-- will not be lost and can be retrieved once the system is restored.

-- By adhering to the ACID properties, databases can maintain data integrity, transaction 
-- reliability, and recoverability in the face of various failures or concurrent access 
-- scenarios. These properties provide a solid foundation for building robust and dependable 
-- database systems.

-- 5. There are five records in a database. There is an index file associated with this and it
-- contains the values 1, 3, 2, 5 and 4. Which one of the fields is the index built from?

-- The index field associated with the values 1, 3, 2, 5 and 4 is the Occupation field because
-- after sorting the Occupational field lexicographically will give the sequence 1,3,2,5,4.