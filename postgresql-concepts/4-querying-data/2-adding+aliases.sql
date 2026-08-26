-- ADDING ALIAS TO A COLUMN NAME
-- ####################################

/*
    Aliases:
        - Aliases are temporary names that can be given to a column or table in a SQL query.
        - They are used to make the output more readable or to simplify complex queries.
        - Aliases are created using the AS keyword, followed by the desired alias name.
        - Aliases can be used in the SELECT, FROM, and WHERE clauses of a SQL query.
        - Aliases are not stored in the database and only exist for the duration of the query.
        - Aliases can be used to rename columns or tables in the output of a query.

*/
-- Syntax:
/*
SELECT column AS alias_name FROM table_name;
*/

-- Get all records from actors table.
SELECT * FROM actors;

/*
    Column Alias:

    Without Alias: SELECT first_name, last_name FROM actors;
    With Alias: SELECT first_name AS "First Name", last_name AS "Last Name" FROM actors;
*/
SELECT
    first_name,
    last_name
FROM actors;

SELECT
    first_name AS "First Name",
    last_name AS "Last Name"
FROM actors;

/*
    AS is optional. We can also write the above query as:
    SELECT first_name "First Name", last_name "Last Name" FROM actors;
*/
SELECT
    first_name "First Name",
    last_name "Last Name"
FROM actors;

/*
    Table Alias:
        Instead of using the full table name in a query, we can use an alias for the table name.
        This is especially useful when we are joining multiple tables in a query.
        Table aliases are created using the AS keyword, followed by the desired alias name.
        Table aliases can be used in the SELECT, FROM, and WHERE clauses of a SQL query.

    Instead of repeatedly writing the full table name:
        SELECT actors.first_name, actors.last_name FROM actors;

    We can use a table alias:
        SELECT a.first_name, a.last_name FROM actors AS a;
*/

SELECT
    actors.first_name,
    actors.last_name
FROM actors;

SELECT
    a.first_name,
    a.last_name
FROM actors AS a;

/*
    Why Table alias is useful?
        - When we are joining multiple tables in a query, using table aliases makes the query more readable and easier to understand.
        - It also helps to avoid ambiguity when two or more tables have columns with the same name.
    e.g:
        SELECT d.first_name, d.last_name, m.movie_name, m.release_date
        FROM movies AS m
        JOIN directors AS d
            ON m.director_id = d.director_id;
*/
SELECT
    d.first_name,
    d.last_name,
    m.movie_name,
    m.release_date
FROM
    movies AS m
JOIN
    directors AS d
ON m.director_id = d.director_id;

