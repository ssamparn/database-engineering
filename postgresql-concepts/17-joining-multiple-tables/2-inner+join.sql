-- INNER JOIN
-- #######################

/*
    Inner Join:
        - By default, when you join two tables (with JOIN) the result set will only include rows that have matching values in both tables. This is known as an inner join.
        - An inner join is a type of join that returns only the rows that have matching values in both tables being joined.
        - It combines rows from two or more tables based on a related column between them.
        - The result of an inner join will only include rows where there is a match in both tables, and any rows that do not have a corresponding match in the other table will be excluded from the result set.
        - Syntax:
            SELECT
                columns
            FROM
                table_a
            INNER JOIN
                table_b
            ON
                table_a.primary_key_column = table_b.foreign_key_column;
        Here table_a is the first table, table_b is the second table, and column is the common column used to join the two tables.

    From a system design perspective, an inner join is a fundamental operation in relational databases that allows for the combination of data from multiple tables based on a common attribute.
    It is used to retrieve related data from different tables, enabling more complex queries and analysis.
    Inner joins are essential for maintaining data integrity and ensuring that only relevant information is included in the result set, which can improve query performance and reduce the amount of data processed.

    From a business perspective, inner joins are crucial for generating meaningful insights from data stored in relational databases.
    They allow businesses to combine data from different sources, such as customer information, sales data, and product details, to gain a comprehensive understanding of their operations.
    By using inner joins, businesses can identify trends, correlations, and patterns that can inform decision-making and strategy development.

    From an interview perspective, understanding inner joins is important for candidates applying for roles that involve working with relational databases.
    Interviewers may ask questions about inner joins to assess a candidate's knowledge of SQL and their ability to work with data stored in multiple tables.
    Candidates should be able to explain the concept of inner joins, provide examples of how they are used, and demonstrate their ability to write SQL queries that utilize inner joins effectively.
    They may also be asked to optimize queries involving inner joins or to troubleshoot issues related to data retrieval and performance.
    e.g: They might ask following questions:

    Q: What is an inner join and how does it work?
    Answer: An inner join is a type of join that returns only the rows that have matching values in both tables being joined.
            It combines rows from two or more tables based on a related column between them.
            The result of an inner join will only include rows where there is a match in both tables, and any rows that do not have a corresponding match in the other table will be excluded from the result set.

    Q: Can you provide an example of an inner join query?
    Answer: Sure! Here's an example of an inner join query that retrieves data from two tables, "customers" and "orders", based on a common column "customer_id":
            SELECT
                customers.customer_id, customers.customer_name, orders.order_id, orders.order_date
            FROM
                customers
            INNER JOIN
                orders
            ON
                customers.customer_id = orders.customer_id;

    Q: How do inner joins differ from other types of joins, such as left joins or right joins?
    Answer: Inner joins return only the rows that have matching values in both tables being joined,
    while left joins return all rows from the left table and matching rows from the right table (or NULL if there is no match),
    and right joins return all rows from the right table and matching rows from the left table (or NULL if there is no match).

    Q: How can you optimize a query that uses inner joins for better performance?
    Answer: To optimize a query that uses inner joins, you can:
            - Ensure that the columns used in the join conditions are indexed.
            - Use appropriate filtering conditions to reduce the number of rows being joined.
            - Avoid using functions or expressions on the join columns, as this can prevent the use of indexes.
            - Consider using subqueries or Common Table Expressions (CTEs) to break down complex queries into simpler parts.
            - Analyze the query execution plan to identify potential bottlenecks and optimize accordingly.

    Q: What are some common pitfalls to avoid when using inner joins?
    Answer: Some common pitfalls to avoid when using inner joins include:
            - Forgetting to include the join condition, which can result in a Cartesian product and return an unexpectedly large result set.
            - Using ambiguous column names without specifying the table, which can lead to errors or unexpected results.
            - Joining on columns with different data types, which can cause errors or unexpected results.
            - Not considering the impact of NULL values in the join columns, which can lead to missing rows in the result set.
            - Overcomplicating the query with unnecessary joins or subqueries, which can make the query harder to read and maintain.

    Q: How do inner joins handle NULL values in the join columns?
    Answer: Inner joins do not include rows with NULL values in the join columns, as there is no matching value in the other table.
    If a row in either table has a NULL value in the join column, that row will be excluded from the result set.
    This behavior ensures that only rows with matching values in both tables are returned, maintaining the integrity of the join operation.

    Q: Can you explain the difference between an inner join and a self join?
    Answer: An inner join combines rows from two different tables based on a related column, while a self join is a type of inner join where a table is joined with itself.
    In a self join, you can use table aliases to differentiate between the two instances of the same table.

    Q: What are some best practices for writing inner join queries?
    Answer: Some best practices for writing inner join queries include:
            - Use table aliases to make the query more readable and avoid ambiguity.
            - Clearly specify the join conditions to ensure that the correct rows are being joined.
            - Use appropriate filtering conditions to limit the number of rows being joined and improve performance.
        e.g:
            SELECT
                c.customer_id, c.customer_name, o.order_id, o.order_date
            FROM
                customers AS c
            INNER JOIN
                orders AS o
            ON
                c.customer_id = o.customer_id
            WHERE
                o.order_date >= '2023-01-01';

    Q: How can you handle multiple inner joins in a single query?
    Answer: You can handle multiple inner joins in a single query by chaining the join operations together. Each join operation can be based on a different related column, allowing you to combine data from multiple tables.
         e.g:
            SELECT
                c.customer_id, c.customer_name, o.order_id, o.order_date, p.product_name
            FROM
                customers AS c
            INNER JOIN
                orders AS o
            ON
                c.customer_id = o.customer_id
            INNER JOIN
                products AS p
            ON
                o.product_id = p.product_id;

    Q: What are some common use cases for inner joins in real-world applications?
    Answer: Some common use cases for inner joins in real-world applications include:
            - Retrieving customer orders and their details from an e-commerce database.
            - Combining employee information with department details in a human resources database.
            - Analyzing sales data by joining sales transactions with product and customer information.
            - Generating reports that require data from multiple related tables, such as financial reports or inventory management reports.


    In Hibernate entity relationships, inner join can be achieved using the @OneToMany and @ManyToOne annotations to define the relationships between entities.
    When querying these entities, Hibernate will automatically generate the necessary SQL inner join statements based on the defined relationships.
    e.g:
        @Entity
        public class Customer {
            @Id
            private Long customerId;
            private String customerName;

            @OneToMany(mappedBy = "customer")
            private List<Order> orders;
        }

        @Entity
        public class Order {
            @Id
            private Long orderId;
            private LocalDate orderDate;

            @ManyToOne
            @JoinColumn(name = "customer_id")
            private Customer customer;
        }

    In Spring Data JPA, inner joins can be performed using JPQL (Java Persistence Query Language) or the Criteria API.
    JPQL allows you to write queries using entity names and their relationships, while the Criteria API provides a programmatic way to build queries.
    Both approaches enable you to retrieve related data from multiple entities in a type-safe manner.

    e.g: Using JPQL:
        @Query("SELECT
                    c.customerId, c.customerName, o.orderId, o.orderDate
                FROM
                    Customer c
                INNER JOIN
                    c.orders o
                ON
                    c.customerId = o.customerId
                WHERE
                    o.orderDate >= :startDate")
        List<Customer> findCustomersWithOrdersAfterDate(@Param("startDate") LocalDate startDate);

    e.g: Using Criteria API:
        CriteriaBuilder cb = entityManager.getCriteriaBuilder();
        CriteriaQuery<Customer> cq = cb.createQuery(Customer.class);
        Root<Customer> customer = cq.from(Customer.class);
        Join<Customer, Order> order = customer.join("orders");
        cq.select(customer).where(cb.greaterThanOrEqualTo(order.get("orderDate"), startDate));
        List<Customer> result = entityManager.createQuery(cq).getResultList();

    Is it a good idea to rely on Hibernate to create inner join queries or should you write them manually?
    Relying on Hibernate to create inner join queries can be a good idea in many cases, as it simplifies the development process and allows you to work with entities and their relationships in an object-oriented manner.
    Hibernate automatically generates the necessary SQL queries based on the defined entity relationships, which can save time and reduce the risk of errors in query construction.
    However, there are situations where writing inner join queries manually may be more appropriate, such as when you need to optimize performance, handle complex queries, or work with specific database features that Hibernate may not fully support.
    In such cases, writing custom queries using JPQL, the Criteria API, or native SQL can provide greater control and flexibility.
    Ultimately, the decision to rely on Hibernate or write queries manually should be based on the specific requirements of your application, the complexity of the queries, and the performance considerations.
*/

