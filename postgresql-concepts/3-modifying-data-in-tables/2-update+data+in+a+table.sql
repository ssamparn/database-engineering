-- UPDATE DATA IN A TABLE
-- ###################################

-- 1. Update a single column in 'customers' table.

-- Syntax:
/*
UPDATE table_name
SET column_name = 'new-value'
WHERE column_name = 'value';
*/
UPDATE customers
SET email = 'abc@xyz.com'
WHERE customer_id = 1;


-- 2. Update multiple columns in 'customers' table

-- Syntax:
/*
UPDATE table_name
SET
    column_name_1 = 'new-value', column_name_2 = 'new-value'
WHERE column_name = 'value';
*/
UPDATE customers
SET
    email = 'abc@xyz.com', first_name = 'Nandan'
WHERE customer_id = 1;


-- 3. Use RETURNING to get the updated rows
-- Syntax:
/*
UPDATE table_name
SET
    column_name_1 = 'new-value', column_name_2 = 'new-value'
WHERE column_name = 'value' RETURNING *;
*/

UPDATE customers
SET
    email = 'abc@xyz.com', first_name = 'Nandan'
WHERE customer_id = 1 RETURNING *;


-- UPDATE ALL RECORDS IN A TABLE WITH A VALUE
-- #######################################################
-- 4. Update all records in a table with no WHERE clause.
--    That means if we have to update all the records in a table with a unique value, then we don't have to use WHERE clause.
-- Scenario: Create a new column in customers table as "is_enable"
--           & update all the records with as 'Y' in "is_enable"

-- Syntax:
/*
ALTER TABLE table_name
ADD column_name datatype;
*/

ALTER TABLE customers
    ADD is_enable varchar(2);

-- Syntax:
/*
UPDATE table_name
SET
    column_name_1 = 'new-value'
*/

UPDATE customers
SET is_enable = 'Y';

-- or

UPDATE customers
SET is_enable = 'Y' RETURNING *;

-- This statement will run on all the table rows


-- DELETE RECORDS FROM A TABLE
-- ##################################

-- 5. To delete records from a table based on a condition.
-- Syntax:

/*
DELETE FROM table_name
WHERE column_name = 'value';
*/

DELETE FROM customers
WHERE customer_id = 10;


-- 6. To delete ALL records from a table.
-- Syntax:

/*
DELETE FROM table_name;
*/
-- Note: Be extra cautious when executing DELETE FROM table_name; As this action is irrevocable. We can not retrieve the data back unless we have a data backup maintained.

DELETE FROM customers;




