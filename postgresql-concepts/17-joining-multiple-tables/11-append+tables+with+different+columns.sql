-- APPEND TABLES WITH DIFFERENT COLUMNS:
-- ##################################################

/*
    Append tables with different columns:
    We have two tables, table1 and table2, with different columns.
    table1 has columns: add_date, col1, clo2, col3.
    table2 has columns: add_date, col1, col2, col3, col4, col5.

    Now, we want to combine the data from both the tables into a single result set, even though they have different structures,
    but making sure to take the data from the first table table1.
*/

-- 1. Let's create table1 and table2.
CREATE TABLE table1 (
    add_date DATE,
    col1 INT,
    col2 INT,
    col3 INT
);

CREATE TABLE table2 (
    add_date DATE,
    col1 INT,
    col2 INT,
    col3 INT,
    col4 INT,
    col5 INT
);

-- 2. Let's insert some sample data into table1 and table2.
INSERT INTO table1 (add_date, col1, col2, col3) VALUES
('2024-01-01', 1, 2, 3),
('2024-01-02', 4, 5, 6);

INSERT INTO table2 (add_date, col1, col2, col3, col4, col5) VALUES
('2024-01-01', NULL, 7, 8, 9, 10),
('2024-01-02', 11, 12, 13, 14, 15),
('2024-01-05', 16, 17, 18, 19, 20);

select * from table1;
select * from table2;

-- 3. Now, let's combine the data from both tables with COALESCE function to handle NULL values and ensure that we take the data from the first table (table1) when available.
SELECT
    COALESCE(t1.add_date, t2.add_date) AS add_date,
    COALESCE(t1.col1, t2.col1) AS col1,
    COALESCE(t1.col2, t2.col2) AS col2,
    COALESCE(t1.col3, t2.col3) AS col3,
    t2.col4,
    t2.col5
FROM
    table1 AS t1
FULL OUTER JOIN
    table2 AS t2
ON
    t1.add_date = t2.add_date;


