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


-- 1: Creating an actors table
-- function: CREATE TABLE

/*
    In Hibernate, we can create a table using the @Entity annotation.
    The @Entity annotation is used to mark a class as an entity.
    An entity is a lightweight persistent domain object.
    An entity represents a table in a relational database and each entity instance corresponds to a row in that table.

    From a system design perspective, an entity is used to represent a table in a relational database.

    From an interview perspective, you may be asked to explain the difference between an entity and a table.
        - An entity is a lightweight persistent domain object, while a table is a collection of data organized in rows and columns.
        - An entity is a Java class, while a table is a database object.
        - An entity is used to represent a table in a relational database, while a table is used to store data in a relational database.
*/
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


-- 3: Creating a movies table. Movies table will have a foreign key that will point to the directors table by director_id (which is a primary key inside directors table)
-- function: CREATE TABLE
/*
    What is a Foreign Key?
    1. Foreign Key is a way for us to link different tables together for data connectivity and much more.
    2. A foreign key is a column or a set of columns in one table that refers to the primary key in another table.
    3. The table with the foreign key is called the child table, and the table with the primary key is called the parent table.

    Usage of Foreign Key:
        - In system design, foreign keys are used to establish and enforce referential integrity between tables. In other words, only values that are supposed to appear in the database are permitted.
        - It is a way to enforce a link between the data in the two tables.
        - The foreign key in the child table will reference the primary key of the parent table.
        - It is used to prevent actions that would destroy links between tables.
        - It also prevents invalid data from being inserted into the foreign key column, because it has to be one of the values contained in the table it points to.
        - It is a constraint used to establish and enforce one-to-one or one-to-many relationships between tables.
        - It is also used to establish many-to-many relationships between tables by using a junction table.
        - In the interview, you may be asked to explain the difference between a primary key and a foreign key.
            - A primary key is a unique identifier for a record in a table, while a foreign key is a reference to a primary key in another table.
            - A primary key cannot have duplicate values, while a foreign key can have duplicate values.
            - A primary key cannot be null, while a foreign key can be null.
            - A primary key is used to identify a record in a table, while a foreign key is used to establish a relationship between two tables.

    How to create a Foreign Key?
        1. To create a foreign key, we need to use REFERENCES keyword and then specify the foreign table name and the column name of the primary key in the foreign table.
        2. Note: It is advisable to keep the same column name of foreign key as the column name in the parent table.

    How Hibernate handles Foreign Key?
        1. Hibernate will create a foreign key automatically if we have a one-to-many or many-to-one relationship between two entities.
        2. Hibernate will create a foreign key with the name of the child table and the name of the primary key in the parent table. In this case, the foreign key will be named movies_director_id_fkey.
        3. Hibernate will create a foreign key constraint that will enforce referential integrity between the two tables.
*/
CREATE TABLE movies (
     movie_id SERIAL PRIMARY KEY,
     movie_name VARCHAR(100) NOT NULL,
     movie_length INT,
     movie_lang VARCHAR(20),
     age_certificate VARCHAR(10),
     release_date DATE,
     director_id INT REFERENCES directors (director_id)
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
/*
    What is a Junction Table?
    1. A Junction table is a table that is used to create a many-to-many relationship between two tables. In this case, we are creating a junction table between movies and actors.
       e.g: A movie can have many actors and an actor can be in many movies. So, we need a junction table to create this many-to-many relationship.
    2. The junction table will have two foreign keys. In this case here, one for movies and one for actors.
    3. The junction table will also have a primary key that is a combination of the two foreign keys. This will ensure that there are no duplicate entries in the junction table.

    Where to use a Junction Table?
    1. A junction table is used when we have a many-to-many relationship between two tables.
    In this case, we have a many-to-many relationship between movies and actors.

    2. A junction table is used to break down the many-to-many relationship into two one-to-many relationships.
    In this case, we have a one-to-many relationship between movies and movies_actors and a one-to-many relationship between actors and movies_actors.

    3. A junction table is used to store the relationship between the two tables.
    In this case, we are storing the relationship between movies and actors in the movies_actors table.

    4. From a system design perspective, a junction table is used to normalize the database and to avoid data redundancy.

    5. A junction table is used to enforce referential integrity between the two tables.
    In this case, we are enforcing referential integrity between movies and actors.

    6. From a database design perspective, a junction table is used to create a many-to-many relationship between two tables.
    Also, a junction table is used to create a composite primary key that is a combination of the two foreign keys. This will ensure that there are no duplicate entries in the junction table.

    7. From an interview perspective, you may be asked to explain the difference between a junction table and a foreign key.
        - A junction table is a table that is used to create a many-to-many relationship between two tables, while a foreign key is a column that is used to create a relationship between two tables.
        - A junction table will have a composite primary key that is a combination of the two foreign keys.
        - A junction table is used to normalize the database and to avoid data redundancy, while a foreign key is used to enforce referential integrity between two tables.

    How Hibernate handles Junction Table?
    1. Hibernate will create a junction table automatically if we have a many-to-many relationship between two entities.
    2. Hibernate will create a junction table with the name of the two entities in alphabetical order. In this case, the junction table will be named actors_movies.
    3. Hibernate will create a composite primary key that is a combination of the two foreign keys. This will ensure that there are no duplicate entries in the junction table.

*/
CREATE TABLE movies_actors (
    movie_id INT REFERENCES movies (movie_id),
    actor_id INT REFERENCES actors (actor_id),
    PRIMARY KEY (movie_id, actor_id)
);
SELECT * FROM movies_actors;
