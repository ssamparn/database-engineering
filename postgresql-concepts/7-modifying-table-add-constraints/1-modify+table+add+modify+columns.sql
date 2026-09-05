-- CREATE a SAMPLE DATABASE and TABLES with DATA
-- ########################################################################

-- 1. Create a new database called 'mydata' with CREATE DATABASE
-- Syntax: CREATE DATABASE database_name;
DROP ROLE
    IF
EXISTS
    sashank;

CREATE ROLE sashank
WITH
    LOGIN
    SUPERUSER
    INHERIT
    CREATEDB
    CREATEROLE
    REPLICATION
    ENCRYPTED PASSWORD 'SCRAM-SHA-256$4096:fYOSq+ETNva/5fZA0IZdWg==$S+pTvjt2RlsvKL9Oyu4/JtmeCr9kMYna/vJlF3qKo/s=:sJ1XIwU559BGDg/xVsUiRMNAYpbEB4sIDADzi/NSOE0=';

CREATE DATABASE "mydata"
WITH
    OWNER = sashank
    ENCODING = 'UTF8'
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

-- 2. Create a new table called 'person' with CREATE TABLE
CREATE TABLE person (
    person_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    age INT NOT NULL
);

-- 3. Insert sample data into the 'person' table.
INSERT INTO person (first_name, last_name, email, age)
VALUES
    ('John', 'Doe', 'john.dow@gmail.com', '30'),
    ('Jane', 'Smith', 'jane.smith@hotmail.com', '25'),
    ('Alice', 'Johnson', 'alice.johnson@yahoo.co.in', '28'),
    ('Bob', 'Brown', 'bob.brown@live.cm', '35');


SELECT * FROM person;

-- MODIFY TABLE TO ADD COLUMNS
-- ########################################
/*
    We can use the ALTER TABLE statement to add new columns to an existing table.
    Syntax:
    ALTER TABLE table_name
    ADD COLUMN column_name datatype;

    In ADD COLUMN, COLUMN is optional. We can also write the above query as:
    ALTER TABLE table_name
    ADD column_name datatype;
*/
-- Let's add a new column called "phone_number" to the "person" table.
ALTER TABLE person
ADD COLUMN phone_number VARCHAR(15);

-- Note: The new column will be added to the end of the table, and it will be NULL for all existing records.

-- Let's add a new column called "nationality" to the "person" table.
ALTER TABLE person
ADD COLUMN nationality VARCHAR(50) DEFAULT 'Indian';


-- Modify Table Structure
-- ########################################

-- Rename a Table
-- Syntax:
/*
ALTER TABLE old_table_name
RENAME TO new_table_name;
*/
-- Let's rename the "person" table to "individual".
ALTER TABLE person
RENAME TO individual;

-- Rename a Column
-- Syntax:
/*
ALTER TABLE table_name
RENAME COLUMN old_column_name TO new_column_name;
*/
-- Let's rename the "phone_number" column to "contact_number".
ALTER TABLE individual
RENAME COLUMN phone_number TO contact_number;

-- Drop a Column
-- Syntax:
/*
ALTER TABLE table_name
DROP COLUMN column_name;
*/
-- Let's drop the "nationality" column from the "individual" table.
ALTER TABLE individual
DROP COLUMN nationality;

-- Change the Data Type of a Column
-- Syntax:
/*
ALTER TABLE table_name
ALTER COLUMN column_name TYPE new_data_type;
*/
-- Let's change the data type of the "age" column from INT to SMALLINT.
ALTER TABLE individual
ALTER COLUMN age TYPE SMALLINT;


-- Let's change the data type of age from SMALLINT to VARCHAR(3) to store age as a string.
ALTER TABLE individual
ALTER COLUMN age TYPE VARCHAR(20);


-- Now let's change the data type of age from VARCHAR(20) to INT.
ALTER TABLE individual
ALTER COLUMN age TYPE INT;
-- Note: This will fail with error: column "age" cannot be cast automatically to type integer.
-- ERROR:  column "age" cannot be cast automatically to type integer
-- HINT:  You might need to specify "USING age::integer".

-- We will use the USING clause to convert the existing values to INT.
ALTER TABLE individual
ALTER COLUMN age TYPE INT
USING age::INT;


-- Set a Default Value for a Column
-- Syntax:
/*
ALTER TABLE table_name
ALTER COLUMN column_name SET DEFAULT default_value;
*/
-- Let's set a default value of 'Y' for a new column in the "individual" table.
ALTER TABLE individual
ADD COLUMN is_enable VARCHAR(2);

ALTER TABLE individual
ALTER COLUMN is_enable SET DEFAULT 'Y';

-- To see if the value is set to default, we will insert a new record into the "individual" table without specifying a value for the "is_enable" column.
INSERT INTO individual (first_name, last_name, email, age)
VALUES ('Test', 'User', 'test.user@gmail.com', 20);