-- Selecting DISTINCT values
-- ################################

/*
    Selecting DISTINCT values:
    1. The DISTINCT keyword is used in SQL to retrieve unique values from a column or a combination of columns in a table.
    2. When we use DISTINCT, it eliminates duplicate values from the result set, returning only one instance of each unique value.
    3. The DISTINCT keyword can be used with one or more columns in a SELECT statement.
    4. When DISTINCT is used with multiple columns, it returns unique combinations of values from those columns.
    5. The DISTINCT keyword can be used with aggregate functions to get unique values from a column.
    6. The DISTINCT keyword can be used with the ORDER BY clause to sort the unique values in ascending or descending order.
    7. The DISTINCT keyword can be used with the LIMIT clause to limit the number of unique values returned in the result set.
    8. The DISTINCT keyword can be used with the GROUP BY clause to group the unique values in a column or a combination of columns.
    9. The DISTINCT keyword can be used with the HAVING clause to filter the unique values in a column or a combination of columns based on a condition.
    10. The DISTINCT keyword can be used with the JOIN clause to retrieve unique values from multiple tables based on a common column.

    Syntax:
    SELECT
    DISTINCT
        column_name
    FROM
        table_name;
*/

-- 1. Get all the records from movies table.
SELECT * FROM movies;

-- 2. Get movie lang from movies table.
SELECT
    movie_lang
FROM
    movies;

-- 3. Get distinct movie lang from movies table.
SELECT
DISTINCT
    movie_lang
FROM
    movies;

-- 4. Get distinct movie lang from movies table and order them in Ascending order.
SELECT
DISTINCT
    movie_lang
FROM
    movies
ORDER BY
    movie_lang ASC;

-- 5. Get unique director id and sort them in ascending order.
SELECT
DISTINCT
    director_id
FROM
    movies
ORDER BY
    director_id ASC;

-- 6. Get multiple distinct values e.g: get distinct movie lang and director id from movies table.
SELECT
DISTINCT
    movie_lang, director_id
FROM
    movies
ORDER BY
    movie_lang ASC, director_id ASC;

-- Note: When we use DISTINCT with multiple columns, it returns unique combinations of values from those columns.
-- In the above query, it will return unique combinations of movie_lang and director_id from the movies table.
-- Even if the movie_lang is same for multiple records, it will return only one record for that movie_lang with unique director_id.

-- 7. Get all unique records in movies table.
SELECT
DISTINCT
    *
FROM
    movies;

-- Note: When we use DISTINCT with *, it returns unique records from the table.
-- Difference between SELECT DISTINCT * and SELECT * is that SELECT DISTINCT * will return unique records from the table, while SELECT * will return all records from the table including duplicates.
-- Most of the time, if we use SELECT DISTINCT *, it will return all the records from the table because most of the time, all the records in a table are unique.
-- Only in the cases of duplicate records, SELECT DISTINCT * will return unique records from the table.