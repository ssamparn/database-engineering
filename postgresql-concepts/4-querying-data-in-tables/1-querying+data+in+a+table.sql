-- SELECT ALL DATA FROM A TABLE
-- ####################################

-- Syntax:
/*
SELECT * FROM table_name;
*/

-- Get all records from movies table.

SELECT * FROM movies;

-- or

SELECT * FROM MOVIES;

/*
    1. Note that the SQL keywords are case-insensitive.
       It means that SELECT is equivalent to select or Select.
       By convention, we will use all the SQL keywords in uppercase to make the queries easier to read.

    2. Important to note:
       PostgreSQL evaluates the FROM clause before the SELECT clause in the SELECT statement.

    3. Is it a good practice to use * in SELECT?
       Ans: NO. It is not.
       Because a) Database performance - Using * in a table with lots of columns might affect database performance.
               b) Application performance - Retrieving unnecessary data from the database increases the traffic
                  between the database server and application server, which slows down the application performance.
    4. So use '*' wisely.

    5. So it is advised to use explicit column names in SELECT statement.
*/

-- SELECTING SPECIFIC COLUMNS/FIELDS FROM A TABLE
-- #######################################################

-- Use explicit column names in SELECT statement

/*
SELECT column_1, column_2
FROM table_name;
*/

-- Get first name, last_name from actors table.
SELECT actor_id, first_name, last_name
FROM actors;

-- Get movie_id & movie_name from movies table.
SELECT movie_id, movie_name
FROM movies;

/*
Note: Using explicit column names is a good practice and produce less load on server end.
*/