-- How to INNER JOIN multiple tables with different datatype columns in PostgreSQL
-- In this example, we will join three tables: customers, orders, and products.
-- First, let's create the tables and insert some sample data.

-- 1. Let's create a table with INT datatype column
CREATE TABLE IntegerTable (
    id SERIAL,
    name VARCHAR(50) NOT NULL
);

-- 2. Let's create a table with VARCHAR datatype column
CREATE TABLE varcharTable (
    id VARCHAR(10),
    description VARCHAR(100) NOT NULL
);

-- 3. Now let's insert some sample data into both tables
INSERT INTO IntegerTable (name)
VALUES ('Alice'),
       ('Bob'),
       ('Charlie');

INSERT INTO varcharTable (id, description)
VALUES ('1', 'Description for Alice'),
       ('2', 'Description for Bob'),
       ('3', 'Description for Charlie');
SELECT * FROM IntegerTable;
SELECT * FROM varcharTable;

-- 4. Now can we join these two tables using INNER JOIN?
-- Yes, we can join them using a common column. However, since the data types are different, we need to cast one of the columns to match the other.
SELECT
    it.id AS int_id,
    it.name AS int_name,
    vt.id AS varchar_id,
    vt.description AS varchar_description
FROM
    IntegerTable AS it
INNER JOIN
    varcharTable AS vt
ON
    it.id::VARCHAR = vt.id;

-- or we can cast the VARCHAR column to INT if the values are numeric and can be converted to INT.
SELECT
    it.id AS int_id,
    it.name AS int_name,
    vt.id AS varchar_id,
    vt.description AS varchar_description
FROM
    IntegerTable AS it
INNER JOIN
    varcharTable AS vt
ON
    it.id = vt.id::INT;

-- or we can use CAST function to convert the VARCHAR column to INT
SELECT
    it.id AS int_id,
    it.name AS int_name,
    vt.id AS varchar_id,
    vt.description AS varchar_description
FROM
    IntegerTable AS it
INNER JOIN
    varcharTable AS vt
ON
    it.id = CAST(vt.id AS INT);