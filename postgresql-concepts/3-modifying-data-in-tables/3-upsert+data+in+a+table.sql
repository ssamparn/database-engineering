-- UPSERT DATA IN A TABLE
-- ###################################

/*
    Upsert:
        - It is a combination of two words, UPDATE & INSERT.
        - The idea is that when you insert a new row into the table, PostgreSQL will update the row if it already exists.
          Otherwise, it will insert the new row.
        - That is why, we call the action UPSERT (the combination of UPDATE & INSERT).

        Syntax:
            INSERT INTO table_name (column_1, column_2, column_3, ...)
            VALUES (value_1, value_2, value_3, ...)
            ON CONFLICT (conflict_target)
            action;

        conflict_target:
            - It is the column or constraint that you want to check for conflicts.
            - If a conflict occurs, PostgreSQL will perform the action specified after ON CONFLICT.

        For 'action' after ON CONFLICT, we have a few options.
            a) DO NOTHING: Which means do nothing if the row already exists in the table.
            b) DO UPDATE SET column_1 = value_1 WHERE condition: Update some fields in the table.

    4. This is similar to INSERT INTO....IF NOT EXISTS functionality, but it is more powerful because it allows you to specify what to do if the row already exists in the table.

*/

/*
    In Spring Data JPA, we can use the save() method to perform an upsert operation.
    If the entity already exists in the database, it will be updated; otherwise, a new entity will be inserted.

    How does Spring Data JPA know whether to perform an insert or an update?
    Spring Data JPA determines whether to perform an insert or an update based on the presence of the entity's identifier (primary key) in the database.
    If the entity has a non-null identifier, and it exists in the database, Spring Data JPA will perform an update.
    If the entity has a null identifier, or it does not exist in the database, Spring Data JPA will perform an insert operation.

    How does Spring Data JPA handle the upsert operation internally?
        - Internally, Spring Data JPA uses the EntityManager to manage the persistence of entities.
        - When you call the save() method, Spring Data JPA checks if the entity's identifier is null or if it exists in the database.
        - If the identifier is null, it will perform an insert operation. If the identifier is not null and exists in the database, it will perform an update operation.
        - The EntityManager handles the necessary SQL statements to perform the insert or update operation based on the entity's state.

    How does Spring Data JPA handle concurrency and conflicts during upsert operations?
        - Spring Data JPA provides mechanisms to handle concurrency and conflicts during upsert operations.
        - It uses optimistic locking by default, which means that it checks the version of the entity before performing an update.
        - If the version has changed since the entity was last read, it will throw an OptimisticLockException, indicating a conflict.
        - You can also use pessimistic locking to lock the entity during the upsert operation, preventing other transactions from modifying it until the current transaction is complete.

    How does Spring Data JPA handle upsert operations with composite keys or unique constraints?
        - Spring Data JPA can handle upsert operations with composite keys or unique constraints by using the @IdClass or @EmbeddedId annotations to define the composite key.
        - When performing an upsert operation, Spring Data JPA will check if the entity with the specified composite key exists in the database.
        - If it exists, it will perform an update; otherwise, it will perform an insert operation.
        - You can also use the @UniqueConstraint annotation to define unique constraints on specific columns, and Spring Data JPA will enforce those constraints during upsert operations.

    How does Spring Data JPA handle upsert operations with relationships between entities?
        - Spring Data JPA can handle upsert operations with relationships between entities by using the appropriate annotations, such as @OneToOne, @OneToMany, @ManyToOne, and @ManyToMany.
        - When performing an upsert operation on an entity with relationships, Spring Data JPA will check if the related entities exist in the database.
        - If they exist, it will perform an update; otherwise, it will perform an insert operation.
        - You can also use cascading options to specify how related entities should be persisted during upsert operations.

    How does Spring Data JPA handle upsert operations with custom queries or native SQL?
        - Spring Data JPA allows you to define custom queries using the @Query annotation or by using native SQL queries.
        - When performing an upsert operation with custom queries, you can use the appropriate SQL syntax to handle the insert or update logic based on your requirements.
        - You can also use the @Modifying annotation to indicate that the query is modifying data, and Spring Data JPA will handle the necessary transaction management for the upsert operation.

*/

-- create sample table
CREATE TABLE t_tags(
    id serial PRIMARY KEY,
    tag text UNIQUE,
    update_date TIMESTAMP DEFAULT NOW()
)

-- insert some sample data
INSERT INTO t_tags (tag) VALUES
    ('Pen'),
    ('Pencil'),
    ('Sharpner'),
    ('Scale');

-- Let's view the data
SELECT * FROM t_tags;

/*
    Option 1. DO NOTHING:
    Let's insert a record, ON CONFLICT do nothing.
    Syntax: INSERT INTO table_name (list_of_columns)
            VALUES (list_of_values)
            ON CONFLICT (conflict_target)
            action;

    If a conflicting row already exists, PostgreSQL skips the insert operation and does not raise an error.
    e.g:
        INSERT INTO customer (id, first_name, last_name)
        VALUES (1, 'Jake', 'Muller')
        ON CONFLICT (id)
        DO NOTHING;

    If id = 1 already exists:
        - No insert will be performed
        - No update will be performed
        - No error will be raised

    This is useful when duplicates can be safely ignored.
*/

INSERT INTO t_tags (tag)
    VALUES ('Pen')
ON CONFLICT (tag)
DO
    NOTHING;

