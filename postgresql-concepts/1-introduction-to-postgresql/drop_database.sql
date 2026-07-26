/* DROP a Database */
-- ==================
DROP DATABASE [IF EXISTS] database_name;
DROP DATABASE IF EXISTS db_test;

/*
    1. Only superusers and the database owner can execute the DROP DATABASE statement.
    2. Be super, super careful whenever you try to use anything starting with a 'DROP', as DROP is a DDL command,
       and it will delete the database permanently.
    3. DROP DATABASE will remove the database and all its data permanently.
    4. DROP DATABASE will not remove the database if there are any active connections to the database.
       You will get an error message if you try to drop a database that has active connections.
*/

/* CREATE a Database */
-- ====================
CREATE DATABASE database_name;
CREATE DATABASE db_test;