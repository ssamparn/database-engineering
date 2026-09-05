-- Using WHERE Clause:
-- ###########################################
/*
    WHERE clause:
        - The WHERE clause is used to filter records based on a specified condition.
        - The WHERE clause can be used with SELECT, UPDATE, and DELETE statements.
        - Using the WHERE clause, we can filter records based on a single condition or multiple conditions.
        - The WHERE clause can be used in conjunction with comparison operators, logical operators, arithmetic operators and pattern matching operators.

    Syntax:
        SELECT
            column_name(s)
        FROM
            table_name
        WHERE
            condition;
*/

-- Using WHERE clause with Operators (AND | OR | NOT):
-- #####################################################
-- Use Single Condition:

-- 1. Get all the English Language movies from the movies table.
-- We will be filtering records based on a text value.
-- When using text as criteria in the WHERE clause, the text value(s) must be surrounded by SINGLE quotes ('). WHERE movie_lang = 'English'
SELECT
    *
FROM
    movies
WHERE
    movie_lang = 'English';

-- 2. Similarly get all the Japanese Language movies from the movies table.
SELECT
    *
FROM
    movies
WHERE
    movie_lang = 'Japanese';

-- Use Multiple Conditions with AND operator:

-- 3. Get all the English Language movies from the movies table with an age certificate(VARCHAR) to 18.
SELECT
    *
FROM
    movies
WHERE
    movie_lang = 'English'
AND
    age_certificate = '18';

-- 4. Using Logical OR operator
-- The OR operator is used to filter records based on multiple conditions.
-- If any of the conditions are true, the record will be included in the result set.

-- Get all the English Language OR Chinese language movies from the movies table.
SELECT
    *
FROM
    movies
WHERE
    movie_lang = 'English'
OR
    movie_lang = 'Chinese'
ORDER BY
    movie_lang;

-- Get all the English Language and director id equal to 8.
SELECT
    *
FROM
    movies
WHERE
    movie_lang = 'English'
AND
    director_id = 8;

-- Combining AND and OR operators:
-- #######################################

-- Get all English OR Chinese language movies with age certificate equal to 12.

-- Without using parentheses, the AND operator has higher precedence than the OR operator. So, the above query will be executed as follows:
-- SELECT * FROM movies WHERE (movie_lang = 'English') OR (movie_lang = 'Chinese' AND age_certificate = '12');
-- So, the above query will return all English language movies and Chinese language movies with age certificate equal to 12. But we want to get all English and Chinese language movies with age certificate equal to 12.
-- So, we need to use parentheses to group the OR conditions together.

SELECT
    *
FROM
    movies
WHERE
    (movie_lang = 'English' OR movie_lang = 'Chinese')
AND
    age_certificate = '12';

-- What goes before and after WHERE clause?
-- #############################################################
-- Can we use WHERE before FROM clause?
-- Answer: No, we cannot use WHERE before FROM clause. The correct syntax is:
-- SELECT * WHERE movie_lang = 'English' FROM movies; -- This will give an error
-- So we can use WHERE clause only after FROM clause. The correct syntax is:
SELECT
    *
FROM
    movies
WHERE
    movie_lang = 'English';

-- Can we use WHERE after ORDER BY clause?
-- Answer: No, we cannot use WHERE after ORDER BY clause. The correct syntax is:
-- SELECT * FROM movies ORDER BY movie_lang WHERE movie_lang = 'English'; -- This will give an error
-- So we can use WHERE clause only before ORDER BY clause. The correct syntax is:
SELECT
    *
FROM
    movies
WHERE
    movie_lang = 'English'
ORDER BY
    movie_lang;

-- Execution Order of AND and OR operators in WHERE clause:
-- #############################################################
-- The AND operator has higher precedence than the OR operator. So, the above query will be executed as follows:
-- SELECT * FROM movies WHERE (movie_lang = 'English') OR (movie_lang = 'Chinese' AND age_certificate = '12');
-- So, the above query will return all English language movies and Chinese language movies with age certificate equal to 12. But we want to get all English and Chinese language movies with age certificate equal to 12.
-- So, we need to use parentheses to group the OR conditions together.
SELECT
    *
FROM
    movies
WHERE
    (movie_lang = 'English' OR movie_lang = 'Chinese')
AND
    age_certificate = '12';

-- SQL processes the AND operator like multiplication and the OR operator like addition unless you include parentheses.
-- Without parentheses, the AND operator will be processed the same way that 3*2+1 would equal 7, but 3*(2+1) would equal 9.
-- So it is better to use parentheses to group the OR conditions together to avoid confusion and to make the query more readable.

-- Using Column Aliases in WHERE clause
-- #############################################################
-- We can use column aliases in the WHERE clause.
-- But we cannot use column aliases in the WHERE clause of the same SELECT statement.
-- We can use column aliases in the WHERE clause of a subquery.
-- For example, we can use the following query to get all the English language movies with age certificate equal to 12 and assign an alias to the age_certificate column in the subquery.

-- Let's get firstname, lastname the data from the actors table.
SELECT
    first_name,
    last_name AS "Surname"
FROM
    actors;

-- Now the question is can we use the alias "Surname" in the WHERE clause of the same SELECT statement?
SELECT
    first_name,
    last_name AS surname
FROM
    actors
WHERE
    surname = 'Sharma'; -- This will give an error because we cannot use the alias "Surname" in the WHERE clause of the same SELECT statement.

-- The answer is No, we cannot use the alias "Surname" in the WHERE clause of the same SELECT statement.
-- We can use the alias "Surname" in the WHERE clause of a subquery.

-- So rewriting the above query using a subquery to use the alias "Surname" in the WHERE clause.
SELECT
    first_name,
    last_name AS surname
FROM
    actors
WHERE
    last_name IN (SELECT last_name FROM actors WHERE last_name = 'Sharma');


-- What is the order of execution of the WHERE clause in SQL?
-- #############################################################
-- The order of execution of the WHERE clause in SQL is as follows:
-- 1. FROM clause: The FROM clause is executed first to determine the source of the data.
-- 2. WHERE clause: The WHERE clause is executed next (after FROM Clause) to filter the records based on the specified condition(s).
-- 3. SELECT clause: The SELECT clause is executed last to determine which columns to include in the final result set.
-- 4. ORDER BY clause: If an ORDER BY clause is present, it is executed after the SELECT clause to sort the final result set based on the specified column(s).
