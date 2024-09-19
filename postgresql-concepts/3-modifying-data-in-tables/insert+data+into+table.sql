-- INSERT DATA INTO A TABLE
-- ###########################################################

-- 1. Create a test table called 'customers' with CREATE TABLE
-- Syntax: CREATE TABLE table_name ();

-- customer_id, first_name, last_name, email, age
CREATE TABLE IF NOT EXISTS customers (
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


-- INSERT MULTIPLE RECORDS INTO A TABLE
-- ########################################################################
-- 4. Insert multiple data records into the table.
--    We separate data with ',' to insert multiple data records into a table
-- Syntax:
/*
INSERT INTO table_name (column1, column2, ....)
VALUES
('value1', 'value2'.....),
('value3', 'value4'.....),
('value7', 'value6'.....);
*/

INSERT INTO customers (first_name, last_name, email, age)
VALUES
    ('Adnan', 'Samar', 'a@b.com', 40),
    ('Sammy', 'Wahran', 'c@d.com', 50),
    ('Bhola', 'Ishita', 'e@f.com', 60),
    ('Pandu', 'Ranga', 'g@h.com', 70);


-- INSERT A DATA WITH QUOTES
-- #######################################################################
/* 5.
   Insert a data with quotes into a table
   e.g: How to add say first_name as "Bill'O Sullivan" in customers table.
   In such cases wrap the quote (') with an additional quote (')
*/

INSERT INTO customers (first_name, last_name, email, age)
VALUES
    ('Bill''O', 'Sullivan', 'x@y.com', 80);


-- USE "RETURNING" TO GET INFO ON RETURNED ROWS
-- ########################################################################
/* 6.
   Observe the default behavior when adding a record into a table.
   After inserting a record / records, let's return all newly inserted rows.
   After inserting a record / records, let's return a single column value.
*/

-- Observe the default behavior when adding a record into a table.
INSERT INTO customers (first_name, last_name, email, age)
VALUES
    ('Bill', 'Sullivan', 'x@y.com', 90);

-- After inserting a record / records, let's return all newly inserted rows.
INSERT INTO customers (first_name, last_name, email, age)
VALUES
    ('Adam', 'Muller', 'x@y.com', 10) RETURNING *;

-- After inserting a record / records, let's return a single column value.
INSERT INTO customers (first_name, last_name, email, age)
VALUES
    ('Jake', 'Muller', 'x@y.com', 10) RETURNING customer_id, first_name;