-- ASSIGNING COLUMN ALIAS TO AN EXPRESSION
-- #############################################

-- 1. Lets get first_name, last_name from actors table.

SELECT
    first_name,
    last_name
FROM actors;

-- 2. Combine first_name and last_name with a space in between and assign it an alias Full Name using expression in the SELECT statement.
-- The result will be a single column with the full name of each employee.
-- We will use the concatenation operator (||) to combine the first_name and last_name columns, and we will assign the result an alias of full_name.
SELECT
    first_name || ' ' || last_name AS "Full Name"
FROM actors;

-- 3. Use expressions to get output without using a table column. For example, we can use the expression 2 * 5 to get the output of 10.
SELECT
    2 * 5 AS "Result";


