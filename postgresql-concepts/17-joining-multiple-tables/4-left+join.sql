-- LEFT JOIN:
-- ####################

/*
    What is Left Join in SQL?
        - The LEFT JOIN keyword returns all records from the left table (table1), PLUS records that match values in the joined column from the right table (table2).
        - The result is NULL from the right side, if there is no match.
        - Syntax:
            SELECT column_name(s)
            FROM table1
            LEFT JOIN table2
            ON table1.column_name = table2.column_name;

    Where to use Left Join in SQL?
        - LEFT JOIN is used when you want to retrieve all records from the left table, regardless of whether there is a match in the right table.
        - It is useful when you want to find records in one table that do not have corresponding records in another table.

    Use Cases of Left Join in SQL:
        - Finding unmatched records: LEFT JOIN can be used to find records in one table that do not have corresponding records in another table.
        - Data analysis: LEFT JOIN can be used to combine data from multiple tables for analysis, even if some records do not have matches in the other tables.
        - Reporting: LEFT JOIN can be used to generate reports that include all records from one table, along with any matching records from another table.

    From an Interview Perspective:
        - LEFT JOIN is a common topic in SQL interviews, and candidates may be asked to explain its purpose, syntax, and use cases.
        - Interviewers may also ask candidates to write SQL queries using LEFT JOIN to demonstrate their understanding of the concept.

    For example, an interviewer may ask following question:
    1. "Can you explain the difference between INNER JOIN and LEFT JOIN, and provide an example of when you would use each?"
    Answer:
        - INNER JOIN returns only the records that have matching values in both tables, while LEFT JOIN returns all records from the left table and the matched records from the right table.
        - Example: If you have a "Customers" table and an "Orders" table, and you want to find all customers and their orders (if any), you would use a LEFT JOIN. If you only want to find customers who have placed orders, you would use an INNER JOIN.

    2. "Can you write a SQL query using LEFT JOIN to find all employees and their corresponding department names, even if some employees do not belong to any department?"
    Answer:
        - SELECT employees.name, departments.department_name
          FROM employees
          LEFT JOIN departments ON employees.department_id = departments.id;

    3. "Can you explain a scenario where using LEFT JOIN would be more appropriate than INNER JOIN?"
    Answer:
        - If you want to retrieve all records from one table, regardless of whether there are matching records in another table, LEFT JOIN would be more appropriate. For example, if you have a "Products" table and a "Sales" table, and you want to find all products and their sales (if any), you would use a LEFT JOIN. This would allow you to see all products, even those that have not been sold, while an INNER JOIN would only return products that have been sold.

    4. "Can you explain how NULL values are handled in LEFT JOIN?"
    Answer:
        - In a LEFT JOIN, if there is no match for a record in the left table, the result will include NULL values for the columns from the right table. This allows you to see all records from the left table, even if there are no corresponding records in the right table. For example, if you have a "Students" table and a "Grades" table, and you want to find all students and their grades (if any), a LEFT JOIN would return all students, with NULL values for the grade columns for students who do not have any grades recorded.

    5. "Can you explain how to use LEFT JOIN with multiple tables?"
    Answer:
        - You can use LEFT JOIN with multiple tables by chaining multiple LEFT JOIN statements together. For example, if you have three tables: "Customers", "Orders", and "Products", and you want to find all customers, their orders (if any), and the products associated with those orders (if any), you could use the following query:
            SELECT customers.name, orders.order_id, products.product_name
            FROM customers
            LEFT JOIN orders ON customers.id = orders.customer_id
            LEFT JOIN products ON orders.product_id = products.id;
    6. "Can you explain the difference between LEFT JOIN and RIGHT JOIN?"
    Answer:
        - LEFT JOIN returns all records from the left table and the matched records from the right table, while RIGHT JOIN returns all records from the right table and the matched records from the left table.

    7. "Can you explain how to use LEFT JOIN with aggregate functions?"
    Answer:
        - You can use LEFT JOIN with aggregate functions to perform calculations on the joined data. For example, if you want to find the total sales for each customer, including customers who have not made any purchases, you could use the following query:
            SELECT customers.name, SUM(orders.amount)
            FROM customers
            LEFT JOIN orders ON customers.id = orders.customer_id
            GROUP BY customers.name;

    8. "Can you explain how to use LEFT JOIN with subqueries?"
    Answer:
        - You can use LEFT JOIN with subqueries to join the results of a subquery with another table. For example, if you want to find all customers and their most recent order (if any), you could use the following query:
            SELECT customers.name, recent_orders.order_id
            FROM customers
            LEFT JOIN (
                SELECT customer_id, MAX(order_date) AS most_recent_order
                FROM orders
                GROUP BY customer_id
            ) AS recent_orders ON customers.id = recent_orders.customer_id;

    9. "Can you explain how to use LEFT JOIN with self-joins?"
    Answer:
        - You can use LEFT JOIN with self-joins to join a table to itself. For example, if you have an "Employees" table and you want to find all employees and their managers (if any), you could use the following query:
            SELECT e1.name AS employee_name, e2.name AS manager_name
            FROM employees e1
            LEFT JOIN employees e2 ON e1.manager_id = e2.id;

    10. "Can you explain how to use LEFT JOIN with multiple conditions?"
    Answer:
        - You can use LEFT JOIN with multiple conditions in the ON clause to specify more complex join criteria. For example, if you have a "Students" table and a "Courses" table, and you want to find all students and their enrolled courses (if any), but only for courses that are currently active, you could use the following query:
            SELECT students.name, courses.course_name
            FROM students
            LEFT JOIN courses ON students.id = courses.student_id AND courses.is_active = true;

    11. "Can you explain how to use LEFT JOIN with UNION?"
    Answer:
        - You can use LEFT JOIN with UNION to combine the results of multiple queries. For example, if you have two tables: "DomesticOrders" and "InternationalOrders", and you want to find all orders from both tables, along with the customer information (if any), you could use the following query:
            SELECT customers.name, domestic_orders.order_id
            FROM customers
            LEFT JOIN domestic_orders ON customers.id = domestic_orders.customer_id
            UNION
            SELECT customers.name, international_orders.order_id
            FROM customers
            LEFT JOIN international_orders ON customers.id = international_orders.customer_id;

    12. "Can you explain how to use LEFT JOIN with window functions?"
    Answer:
        - You can use LEFT JOIN with window functions to perform calculations over a set of rows related to the current row. For example, if you want to find all employees and their total sales, including employees who have not made any sales, you could use the following query:
            SELECT employees.name, SUM(orders.amount) OVER (PARTITION BY employees.id) AS total_sales
            FROM employees
            LEFT JOIN orders ON employees.id = orders.employee_id;

    13. "Can you explain how to use LEFT JOIN with CTEs (Common Table Expressions)?"
    Answer:
        - You can use LEFT JOIN with CTEs to create temporary result sets that can be referenced within a SELECT, INSERT, UPDATE, or DELETE statement. For example, if you want to find all customers and their total order amounts, including customers who have not made any orders, you could use the following query:
            WITH customer_orders AS (
                SELECT customer_id, SUM(amount) AS total_order_amount
                FROM orders
                GROUP BY customer_id
            )
            SELECT customers.name, customer_orders.total_order_amount
            FROM customers
            LEFT JOIN customer_orders ON customers.id = customer_orders.customer_id;

    14. "Can you explain how to use LEFT JOIN with JSON data?"
    Answer:
        - You can use LEFT JOIN with JSON data to join tables based on JSON fields. For example, if you have a "Users" table with a JSON column containing user preferences, and a "Preferences" table, you could use the following query to find all users and their preferences (if any):
            SELECT users.name, preferences.preference_name
            FROM users
            LEFT JOIN preferences ON users.preferences->>'preference_id' = preferences.id;

    15. "Can you explain how to use LEFT JOIN with full-text search?"
    Answer:
        - You can use LEFT JOIN with full-text search to join tables based on text search results. For example, if you have a "Documents" table and a "Tags" table, and you want to find all documents and their associated tags (if any) based on a full-text search query, you could use the following query:
            SELECT documents.title, tags.tag_name
            FROM documents
            LEFT JOIN tags ON documents.id = tags.document_id
            WHERE to_tsvector(documents.content) @@ to_tsquery('search_query');

    16. "Can you explain how to use LEFT JOIN with spatial data?"
    Answer:
        - You can use LEFT JOIN with spatial data to join tables based on spatial relationships. For example, if you have a "Locations" table and a "Events" table, and you want to find all locations and their associated events (if any) within a certain distance, you could use the following query:
            SELECT locations.name, events.event_name
            FROM locations
            LEFT JOIN events ON ST_DWithin(locations.geom, events.geom, distance_in_meters);

    17. "Can you explain how to use LEFT JOIN with temporal data?"
    Answer:
        - You can use LEFT JOIN with temporal data to join tables based on time-based relationships. For example, if you have a "Projects" table and a "Tasks" table, and you want to find all projects and their associated tasks (if any) that are due within a certain time frame, you could use the following query:
            SELECT projects.name, tasks.task_name
            FROM projects
            LEFT JOIN tasks ON projects.id = tasks.project_id AND tasks.due_date BETWEEN start_date AND end_date;

    18. "Can you explain how to use LEFT JOIN with hierarchical data?"
    Answer:
        - You can use LEFT JOIN with hierarchical data to join tables based on parent-child relationships. For example, if you have a "Categories" table and a "Products" table, and you want to find all categories and their associated products (if any), you could use the following query:
            SELECT categories.name, products.product_name
            FROM categories
            LEFT JOIN products ON categories.id = products.category_id;


*/