/*
    Option 2. DO UPDATE:
    Let's insert a record, on conflict set new rules.
    Syntax: INSERT INTO table_name (column_1, column_2, column_3, ...)
            VALUES (value_1, value_2, value_3, ...)
            ON CONFLICT (conflict_target)
            action;

    If a conflicting row exists, update it instead.
    e.g:
        INSERT INTO customer (id, first_name, last_name)
        VALUES (1, 'Jake', 'Muller')
        ON CONFLICT (id)
        DO UPDATE
        SET first_name = 'Jake', last_name = 'Muller';

    Equivalent business logic:
        IF CUSTOMER EXISTS
            UPDATE customer SET first_name = 'Jake', last_name = 'Muller' WHERE id = 1;
        ELSE
            INSERT INTO customer (id, first_name, last_name) VALUES (1, 'Jake', 'Muller');
*/
-- Update the timestamp where tag = 'Pen'

INSERT INTO t_tags (tag)
    VALUES ('Pen')
ON CONFLICT (tag)
DO
    UPDATE SET
        tag = EXCLUDED.tag,
        update_date = NOW();

-- The time stamp will get updated here, where the tag is 'Pen'.

/*
    Option 3. Another example. Let's insert a record, on conflict set new rules.
    Syntax: INSERT INTO table_name (column_1, column_2, column_3, ...)
            VALUES (value_1, value_2, value_3, ...)
            ON CONFLICT (conflict_target)
            action;

    Using the EXCLUDED keyword, we can reference the values that were proposed for insertion but conflicted with existing data.
    Basically EXCLUDED refers to the row that PostgreSQL attempted to insert.
    e.g:
        INSERT INTO customer (id, first_name, last_name)
        VALUES (1, 'Jake', 'Muller')
        ON CONFLICT (id)
        DO UPDATE
        SET first_name = EXCLUDED.first_name,
            last_name = EXCLUDED.last_name;
*/
-- Concatenate 'cutter' as to sharpner & update the timestamp

INSERT INTO t_tags (tag)
VALUES ('Sharpner')
    ON CONFLICT (tag)
DO
UPDATE SET
    tag = EXCLUDED.tag || 'cutter',
    update_date = NOW();


/*
    Option 4: Conditional Update.
    Example:
    Let's insert a record, on conflict set new rules.
    Syntax: INSERT INTO table_name (column_1, column_2, column_3, ...)
            VALUES (value_1, value_2, value_3, ...)
            ON CONFLICT (conflict_target)
            action;

    You can update only when a condition is satisfied.
    e.g:
        INSERT INTO customer (id, age)
        VALUES (1, 20)
        ON CONFLICT (id)
        DO UPDATE
        SET age = EXCLUDED.age
        WHERE customer.age < EXCLUDED.age;

    Equivalent business logic: Update age only if the new age is greater.
*/

/*
    When discussing ON CONFLICT, emphasize that it:
        1. Prevents race conditions between separate SELECT and INSERT statements.
        2. Makes insert-or-update operations atomic.
        3. Reduces application-side logic.
        4. Improves concurrency in high-write systems.

    From an application design perspective, it is better to use UPSERT rather than first checking for existence and then deciding to insert or update.
    This is because it simplifies the code, reduces the number of database round trips, and avoids potential race conditions that can occur when multiple clients are trying to insert or update the same record simultaneously.
    By using UPSERT, you can ensure that the operation is atomic and that the database handles the conflict resolution for you.
    Instead of first checking whether a record exists and then deciding to insert or update, use PostgreSQL's UPSERT feature (INSERT ... ON CONFLICT).
    This makes the operation atomic, avoids race conditions, simplifies application code, and performs better under concurrent workloads.
    Depending on the business requirement, choose either DO NOTHING to ignore duplicates or DO UPDATE to merge new data into the existing row.

    Spring Data JPA does not have a built-in UPSERT method or Postgres equivalent of INSERT ... ON CONFLICT.
    However, you can achieve similar functionality using the save() method, which performs an upsert operation based on the entity's identifier (primary key).

    The behavior depends on how you use save().

    1. What save() Does?
    Under the hood:
        - If the entity's ID is null, JPA treats it as a new entity and executes an INSERT.
        - If the entity's ID exists, JPA usually performs an UPDATE (or merge).

    2. Common JPA Approach:
        - Check if the entity exists using findById() or existsById().
        - If it exists, update it; otherwise, insert it.

        e.g:
            Optional<Customer> existing = repository.findByEmail(email);
            if (existing.isPresent()) {
                Customer customer = existing.get();
                customer.setFirstName("Jake");
                repository.save(customer);
            } else {
                repository.save(newCustomer);
            }

        Problem with this approach is:
        - This approach is not atomic, as it involves two separate database operations (check existence and then insert/update).
        - This approach can lead to race conditions in concurrent environments.

        As 2 threads can execute:
            Thread A -> findByEmail() -> not found
            Thread B -> findByEmail() -> not found
            Thread A -> insert
            Thread B -> insert -> FAIL

    So the option is to use save() directly, which will handle the insert or update based on the entity's identifier.
    But Spring Data JPA's save() is not a true database UPSERT operation, as it does not use the database's native INSERT ... ON CONFLICT feature.
    It decides between insert and update primarily based on the entity's primary key state.
    For UPSERT semantics on unique business keys such as email (which is unique but not a primary key), I would prefer the database-native feature like PostgreSQL's INSERT ... ON CONFLICT, exposed through a native query.

    So the best options is to use a native query with INSERT ... ON CONFLICT in a @Query annotation to perform an upsert operation directly in the database.

    e.g:
        @Modifying
        @Transactional
        @Query(value = """
                INSERT INTO customer(id, email, first_name)
                VALUES (:id, :email, :firstName)
                ON CONFLICT (email)
                DO UPDATE
                SET first_name = EXCLUDED.first_name
                """, nativeQuery = true)
        void upsertCustomer(Long id, String email, String firstName);
*/