-- 1. Lets combine directors and movies tables to get the list of movies along with their directors using INNER JOIN.
SELECT
    d.director_id,
    d.first_name,
    d.last_name,
    m.movie_id,
    m.movie_name,
    m.movie_lang,
    m.release_date
FROM
    directors AS d
INNER JOIN
    movies AS m
ON
    d.director_id = m.director_id
ORDER BY
    director_id;

-- or

SELECT
    d.director_id,
    d.first_name,
    d.last_name,
    m.movie_id,
    m.movie_name,
    m.movie_lang,
    m.release_date
FROM
    movies AS m
INNER JOIN
    directors AS d
ON
    m.director_id = d.director_id
ORDER BY
    director_id;

-- 2. Provide more meaningful column names in the result set using AS keyword.

SELECT
    d.director_id,
    d.first_name AS "Director First Name",
    d.last_name AS "Director Last Name",
    m.movie_id,
    m.movie_name AS "Movie Name",
    m.movie_lang AS "Movie Language",
    m.release_date AS "Movie Release Date"
FROM
    directors AS d
        INNER JOIN
    movies AS m
    ON
        d.director_id = m.director_id
ORDER BY
    director_id;

-- 3. Filter only the English movies which were released after 2000 using WHERE clause.
SELECT
    d.director_id,
    d.first_name AS "Director First Name",
    d.last_name AS "Director Last Name",
    m.movie_id,
    m.movie_name AS "Movie Name",
    m.movie_lang AS "Movie Language",
    m.release_date AS "Movie Release Date"
