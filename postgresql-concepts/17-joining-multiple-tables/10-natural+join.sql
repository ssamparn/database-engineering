-- NATURAL JOIN:
-- ####################

/*
    What is NATURAL JOIN in SQL?
        - A NATURAL JOIN is a type of join that creates an IMPLICIT join based on the SAME COLUMN NAMES in the joined tables.
        - It eliminates the need to explicitly specify the join condition using the ON clause.
        - The result set will include only one column for each pair of matching columns, avoiding duplicate columns in the output.
        - NATURAL JOIN is based on the principle of matching columns with the same name and compatible data types.
        - It simplifies the query syntax and can be useful when working with tables that have a clear relationship based on common column names.
        - A NATURAL JOIN can be an INNER JOIN, LEFT JOIN, or RIGHT JOIN, depending on the context and the presence of matching rows in the joined tables.
        - If you don't specify the type of join, PostgreSQL defaults to an INNER JOIN.

    Syntax:
        SELECT
            columns
        FROM
            table1
        NATURAL [INNER, LEFT, RIGHT] JOIN
            table2;
*/

-- 1. Let's natural join left_products and right_products tables.
SELECT
    *
FROM
    left_products AS lp
NATURAL JOIN
    right_products AS rp;

-- Note: In the above query, we are performing a NATURAL JOIN between the left_products and right_products tables.
-- The result set will include only one column for each pair of matching columns, avoiding duplicate columns in the output.
-- Notice that we did not specify either INNER, LEFT or RIGHT JOIN here, so PostgreSQL defaults to an INNER JOIN.

-- 2. Let's natural join movies and directors tables.
SELECT
    *
FROM
    movies AS m
NATURAL JOIN
    directors AS d;

-- Note: Here the common / same column is director_id, so the result set will include only one column for director_id, avoiding duplicate columns in the output.

/*
    For Interviews:
    When should you use NATURAL JOIN?
    NATURAL JOIN can be useful for quick queries, data exploration, and educational purposes when tables share consistently named columns.
    However, it is generally avoided in production applications because the join conditions are implicit, making queries harder to read and more vulnerable to schema changes.
    Most enterprise applications, including those using Hibernate and Spring Data JPA, prefer explicit JOIN clauses with clearly defined ON conditions.

    Interview One-Liner:
    NATURAL JOIN is convenient but not recommended for enterprise applications because it relies on implicit column matching and can produce unexpected results when the schema changes.
*/