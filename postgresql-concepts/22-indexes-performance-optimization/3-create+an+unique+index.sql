-- CREATE AN UNIQUE INDEX
-- ###############################

-- PRIMARY KEY & INDEXES
-- ===============================
/*
    1. Normally the primary key is created automatically as a unique index.
    2. If you define a UNIQUE index for two or more columns, the database will ensure that the combination of values in those columns is unique across all rows in the table.
*/

-- Let's create a UNIQUE index on products table on product_id
CREATE UNIQUE INDEX idx_u_products_product_id
ON products (product_id);

-- How about creating a UNIQUE index on multiple columns?
-- orders > order_id, customer_id
CREATE UNIQUE INDEX idx_u_orders_order_id_customer_id
ON orders (order_id, customer_id);

-- Let's create another UNIQUE index on employees table on employee_id and hire_date
-- employees > employee_id, hire_date
CREATE UNIQUE INDEX idx_u_employees_employee_id_hire_date
ON employees (employee_id, hire_date);

-- Why create a UNIQUE index altogether?
-- The purpose of a UNIQUE index is to enforce data integrity by preventing duplicate values in the indexed columns.
-- This is particularly useful for columns that should have unique values, such as primary keys, email addresses, or any other field where duplicates are not allowed.
-- By creating a UNIQUE index, you ensure that the database will reject any attempt to insert or update a row that would result in duplicate values in the indexed columns.

-- To see this in action, let's try create a table with a UNIQUE index and then attempt to insert duplicate values into the indexed columns.
-- Let's create a table called "unique_test" with a UNIQUE index on the "unique_column"
CREATE TABLE unique_test (
    id SERIAL PRIMARY KEY,
    unique_column VARCHAR(50)
);

-- Now, let's create a UNIQUE index on the "unique_column" of the "unique_test" table
CREATE UNIQUE INDEX idx_u_unique_test_unique_column
ON unique_test (unique_column);

-- Now, let's try to insert some values into the "unique_test" table
INSERT INTO unique_test (unique_column) VALUES ('value1');
INSERT INTO unique_test (unique_column) VALUES ('value2');

-- Now, let's try to insert a duplicate value into the "unique_test" table
-- This should fail because of the UNIQUE constraint on the "unique_column"
INSERT INTO unique_test (unique_column) VALUES ('value1');  -- This will fail with a unique constraint violation error