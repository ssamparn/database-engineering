-- ADD CONSTRAINTS TO COLUMNS
-- ##############################

/*
    SQL Constraints:
        - SQL Constraints are rules enforced on data columns on a table.
        - These are used to limit the type of data that can go into a table.
        - This ensures the accuracy and reliability of the data in the database.

    There are different types of constraints in SQL:
        - UNIQUE
        - NOT NULL
        - PRIMARY KEY
        - FOREIGN KEY
        - CHECK
        - DEFAULT

    Adding Constraints to Columns:
    - Constraints can be added to existing columns in a table using the ALTER TABLE statement.
    - The syntax for adding constraints to columns is as follows:
        ALTER TABLE table_name
        ADD CONSTRAINT constraint_name constraint_type (column1, column2, ...);
*/

-- 1. Let's create a table named "web_links" with some columns.
CREATE TABLE web_links (
    link_id SERIAL PRIMARY KEY,
    link_url VARCHAR(255) NOT NULL,
    link_target VARCHAR(20)
);

-- 2. Let's insert some sample data into the "web_links" table.
INSERT INTO web_links (link_url, link_target) VALUES
('https://www.example.com', '_blank'),
('https://www.google.com', '_self'),
('https://www.github.com', '_blank');

-- 3. Fetch the data from the "web_links" table to see the inserted records.
SELECT * FROM web_links;

-- 4. Now, let's add a UNIQUE constraint to the "link_url" column to ensure that no duplicate URLs can be inserted into the table.
ALTER TABLE web_links
ADD CONSTRAINT unique_link_url UNIQUE (link_url);

-- 5. To set a column to accept only defined allowed / accepted values, we can use the CHECK constraint.
-- Let's add a new column called is_enabled to the "web_links" table and add a CHECK constraint to ensure that it can only accept the values 'Y' or 'N'.
ALTER TABLE web_links
ADD COLUMN is_enabled CHAR(1) DEFAULT 'Y';

ALTER TABLE web_links
ADD CONSTRAINT check_is_enabled CHECK (is_enabled IN ('Y', 'N'));

-- Let's try to insert a record with an invalid value for the is_enabled column to see if the CHECK constraint works.
-- This should fail because 'X' is not an allowed value.
INSERT INTO web_links (link_url, link_target, is_enabled) VALUES
('https://www.invalid.com', '_blank', 'X'); -- This will fail due to the CHECK constraint.
