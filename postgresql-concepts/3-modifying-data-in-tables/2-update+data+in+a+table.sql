-- UPDATE DATA IN A TABLE
-- ###################################

-- 1. Update a single column in 'customers' table.

-- Syntax:
/*
UPDATE table_name
SET column_name = 'new-value'
WHERE column_name = 'value';
*/

/*
    UPDATE Statement:
    1. It is used to modify existing record(s) in a table.
    2. The UPDATE statement allows you to change the values of one or more columns for specific rows that meet certain conditions.
    3. The SET clause specifies the column to be updated and the new value to be assigned.
    4. The WHERE clause is used to specify which rows should be updated.
    V Imp: If the WHERE clause is omitted, all rows in the table will be updated.

    In Spring Data JPA, the @Modifying annotation is used to indicate that a query method modifies data in the database.
    It is typically used in conjunction with the @Query annotation to define custom update or delete queries.
    When a method is annotated with @Modifying, it tells Spring Data JPA that the query will perform an update or delete operation, rather than a select operation.
    This allows you to execute custom update or delete statements directly from your repository interface.

    e.g., @Modifying is used to update the email of a customer based on their ID.
    @Modifying
    @Query("UPDATE Customer c SET c.email = :email WHERE c.id = :id")
    void updateCustomerEmail(@Param("id") Long id, @Param("email") String email);

    From a system design perspective it is important to consider the implications of using @Modifying in Spring Data JPA.
    1. Transaction Management: When using @Modifying, it is crucial to ensure that the method is executed within a transactional context.
       This can be achieved by annotating the method with @Transactional or by configuring transaction management at the service layer.
       Without proper transaction management, there is a risk of data inconsistencies or partial updates if an exception occurs during the execution of the query.
    2. Performance Considerations: Updating large amounts of data using @Modifying can have performance implications.
       It is important to consider the size of the dataset being updated and the potential impact on database performance.
       In some cases, it may be more efficient to batch updates or use bulk update operations to minimize the number of database round trips.
    3. Data Integrity: When using @Modifying, it is essential to ensure that the update operation maintains data integrity.
       This includes validating input parameters, checking for constraints, and handling any potential conflicts or errors that may arise during the update process.
       It is important to implement appropriate error handling and logging mechanisms to capture any issues that may occur during the execution of the update query.
*/
UPDATE customers
SET email = 'abc@xyz.com'
WHERE customer_id = 1;


-- 2. Update multiple columns in 'customers' table

-- Syntax:
/*
UPDATE table_name
SET
    column_name_1 = 'new-value', column_name_2 = 'new-value'
WHERE column_name = 'value';
*/

/*
    In Spring Data JPA, the @Modifying annotation can also be used to update multiple columns in a table.
    e.g., @Modifying is used to update the email and first name of a customer based on their ID.
    @Modifying
    @Query("UPDATE Customer c SET c.email = :email, c.firstName = :firstName WHERE c.id = :id")
    void updateCustomerEmailAndFirstName(@Param("id") Long id, @Param("email") String email, @Param("firstName") String firstName);
*/
UPDATE customers
SET
    email = 'abc@xyz.com', first_name = 'Nandan'
WHERE customer_id = 1;


-- 3. Use RETURNING to get the updated rows
-- Syntax:
/*
UPDATE table_name
SET
    column_name_1 = 'new-value', column_name_2 = 'new-value'
WHERE column_name = 'value' RETURNING *;
*/

/*
    In Spring Data JPA, the @Modifying annotation can be used in conjunction with the @Query annotation to update multiple columns in a table and return the updated rows.
    e.g., @Modifying is used to update the email and first name of a customer based on their ID and return the updated rows.
    @Modifying
    @Query("UPDATE Customer c SET c.email = :email, c.firstName = :firstName WHERE c.id = :id RETURNING c")
    List<Customer> updateCustomerEmailAndFirstNameAndReturnUpdatedRows(@Param("id") Long id, @Param("email") String email, @Param("firstName") String firstName);
*/

UPDATE customers
SET
    email = 'abc@xyz.com', first_name = 'Nandan'
WHERE customer_id = 1 RETURNING *;


-- UPDATE ALL RECORDS IN A TABLE WITH A VALUE
-- #######################################################
-- 4. Update all records in a table with no WHERE clause.
--    That means if we have to update all the records in a table with a unique value, then we don't have to use WHERE clause.
-- Scenario: Create a new column in customers table as "is_enable"
--           & update all the records with as 'Y' in "is_enable"

-- Syntax:
/*
ALTER TABLE table_name
ADD column_name datatype;
*/

/*
    In Spring Data JPA, the @Modifying annotation can be used in conjunction with the @Query annotation to update all records in a table with a specific value.
    e.g., @Modifying is used to update all customers in the table with a specific value for the "is_enable" column.
    @Modifying
    @Query("UPDATE Customer c SET c.isEnable = :isEnable")
    void updateAllCustomersIsEnable(@Param("isEnable") String isEnable);

    Altering the table structure (adding a new column) is typically done using database migration tools like Flyway or Liquibase in a Spring Boot application, rather than directly through JPA annotations.
*/

ALTER TABLE customers
    ADD is_enable varchar(2);

-- Syntax:
/*
UPDATE table_name
SET
    column_name_1 = 'new-value'
*/

UPDATE customers
SET is_enable = 'Y';

-- or

UPDATE customers
SET is_enable = 'Y' RETURNING *;

-- This statement will run on all the table rows


-- DELETE RECORDS FROM A TABLE
-- ##################################

-- 5. To delete records from a table based on a condition.
-- Syntax:

/*
DELETE FROM table_name
WHERE column_name = 'value';
*/

/*
    In Spring Data JPA, the @Modifying annotation can also be used to delete records from a table based on a condition or to delete all records from a table.
    e.g., @Modifying is used to delete a customer based on their ID.
    @Modifying
    @Query("DELETE FROM Customer c WHERE c.id = :id")
    void deleteCustomerById(@Param("id") Long id);
*/

DELETE FROM customers
WHERE customer_id = 10;


-- 6. To delete ALL records from a table.
-- Syntax:

/*
DELETE FROM table_name;
*/
-- Note: Be extra cautious when executing DELETE FROM table_name; As this action is irrevocable. We can not retrieve the data back unless we have a data backup maintained.

/*
    In Spring Data JPA, the @Modifying annotation can be used to delete all records from a table.
    e.g., @Modifying is used to delete all customers from the table.
    @Modifying
    @Query("DELETE FROM Customer")
    void deleteAllCustomers();
*/

DELETE FROM customers;




