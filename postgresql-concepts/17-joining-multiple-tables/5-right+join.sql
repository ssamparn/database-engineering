-- RIGHT JOIN:
-- ####################

/*
    What is Right Join in SQL?
        - Right Join is a type of join that returns all records from the right table (table2), and the matched records from the left table (table1).
        - The result is NULL from the left side, if there is no match.
        - Syntax:
            SELECT column_name(s)
            FROM table1
            RIGHT JOIN table2
            ON table1.column_name = table2.column_name;

    Where to use Right Join in SQL?
        - Right Join is used when you want to retrieve all records from the right table, regardless of whether there is a match in the left table.
        - It is useful when you want to see all records from the right table and any matching records from the left table.

    Use cases of Right Join in SQL:
        - Finding Unmatched Records: When you want to retrieve all records from the right table and any matching records from the left table.
        - Data Analysis: When you want to analyze data from two tables and see all records from the right table, even if there are no matches in the left table.
        - Reporting: When you want to generate reports that include all records from the right table, regardless of whether there are matches in the left table.

    From an Interview Perspective:
        - Right Join is a common topic in SQL interviews, and it is important to understand how it works and when to use it.
        - Interviewers may ask you to explain the difference between Left Join and Right Join, or to write a query using Right Join to retrieve specific data from two tables.

    For example, an interviewer may ask following question:
    1. Can you write a SQL query to retrieve all records from the 'employees' table and any matching records from the 'departments' table, even if there are no matches in the 'employees' table?
    Answer: In this case, you would use a Right Join to retrieve all records from the 'departments' table and any matching records from the 'employees' table.
        SELECT employees.*, departments.*
        FROM employees
        RIGHT JOIN departments
        ON employees.department_id = departments.id;

    2. Can you explain the difference between Left Join and Right Join in SQL?
    Answer: Left Join returns all records from the left table and any matching records from the right table, while Right Join returns all records from the right table and any matching records from the left table.

    3. Can you give an example of when you would use a Right Join in SQL?
    Answer: One example of when you would use a Right Join is when you want to retrieve all records from the 'departments' table and any matching records from the 'employees' table, even if there are no matches in the 'employees' table.
    This would allow you to see all departments, even if there are no employees assigned to them.

    4. Can you explain how Right Join works in SQL?
    Answer: Right Join works by returning all records from the right table and any matching records from the left table.
    If there are no matches in the left table, the result will contain NULL values for the columns from the left table.
    The join condition is specified using the ON clause, which defines how the two tables are related.

    5. Why Right Join is important as we can achieve the same result with left join by just reversing the order of the tables?
    Answer: While it is true that you can achieve the same result with a Left Join by reversing the order of the tables, Right Join can make your SQL queries more readable and easier to understand, especially when dealing with complex queries involving multiple tables.
    It can also help to clarify the intent of the query, as it explicitly indicates that you want to retrieve all records from the right table, regardless of whether there are matches in the left table.
    Additionally, some database systems may optimize Right Joins differently than Left Joins, so using the appropriate join type can potentially improve query performance.
*/

-- 1. Let's create some sample tables for our JOIN exercises:
-- To better visualize join types, let's call the tables "left_products" and "right_products".

CREATE TABLE left_products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL
);

CREATE TABLE right_products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL
);

-- Insert sample data into left_products
INSERT INTO left_products (product_id, product_name) VALUES
(1, 'Computers'),
(2, 'Laptops'),
(3, 'Monitors'),
(5, 'Mics');

-- Insert sample data into right_products
INSERT INTO right_products (product_id, product_name) VALUES
(1, 'Computers'),
(2, 'Laptops'),
(3, 'Monitors'),
(4, 'Pen'),
(7, 'Paper');

-- Now, let's perform a RIGHT JOIN on these two tables to see how it works.
SELECT
    lp.product_id AS left_product_id,
    lp.product_name AS left_product_name,
    rp.product_id AS right_product_id,
    rp.product_name AS right_product_name
FROM
    left_products lp
RIGHT JOIN
    right_products rp ON lp.product_id = rp.product_id;

-- What we expect to see in the result set?
--1. All records from the right_products table will be returned.
--2. For the records in right_products that have a matching product_id in left_products,
--   the corresponding product_name from left_products will be displayed.
--3. For the records in right_products that do not have a matching product_id in left_products (like product_id 4 and 7), the left_product_id and left_product_name will be NULL.

-- 2. Let's perform RIGHT JOIN of directors table with movie table to see how it works in a real-world scenario.
-- List all the movies with their corresponding directors, and movie names.
-- Since it is asking all the movies, here movies is the right table and directors is the left table. So, we will use RIGHT JOIN.

SELECT
    m.movie_id AS "Movie ID",
    m.movie_name AS "Movie Name",
    d.director_id AS "Director ID",
    d.first_name AS "Director First Name",
    d.last_name AS "Director Last Name"
FROM
    directors d
RIGHT JOIN
    movies m
ON d.director_id = m.director_id;

-- Now let's reverse the order of the tables and see the impact
SELECT
    m.movie_id AS "Movie ID",
    m.movie_name AS "Movie Name",
    d.director_id AS "Director ID",
    d.first_name AS "Director First Name",
    d.last_name AS "Director Last Name"
FROM
    movies m
RIGHT JOIN
    directors d
ON d.director_id = m.director_id;

-- 3. Can we add a WHERE clause to filter the results of a RIGHT JOIN? Say list all the movies of English and Chinese movies only with their corresponding directors, and movie names.
SELECT
    m.movie_id AS "Movie ID",
    m.movie_name AS "Movie Name",
    d.director_id AS "Director ID",
    d.first_name AS "Director First Name",
    d.last_name AS "Director Last Name"
FROM
    directors d
RIGHT JOIN
    movies m
ON
    d.director_id = m.director_id
WHERE
    m.movie_lang IN ('English', 'Chinese');

-- 4. Let's count all movies with their corresponding directors, and movie names.
SELECT
    d.director_id AS "Director ID",
    d.first_name AS "Director First Name",
    d.last_name AS "Director Last Name",
    COUNT(m.movie_id) AS "Total Movies"
FROM
    directors d
RIGHT JOIN
    movies m ON m.director_id = d.director_id
GROUP BY
    d.director_id, d.first_name, d.last_name
ORDER BY
    "Total Movies" DESC;

-- 5. Get all the total revenues done by each film for each director where the total revenue is greater than 100. The total revenue is calculated by adding domestic and international revenues.
-- Now the question arises, What is the first table or Left table and what is the second table or Right table in this case?
-- In this case, the "directors" table is the left table, and the "movies" and "movies_revenues" tables are the right tables.
-- The RIGHT JOIN is used to ensure that all directors are included in the result set, even if they do not have any movies or revenue data.

SELECT
    d.director_id AS "Director ID",
    d.first_name AS "Director First Name",
    d.last_name AS "Director Last Name",
    SUM(mr.revenues_domestic + mr.revenues_international) AS "Total Revenue"
FROM
    directors d
RIGHT JOIN
    movies m ON m.director_id = d.director_id
LEFT JOIN
    movies_revenues mr ON mr.movie_id = m.movie_id
GROUP BY
    d.director_id, d.first_name, d.last_name
HAVING SUM(mr.revenues_domestic + mr.revenues_international) > 100
ORDER BY
    "Total Revenue" DESC NULLS LAST;

