/* DROP a Database */
-- ==================

DROP DATABASE [IF EXISTS] database_name;
DROP DATABASE IF EXISTS db_test;

/*

     1. Only superusers and the database owner can execute the DROP DATABASE statement.
     2. Be super super careful whenever you try to use anything starting with a 'DROP'

*/

/* CREATE a Database */
-- ====================

CREATE DATABASE database_name;
CREATE DATABASE db_test;