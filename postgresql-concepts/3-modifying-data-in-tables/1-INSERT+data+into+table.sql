-- INSERT DATA INTO A TABLE
-- ###########################################################

-- 1. Create a test table called 'customers' with CREATE TABLE
-- Syntax: CREATE TABLE table_name ();

-- customer_id, first_name, last_name, email, age
CREATE TABLE IF NOT EXISTS customers (
	customer_id SERIAL PRIMARY KEY,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	email VARCHAR(150),
	age INT
);


-- 2. View the table data with SELECT
-- Syntax:
/*
SELECT * FROM table_name;
*/

SELECT * FROM customers;


-- 3. Insert data into the table.
-- Syntax:
/*
INSERT INTO table_name (column1, column2, ....)
VALUES ('value1', 'value2'.....);
*/

/*
    In Spring Data JPA, we can use the JpaRepository interface to insert a record into the table.
    Using the save() method of the JpaRepository interface, we can insert a record into the table.

    In Hibernate, inserting a record into a table is done using the session.save() method.
    The session.save() method is used to save an object into the database.
    The object must be an instance of a class that is mapped to a table in the database.
    The session.save() method returns the generated identifier for the saved object.

    Using Hibernate, we can use the following sample code to insert a record into the table.
    e.g: Inserting a record into the customers table using Hibernate.
        Customer customer = new Customer();
        customer.setFirstName("Adnan");
        customer.setLastName("Waheed");
        customer.setEmail("Adnan.Waheed@gmail.com");
        customer.setAge(40);
        session.save(customer);
*/

INSERT INTO customers (first_name, last_name, email, age)
VALUES ('Adnan','Waheed','a@b.com',40);


-- INSERT MULTIPLE RECORDS INTO A TABLE
-- ########################################################################
-- 4. Insert multiple data records into the table.
--    We separate data with ',' to insert multiple data records into a table
-- Syntax:
/*
INSERT INTO table_name (column1, column2, ....)
VALUES
('value1', 'value2'.....),
('value3', 'value4'.....),
('value7', 'value6'.....);
*/

/*
    In Spring Data JPA, we can use the JpaRepository interface to insert multiple records into the table.
    Using the saveAll() method of the JpaRepository interface, we can insert multiple records into the table.
    e.g: Inserting multiple records into the customers table using Spring Data JPA
        List<Customer> customers = new ArrayList<>();
        customers.add(new Customer("Adnan", "Samar", "email", 40));
        customers.add(new Customer("Sammy", "Wahran", "email", 50));
        customers.add(new Customer("Bhola", "Ishita", "email", 60));
        customers.add(new Customer("Pandu", "Ranga", "email", 70));
        customerRepository.saveAll(customers);

    In Hibernate, inserting multiple records into a table is done using the session.save() method in a loop.
    The session.save() method is used to save an object into the database.
    The object must be an instance of a class that is mapped to a table in the database
    The session.save() method returns the generated identifier for the saved object.

    From a system design perspective, inserting multiple records into a table can be done using batch processing.
    From a performance perspective, batch processing is more efficient than inserting records one by one.
    It is recommended to use batch processing when inserting multiple records into a table.
    But, sometimes batch processing is not possible due to the nature of the data or the business logic.

    V Imp Note: Callbacks can be used to perform some actions before or after inserting a record into a table.

    e.g: In Spring Data JPA, we can use the @PrePersist and @PostPersist annotations to perform some actions before or after inserting a record into a table.
         In Production, we can use the @PrePersist annotation to set the created_at and updated_at fields before inserting a record into a table.
         Similarly, we can use the @PostPersist annotation to send a notification after inserting a record into a table.
*/

INSERT INTO customers (first_name, last_name, email, age)
VALUES
    ('Adnan', 'Samar', 'a@b.com', 40),
    ('Sammy', 'Wahran', 'c@d.com', 50),
    ('Bhola', 'Ishita', 'e@f.com', 60),
    ('Pandu', 'Ranga', 'g@h.com', 70);


-- INSERT A DATA WITH QUOTES
-- #######################################################################
/* 5.
   Insert a data with quotes into a table
   e.g: How to add say first_name as "Bill'O Sullivan" in customers table.
   In such cases wrap the quote (') with an additional quote (')
*/

INSERT INTO customers (first_name, last_name, email, age)
VALUES
    ('Bill''O', 'Sullivan', 'x@y.com', 80);


-- USE "RETURNING" TO GET INFO ON RETURNED ROWS
-- ########################################################################
/* 6.
   Observe the default behavior when adding a record into a table.
   After inserting a record / records, let's return all newly inserted rows.
   After inserting a record / records, let's return a single column value.
*/

/*
    Observe the default behavior when adding a record into a table:
    The default behavior of the INSERT statement is to return the number of rows inserted into the table.
*/
INSERT INTO customers (first_name, last_name, email, age)
VALUES
    ('Bill', 'Sullivan', 'x@y.com', 90);

/*
    After inserting a record / records, let's return selected columns or all columns of the newly inserted rows:

    The RETURNING clause can be used to return all the columns of the newly inserted rows.
    Note: The RETURNING clause can be used with the INSERT, UPDATE, and DELETE statements as well.

    In Spring Data JPA, we can use the save() method of JpaRepository interface to return all the columns of the newly inserted rows.
    e.g: Inserting a record into the customers table using Spring Data JPA and returning all the columns of the newly inserted rows.
        Customer customer = new Customer();
        customer.setFirstName("Adam");
        customer.setLastName("Muller");
        customer.setEmail(" ");
        customer.setAge(10);
        Customer savedCustomer = customerRepository.save(customer);

*/
INSERT INTO customers (first_name, last_name, email, age)
VALUES
    ('Adam', 'Muller', 'x@y.com', 10) RETURNING *;

/*
    After inserting a record / records, let's return selected columns of the newly inserted rows:

    The RETURNING clause can be used to return the specified columns of the newly inserted rows.
    Note: The RETURNING clause can be used with the INSERT, UPDATE, and DELETE statements as well.

    In Spring Data JPA, we cannot use the save() method of JpaRepository interface to return the specified columns of the newly inserted rows.
    As save() method of JpaRepository interface returns the entire entity object after saving it into the database.

    A few details about save() method.
        - It is not a projection query.
        - JPA already has the entity state in memory, so it does not need to fetch only selected columns from the database after saving the entity.
*/

INSERT INTO customers (first_name, last_name, email, age)
VALUES
    ('Jake', 'Muller', 'x@y.com', 10) RETURNING customer_id, first_name;