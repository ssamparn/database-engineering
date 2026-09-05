-- Using ORDER BY to sort records
-- ########################################

/*
    ORDER BY:
        - In SQL, when you retrieve data from a database, the order in which the rows are returned is not guaranteed unless you explicitly specify it.
        - The ORDER BY clause in SQL is used to sort the result set of a query by one or more columns.
        - It allows you to specify the order in which the rows should be returned, either in ascending (ASC) or descending (DESC) order.
        - By default, the ORDER BY clause sorts the result set in ascending order if no order is specified.
        - You can sort by multiple columns, and you can also use expressions in the ORDER BY clause.
        Syntax:
            SELECT column1, column2, ...
            FROM table_name
            ORDER BY
                    sort_expression1 [ASC|DESC],
                    ...
                    ...
                    sort_expressionN [ASC|DESC];
        - sort_expression can be a column name, an expression, or a function that returns a value.
        - ASC (ascending) is the default sort order, and DESC (descending) is used to sort in reverse order.
*/

-- 1. Sort records based on single column in ascending order (default).
-- Sort all movie records by their release date in ascending order (oldest to newest).

SELECT
    *
FROM
    movies
ORDER BY
    release_date ASC;

-- What if I don't specify ASC or DESC? The default is ascending order?
SELECT
    *
FROM
    movies
ORDER BY
    release_date;

-- Note: ASC is the default sort order, so if you don't specify it, the records will be sorted in ascending order.

-- 2. Sort all movies by their release date in descending order (newest to oldest).
SELECT
    *
FROM
    movies
ORDER BY
    release_date DESC;

-- 3. Sort based on multiple columns.
-- Sort all movies by their release date in descending order, and movie names in ascending order.

SELECT
    *
FROM
    movies
ORDER BY
    release_date DESC,
    movie_name ASC;

-- Note: The sequence of the columns in the ORDER BY clause matters.
-- The records will be sorted first by the first column, and then by the second column if there are ties in the first column.
-- But if you want to sort by the second column first, you can change the order of the columns in the ORDER BY clause.

-- Use ORDER BY with alias column name
-- ###############################################

-- 4. Get first_name, last_name from actors table, make an alias for last_name as "Surname" and sort rows by last_name in Descending order.
SELECT
    first_name AS "Firstname",
    last_name AS "Surname"
FROM
    actors
ORDER BY
    "Surname" DESC;

-- Use ORDER BY to sort rows by expressions
-- ###############################################

-- Let's get all the records from actors table
SELECT
    *
FROM
    actors;

-- Let's calculate the length of the actor name with LENGTH() function
SELECT
    first_name,
    last_name,
    LENGTH(first_name || ' ' || last_name) AS "Name Length"
FROM
    actors;

-- Now let's sort rows by the length of the actor name in descending order.
SELECT
    first_name,
    last_name,
    LENGTH(first_name || ' ' || last_name) AS "Name Length"
FROM
    actors
ORDER BY
    "Name Length" DESC;

-- Note: Here for one particular row, the first_name is null, but last_name is "Denden". But still the length of the name is 6, because the LENGTH() function returns the length of the string, and it counts the null value as 0. So the length of the name is null instead of 6 which is the length of "Denden".
-- Why? This happens because in many SQL databases, string concatenation with NULL results in NULL.
-- Expression first_name || ' ' || last_name is evaluated like this when first_name is NULL: NULL || ' ' || 'Denden'. And the result is: NULL. And then the LENGTH() function is applied to NULL, which returns NULL. So the length of the name is null instead of 6 which is the length of "Denden".

-- How to fix it?
-- Use COALESCE() to replace NULL with an empty string.

SELECT
    first_name,
    last_name,
    LENGTH(
            COALESCE(first_name, '') || ' ' || COALESCE(last_name, '')
    ) AS "Name Length"
FROM actors
ORDER BY "Name Length" ASC;


-- How to use column name or column position in ORDER BY clause?
-- ##############################################################

-- Let's view all the records from actors table
SELECT
    *
FROM
    actors;

-- Sort all the records by first_name in ascending order & date of birth in descending order using column name in ORDER BY clause.
SELECT
    first_name,
    last_name,
    date_of_birth
FROM
    actors
ORDER BY
    first_name ASC,
    date_of_birth DESC;

-- Now use column position in ORDER BY clause to sort all the records by first_name in ascending order & date of birth in descending order.
SELECT
    first_name,     -- // 1st column
    last_name,      -- // 2nd column
    date_of_birth   -- // 3rd column
FROM
    actors
ORDER BY
    1 ASC,
    3 DESC;

-- Note: Here, we are using the column position in the ORDER BY clause instead of the column name. The first column is first_name, and the third column is date_of_birth.
-- Column position is the position of the column in the SELECT statement, starting from 1. Not the position of columns in the table. So, the first column in the SELECT statement is first_name, and the third column is date_of_birth.
-- So we are sorting the records by first_name in ascending order and date_of_birth in descending order.


-- Using ORDER BY with NULL values
-- ##############################################################
/*
    In PostgreSQL, NULL is a marker that indicates
        - The absence of a value or
        - An unknown value in a column.
    When sorting records using the ORDER BY clause, NULL values are treated as the lowest possible values.

    When you sort in ascending order (ASC), NULL values will appear first, and when you sort in descending order (DESC), NULL values will appear last.
    So when you sort rows that contain NULL values, you may want to specify how you want the NULL values to be sorted using the NULLS FIRST or NULLS LAST options in the ORDER BY clause.

    NULLS FIRST: This option specifies that NULL values should appear before any non-NULL values in the sorted result set.
    NULLS LAST: This option specifies that NULL values should appear after all non-NULL values in the sorted result set.
*/

-- 1. To demonstrate, let's create a table called demo_sorting.

CREATE TABLE demo_sorting (
    num INT
);

-- 2. Insert some records into the demo_sorting table, including NULL values.
INSERT INTO
    demo_sorting (num)
VALUES
    (5),
    (NULL),
    (3),
    (NULL),
    (8),
    (1);

-- 3. Let's view all the records from the demo_sorting table.
SELECT
    *
FROM
    demo_sorting;

-- 4. Let's sort the records in ascending order (default) without specifying NULLS FIRST or NULLS LAST.
SELECT
    *
FROM
    demo_sorting
ORDER BY
    num ASC;

-- 5. Let's sort the records in ascending order (default) with NULLS LAST.
SELECT
    *
FROM
    demo_sorting
ORDER BY
    num ASC NULLS LAST;

-- Note: NULLS LAST is the default behavior in PostgreSQL when sorting in ascending order, so you don't need to specify it explicitly.

-- 6. Let's sort the records in descending order with NULLS FIRST.
SELECT
    *
FROM
    demo_sorting
ORDER BY
    num DESC NULLS FIRST;

-- 7. Drop the demo_sorting table after the demonstration.
DROP TABLE demo_sorting;