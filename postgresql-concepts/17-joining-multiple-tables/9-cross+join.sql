-- CROSS JOIN:
-- ################

/*
    What is Cross Join?
        - A Cross Join is a join that returns the Cartesian product of two tables.
        - It combines each row from the first table with every row from the second table.
        - The result set will contain all possible combinations of rows from both tables.
        - Cross joins are useful when you want to generate permutations or combinations of data.
        - Unlike INNER JOIN, LEFT JOIN and RIGHT JOIN, a Cross Join does not require any join condition (predicate).
        - It simply combines all rows from both tables without any filtering or matching criteria.
        - Reversing the table order in a Cross Join will not change the result set, as it is a commutative operation.
        - The columns may appear in a different order, but the result set will remain the same.
        - Also in Cross Join no need to use ON clause, as there is no join condition.

    Syntax:
        SELECT
            columns
        FROM
            table1
        CROSS JOIN
            table2;

    In a Cross Join query, every row from the first table is combined with every row from the second table, resulting in a larger result set.
    The number of rows in the result set will be equal to the product of the number of rows in both tables.

    Suppose you have two tables: Table A with m rows and Table B with n rows.
    A Cross Join between these two tables will produce a result set with m * n rows, where each row from Table A is combined with each row from Table B.

    e.g: The Table A has 1000 rows and Table B has 1000 rows, then the result set will have 1000 * 1000 = 1,000,000 rows.

    Use Cases of Cross Join:
        - Generating combinations of data: Cross joins can be used to generate all possible combinations of data from two or more tables.
          This can be useful in scenarios where you want to explore different combinations or permutations of data.
        - Creating test data: Cross joins can be used to create test data by combining different sets of values from multiple tables.
          This can help in testing various scenarios and validating the behavior of applications or systems.
        - Analyzing relationships between entities: Cross joins can be used to analyze relationships between entities in different tables.
          By combining all possible pairs of rows, you can gain insights into how different entities relate to each other.
*/

-- 1. Let's create a table called left_products with product_id and product_name columns.
SELECT
    *
FROM
    left_products AS lp
CROSS JOIN
    right_products AS rp;

-- 2. Equivalent query using CROSS JOIN without JOIN clause.
SELECT
    *
FROM
    left_products,
    right_products;
-- Note: In the above query, we are performing a CROSS JOIN between the left_products and right_products tables.
-- The result set will contain all possible combinations of rows from both tables.

-- or

-- We can also do CROSS JOIN using INNER JOIN with ON clause, but it is not recommended as it may lead to confusion and is not the standard way to perform a CROSS JOIN.
SELECT
    *
FROM
    left_products AS lp
INNER JOIN
    right_products AS rp ON TRUE;

-- 3. Let's CROSS JOIN actors with directors table to find all possible combinations of actors and directors.
SELECT
    *
FROM
    actors AS a
CROSS JOIN
    directors AS d;

-- Note: Total 5439 records.
-- SELECT COUNT(*) FROM actors; 147 records
-- SELECT COUNT(*) FROM directors; 37 records


