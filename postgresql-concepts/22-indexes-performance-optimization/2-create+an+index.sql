-- CREATE AN INDEX
-- ###########################

/*
    1. Creating an index on a table column or columns.
    Generally you create an index on a column that is frequently used in WHERE clauses, JOIN conditions, or ORDER BY clauses.
    You can also create an index on multiple columns (composite index) if you often query based on those columns together.

    2. Then why not create indexes on all columns?
    While indexes can significantly speed up read operations, they come with trade-offs:
    - Write Performance: Every time you insert, update, or delete a row, the database must also update the indexes. This can slow down write operations.
    - Storage Space: Indexes consume additional disk space. If you create too many indexes, it can lead to increased storage requirements.
    - Maintenance Overhead: Indexes need to be maintained, which can add complexity to database management.
    - Query Planning: The database query planner has to consider all available indexes when determining the best execution plan. Having too many indexes can lead to suboptimal query plans.

    So, PostgreSQL supports creating indexes with up to 32 columns in a single index, but it's essential to carefully consider which columns to index based on your application's query patterns and performance requirements.

    3. There are 2 main basic index types in PostgreSQL:

        INDEX: Creates an index on only values in a column or combination of columns.

        Syntax:
            CREATE INDEX index_name
            ON table_name (column1, column2, ...);

        UNIQUE INDEX: Creates an index on only UNIQUE values in a column or combination of columns.

        Syntax:
            CREATE UNIQUE INDEX index_name
            ON table_name (column1, column2, ...);

        Complete syntax to create an index is the following:
            CREATE [ UNIQUE ] INDEX [ CONCURRENTLY ] [ [ IF NOT EXISTS ] name ] ON table_name [ USING method ]
            ( { column_name | ( expression ) } [ COLLATE collation ] [ opclass ] [ ASC | DESC ] [ NULLS { FIRST | LAST } ] [, ...] )
            [ INCLUDE ( column_name [, ...] ) ]
            [ WITH ( storage_parameter = value [, ... ] ) ]
            [ TABLESPACE tablespace_name ]
            [ WHERE predicate ]

    4. Try to keep names of indexes meaningful and descriptive, so that you can easily identify their purpose when reviewing the database schema or query plans.
    Also try to follow a consistent naming convention for indexes across your database schema. For example, you might use a prefix like "idx_" followed by the table name and column names, such as "idx_users_email" for an index on the "email" column of the "users" table.

    INDEX:
        CREATE INDEX idx_users_email
        ON users (email);

    UNIQUE INDEX:
        CREATE UNIQUE INDEX idx_unique_users_email
        ON users (email);
*/

-- 1. Let's create an index on order_date on orders table to speed up queries that filter by order_date.
CREATE INDEX idx_orders_order_date
ON orders (order_date);

-- Note: If you see the properties of the index, you can see that it is a B-tree index by default.

-- 2. Let's create an index on the combination of customer_id and order_date on orders table to speed up queries that filter by both customer_id and order_date.
CREATE INDEX idx_orders_customer_id_order_date
ON orders (customer_id, order_date);

-- Note: It is important to note that, when creating a composite (multi-column) index, you should always place the most selective column first.
-- PostgreSQL will consider a multi-column index from the first column onward, so if the first column is the most selective, the index access method will be the cheapest.
-- In this case, customer_id is likely to be more selective than order_date, so it is placed first in the index definition.
-- So 2 things to remember when creating a composite index:
    -- 1. Place the most selective column first.
    -- 2. The order of the columns in the index definition matters, as it affects how the index can be used by the query planner.
    --    Queries that filter on the first column of the index can use the index efficiently, while queries that filter on the second column may not benefit from the index
