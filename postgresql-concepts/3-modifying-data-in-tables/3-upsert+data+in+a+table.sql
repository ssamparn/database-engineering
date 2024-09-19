-- UPSERT DATA IN A TABLE
-- ###################################

/*
    1. The idea is that when you insert a new row into the table, PostgreSQL will update the row if it already exists.
       Other wise, it will insert the new row.

       That is why, we call the action UPSERT (the combination of UPDATE & INSERT).

    2. Syntax:
        INSERT INTO table_name (list_of_columns)
        VALUES (list_of_values)
        ON CONFLICT target action;

    3. for 'action' after ON CONFLICT, we have a few options.

       a) DO NOTHING: Which means do nothing if the row already exists in the table.
       b) DO UPDATE SET column_1 = value_1 WHERE condition: Update some fields in the table.

    4. This is similar to INSERT INTO....IF NOT EXISTS functionality.

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
    1. Let's insert a record, on conflict do nothing.
    Syntax: INSERT INTO table_name (list_of_columns)
            VALUES (list_of_values)
            ON CONFLICT target action;
*/

INSERT INTO t_tags (tag)
    VALUES ('Pen')
ON CONFLICT (tag)
DO
    NOTHING;

/*
    2. Let's insert a record, on conflict set new rules.
    Syntax: INSERT INTO table_name (list_of_columns)
            VALUES (list_of_values)
            ON CONFLICT target action;
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
    3. Another example. Let's insert a record, on conflict set new rules.
    Syntax: INSERT INTO table_name (list_of_columns)
            VALUES (list_of_values)
            ON CONFLICT target action;
*/
-- Concatenate 'cutter' as to sharpner & update the timestamp

INSERT INTO t_tags (tag)
VALUES ('Sharpner')
    ON CONFLICT (tag)
DO
UPDATE SET
    tag = EXCLUDED.tag || 'cutter',
    update_date = NOW();

