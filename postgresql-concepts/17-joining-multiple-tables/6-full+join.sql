-- FULL JOIN:
-- #################

/*
    What is Full Join in SQL?
        - A Full Join, also known as a Full Outer Join, is a type of join that returns all records from both tables being joined, regardless of whether there is a match between the two tables.
        - If there is no match, the result will contain NULL values for the columns of the table that does not have a matching record.
        - For example, if we have two tables, "left_products" and "right_products", a Full Join will return all records from both tables, including those that do not have a match in the other table.
        - This allows us to see all products from both tables, even if they are not present in the other table.
        - The syntax for a Full Join is as follows:
            SELECT columns
            FROM table1
            FULL JOIN table2 ON table1.column = table2.column;

    Where to use Full Join in SQL?
        - Full Join is used when you want to retrieve all records from both tables, regardless of whether there is a match between the two tables.
        - It is useful when you want to see all records from both tables, even if they do not have a match in the other table.

    Use cases of Full Join in SQL:
        - Finding Unmatched Records: When you want to retrieve all records from both tables, including those that do not have a match in the other table.
        - Data Analysis: When you want to analyze data from two tables and see all records from both tables, even if there are no matches in the other table.
        - Reporting: When you want to generate reports that include all records from both tables, regardless of whether there are matches in the other table.

    From an Interview Perspective:
        - Full Join is a common topic in SQL interviews, and it is important to understand how it works and when to use it.
        - Interviewers may ask you to explain the difference between Full Join and other types of joins, or to write a query using Full Join to retrieve specific data from two tables.

    For example, an interviewer may ask the following question:
    1. Can you write a SQL query to retrieve all records from the 'left_products' table and the 'right_products' table, even if there are no matches in either table?
    Answer: In this case, you would use a Full Join to retrieve all records from both tables, including those that do not have a match in the other table.
        SELECT lp.*, rp.*
        FROM left_products AS lp
        FULL JOIN right_products AS rp
        ON lp.product_id = rp.product_id;

    2. Can you explain the difference between Full Join and other types of joins in SQL?
    Answer: Full Join returns all records from both tables, regardless of whether there is a match between the two tables.
    Left Join returns all records from the left table and any matching records from the right table.
    while Right Join returns all records from the right table and any matching records from the left table.
    while Inner Join returns only the records that have matching values in both tables.

    3. Can you give an example of when you would use a Full Join in SQL?
    Answer: One example of when you would use a Full Join is when you want to retrieve all records from two tables, even if there are no matches in either table.
    This would allow you to see all products from both tables, even if they are not present in the other table.
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
    (5, 'Mics')
;

-- Insert sample data into right_products
INSERT INTO right_products (product_id, product_name) VALUES
    (1, 'Computers'),
    (2, 'Laptops'),
    (3, 'Monitors'),
    (4, 'Pen'),
    (7, 'Paper')
;

-- Now, let's perform a FULL OUTER JOIN on these two tables to see how it works.
SELECT
    lp.product_id AS left_product_id,
    lp.product_name AS left_product_name,
    rp.product_id AS right_product_id,
    rp.product_name AS right_product_name
FROM
    left_products AS lp
FULL JOIN
    right_products AS rp
ON
    lp.product_id = rp.product_id;


-- 2. Lets perform a FULL OUTER JOIN with a WHERE clause to filter the results and see only the records that do not have a match in movies, directors table.
SELECT
    d.first_name AS "Director First Name",
    d.last_name AS "Director Last Name",
    m.movie_name AS "Movie Name"
FROM
    directors AS d
FULL JOIN
    movies AS m
ON
    d.director_id = m.director_id
ORDER BY
    d.first_name;

-- Note: Reversing the table order in a FULL OUTER JOIN does not change the result set, as it returns all records from both tables regardless of the order.
-- INNER JOIN and FULL OUTER JOIN are symmetric joins, so swapping table order does not change the logical result set.