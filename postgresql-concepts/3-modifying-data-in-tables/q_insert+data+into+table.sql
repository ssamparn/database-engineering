-- Insert data into a table
-- #######################################################

-- 1. Create a test table called 'customers' with CREATE TABLE
-- Syntax: CREATE TABLE table_name ();

-- customer_id, first_name, last_name, email, age
CREATE TABLE customers (
	customer_id SERIAL PRIMARY KEY,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	email VARCHAR(150),
	age INT
);


-- 2. View the table data with SELECT
-- Syntax:
/*
SELECT * FROM table_name;
*/

SELECT * FROM customers;


-- 3. Insert data into the table.
-- Syntax:
/*
INSERT INTO table_name (column1, column2, ....)
VALUES ('value1', 'value2'.....);
*/

INSERT INTO customers (first_name, last_name, email, age)
VALUES ('Adnan','Waheed','a@b.com',40);
  