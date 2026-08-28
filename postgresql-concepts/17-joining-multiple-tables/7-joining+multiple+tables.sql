-- Joining multiple tables via JOIN clause
-- ###########################################

/*
   Joining multiple tables:
       - We can join multiple tables in a single query by using multiple JOIN clauses.
       - Each JOIN clause connects two tables based on a specified condition.
   Syntax:
       SELECT
            table1.column,
            table2.column,
            table3.column,
            ...
       FROM table1
       JOIN table2 ON table1.column = table2.column
       JOIN table3 ON table2.column = table3.column
       ...
*/

-- 1. Let's join movies, directors and movies_revenues tables to get the movie title, director name and revenue.
SELECT
    *
FROM
    movies m
JOIN
    directors d ON d.director_id = m.director_id
JOIN
    movies_revenues mr ON m.movie_id = mr.movie_id;

-- 2. Do the order of the JOIN clauses matter? Let's change the order of the JOIN clauses and see if we get the same result.
SELECT
    *
FROM
    movies m
JOIN
    movies_revenues mr ON m.movie_id = mr.movie_id
JOIN
    directors d ON d.director_id = m.director_id;

-- or
SELECT
    *
FROM
    directors d
JOIN
    movies m ON d.director_id = m.director_id
JOIN
    movies_revenues mr ON m.movie_id = mr.movie_id;

-- Note: The order of the JOIN clauses generally does not matter because the JOINs by default are INNER JOINs.

-- 2. Let's join actors, movies, directors and movies_revenues tables together.
SELECT
    *
FROM
    actors AS a
JOIN
    movies_actors AS ma ON ma.actor_id = a.actor_id
JOIN
    movies AS m ON m.movie_id = ma.movie_id
JOIN
    directors AS d ON d.director_id = m.director_id
JOIN
    movies_revenues AS mr ON mr.movie_id = m.movie_id;