FROM
    directors AS d
INNER JOIN
    movies AS m
ON
    d.director_id = m.director_id
WHERE
    m.movie_lang = 'English'
AND
    m.release_date > '2000-01-01'
ORDER BY
    director_id;


-- 4. Get all the columns from both tables using * wildcard.
SELECT
    m.*,
    d.*
FROM
    directors AS d
INNER JOIN
    movies AS m
ON
    d.director_id = m.director_id
ORDER BY
    m.movie_id;

/*
    INNER JOIN with USING clause:
        - The USING clause is a shorthand way to specify the join condition when the columns being joined have the same name in both tables.
        - It simplifies the syntax and makes the query more readable by eliminating the need to explicitly specify the join condition using the ON clause.
        - When using the USING clause, you only need to provide the column name once, and PostgreSQL will automatically match the columns with the same name in both tables.
        - Syntax:
            SELECT
                columns
            FROM
                table_a
            INNER JOIN
                table_b
            USING
                (common_column);
        Here table_a is the first table, table_b is the second table, and common_column is the column with the same name in both tables that is used to join them.
*/

-- 1. Lets combine directors and movies tables to get the list of movies along with their directors using INNER JOIN with USING clause.
SELECT
    d.director_id,
    d.first_name AS "Director First Name",
    d.last_name AS "Director Last Name",
    m.movie_id,
    m.movie_name AS "Movie Name",
    m.movie_lang AS "Movie Language",
    m.release_date AS "Movie Release Date"
