-- 1: Creating a actors table
-- function: CREATE TABLE
CREATE TABLE actors (
	actor_id SERIAL PRIMARY KEY,
	first_name VARCHAR(150),
	last_name VARCHAR(150) NOT NULL,
	gender CHAR(1),
	date_of_birth DATE,
	add_date DATE,
	update_date DATE
);
SELECT * FROM actors;


-- 2: Creating a directors table
-- function: CREATE TABLE
CREATE TABLE directors (
    director_id SERIAL PRIMARY KEY,
    first_name VARCHAR(150),
    last_name VARCHAR(150) NOT NULL,
    date_of_birth DATE,
    nationality VARCHAR(20),
    add_date DATE,
    update_date DATE
);
SELECT * FROM directors;


-- 3: Creating a movies table
-- function: CREATE TABLE
-- Foreign Key inside Movies table that point to => Directors table by director_id (which is a primary key inside directors table)
-- Foreign Key is a way for us to link different tables together for data connectivity and much more.
CREATE TABLE movies (
     movie_id SERIAL PRIMARY KEY,
     movie_name VARCHAR(100) NOT NULL,
     movie_length INT,
     movie_lang VARCHAR(20),
     age_certificate VARCHAR(10),
     release_date DATE,
     director_id INT REFERENCES directors (director_id)
     -- Note: keep the same column name of foreign key as the column name in the parent table.
);
SELECT * FROM movies;


-- 4: Creating a movies_revenues table
CREATE TABLE movies_revenues (
    revenue_id SERIAL PRIMARY KEY,
    movie_id INT REFERENCES movies (movie_id),
    revenues_domestic NUMERIC (10,2),
    revenues_international NUMERIC (10,2)
);
SELECT * FROM movies_revenues;


-- 5: Junction Table
-- 5: Creating a movies_actors table (which is a junction table)
CREATE TABLE movies_actors (
    movie_id INT REFERENCES movies (movie_id),
    actor_id INT REFERENCES actors (actor_id),
    PRIMARY KEY (movie_id, actor_id)
);
SELECT * FROM movies_actors;



-- Notes:

-- Install sample data for movies database
-- #######################################

-- 1. Important: To make sure you follow the sequence of inserting data as per following as we are adding data to tables
--               with foreign key constraints.

-- 2. Download .sql files scripts viz: directors.sql, actors.sql, movies_actors.sql, movies_revenues.sql

-- 3. Import these .sql scripts to insert data into tables.
--    Sequence:
--          1. Insert data of directors.sql
--          2. Insert data of actors.sql
--          3. Insert data of movies.sql
--          4. Insert data of movies_actors.sql
--          3. Insert data of movies_revenues.sql