FROM
    directors AS d
INNER JOIN
    movies AS m
USING
    (director_id)
ORDER BY
    director_id;

-- 2. Let's combine movies, directors, and movies_revenues tables to get the list of movies along with their directors and revenues using INNER JOIN with USING clause.
SELECT
    d.director_id,
    d.first_name AS "Director First Name",
    d.last_name AS "Director Last Name",
    m.movie_id,
    m.movie_name AS "Movie Name",
    m.movie_lang AS "Movie Language",
    m.release_date AS "Movie Release Date",
    mr.revenue_id,
    mr.revenues_domestic AS "Domestic Revenue",
    mr.revenues_international AS "International Revenue"
FROM
    movies AS m
INNER JOIN
    directors AS d
USING
    (director_id)
INNER JOIN
    movies_revenues AS mr
USING
    (movie_id)
ORDER BY
    director_id;

-- 3. Let's combine movies, directors, and movies_revenues tables to get the movie name, director name, domestic revenues of all Japanese movies using INNER JOIN with USING clause.
SELECT
    m.movie_name AS "Movie Name",
    m.movie_lang AS "Movie Language",
    d.first_name AS "Director First Name",
    d.last_name AS "Director Last Name",
    mr.revenues_domestic AS "Domestic Revenue"
FROM
    movies AS m
INNER JOIN
    directors AS d
USING
    (director_id)
INNER JOIN
    movies_revenues AS mr
USING
    (movie_id)
WHERE
    m.movie_lang = 'Japanese'
ORDER BY
    mr.revenues_domestic DESC;

-- 4. Select the movie name, director name of all English, Chinese and Japanase movies which have domestic revenues greater than 100 using INNER JOIN with USING clause.
SELECT
    m.movie_name AS "Movie Name",
    m.movie_lang AS "Movie Language",
    d.first_name AS "Director First Name",
    d.last_name AS "Director Last Name",
    mr.revenues_domestic AS "Domestic Revenue"
FROM
    movies AS m
INNER JOIN
    directors AS d
USING
    (director_id)
INNER JOIN
    movies_revenues AS mr
USING
    (movie_id)
WHERE
    m.movie_lang IN ('English', 'Chinese', 'Japanese')
AND
    mr.revenues_domestic > 100;

-- 5. Select the movie name, director name, movie language, total revenues of all top 5 movies.
SELECT
    m.movie_name AS "Movie Name",
    m.movie_lang AS "Movie Language",
    d.first_name AS "Director First Name",
    d.last_name AS "Director Last Name",
    mr.revenues_domestic AS "Domestic Revenue",
    mr.revenues_international AS "International Revenue",
    (mr.revenues_domestic + mr.revenues_international) AS "Total Revenue"
FROM
    movies AS m
INNER JOIN
    directors AS d
USING
    (director_id)
INNER JOIN
    movies_revenues AS mr
USING
    (movie_id)
ORDER BY
    "Total Revenue"
DESC NULLS LAST
LIMIT 5;

-- 7. What were the top 10 most profitable movies between year 2005 and 2008? Select the movie name, director name, movie language, total revenues of all top 10 movies.
SELECT
    m.movie_name AS "Movie Name",
    m.movie_lang AS "Movie Language",
    m.release_date AS "Movie Release Date",
    d.first_name AS "Director First Name",
    d.last_name AS "Director Last Name",
    mr.revenues_domestic AS "Domestic Revenue",
    mr.revenues_international AS "International Revenue",
    (mr.revenues_domestic + mr.revenues_international) AS "Total Revenue"
FROM
    movies AS m
INNER JOIN
    directors AS d
USING
    (director_id)
INNER JOIN
    movies_revenues AS mr
USING
    (movie_id)
WHERE
    m.release_date BETWEEN '2005-01-01' AND '2008-12-31'
ORDER BY
    "Total Revenue" DESC NULLS LAST
LIMIT 10;