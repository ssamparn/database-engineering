-- SELF JOIN:
-- #################

/*
    What is Self Join?
        - A Self Join is a join where a table is joined with itself.
        - Normal use-cases for self joins include
            - Finding relationships between rows in the SAME table, such as hierarchical data.
            - Finding duplicates.
            - To compare rows within the SAME table based on certain conditions.
        - A self join can be useful when you have hierarchical data or when you want to find relationships between rows in the SAME table.
        - This is commonly used for hierarchical relationships such as:
                Employee → Manager
                Category → Parent Category
                Department → Parent Department

        Syntax:
            SELECT
                columns
            FROM
                table a
            INNER JOIN
                table b ON a.column_name = b.column_name
            WHERE condition;
*/

-- 1. Let's create a table called left_products with product_id and product_name columns.

CREATE TABLE left_products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL
);

-- Insert sample data into left_products
INSERT INTO left_products (product_id, product_name) VALUES
    (1, 'Computers'),
    (2, 'Laptops'),
    (3, 'Monitors'),
    (5, 'Mics')
;

-- 2. Let's self join left_products table.
SELECT
    *
FROM
    left_products AS lp1
INNER JOIN
    left_products AS lp2
ON lp1.product_id = lp2.product_id;

-- Note: In the above query, we are joining the left_products table with itself using an INNER JOIN.
-- We are using aliases (lp1 and lp2) to differentiate between the two instances of the same table.
-- The join condition is based on the product_id column, which is common to both instances of the table.
-- This is mpre of a one-to-one relationship, as we are joining the table with itself based on a unique identifier (product_id).

-- 3. Let's self join directors table to find the relationship between directors.
SELECT
    *
FROM
    directors AS d1
INNER JOIN
    directors AS d2
ON
    d1.director_id = d2.director_id;

-- 4. Let's self join find all pairs of movies that have same movie length.
SELECT
    m1.movie_id AS movie1_id,
    m1.movie_name AS movie1_name,
    m1.movie_length AS movie1_length,
    m2.movie_id AS movie2_id,
    m2.movie_name AS movie2_name,
    m2.movie_length AS movie2_length
FROM
    movies AS m1
INNER JOIN
    movies AS m2
ON
    m1.movie_length = m2.movie_length
AND
    m1.movie_name <> m2.movie_name
ORDER BY
    m1.movie_length DESC, m1.movie_name;

-- 5. Let's query hierarchical data like all directors and their movies using self join.
SELECT
    m1.movie_name AS movie_name,
    m2.director_id AS director_id
FROM
    movies AS m1
INNER JOIN
    movies AS m2
ON
    m1.director_id = m2.movie_id
ORDER BY
    m2.director_id, m1.movie_name;

/*
    For Interviews:
        Self Join is commonly used when an entity has a relationship with itself.
        In Hibernate and Spring Data JPA, self joins are typically modeled using a self-referencing @ManyToOne association and an optional @OneToMany collection for the reverse relationship.
        For example, an Employee entity can reference another Employee as its manager.
        In JPQL, a self join is written as LEFT JOIN e.manager m, which corresponds to joining the employee table with itself in SQL.
        LEFT JOIN FETCH can be used to eagerly load the related self-referencing entity and avoid the N+1 problem.

    In real-world applications, Self Joins are most commonly used to model hierarchical, recursive, or parent-child relationships within the same entity/table.
    1. Employee → Manager Hierarchy
    Database
    -------------------------
    Employee Table
    -------------------------
    | employee_id | name       | manager_id |
    |-------------|------------|------------|
    | 1           | Alice      | NULL       |
    | 2           | Bob        | 1          |
    | 3           | Charlie    | 1          |
    | 4           | David      | 2          |

    In this example, the Employee table has a self-referencing foreign key (manager_id).

    Entity Relationship:
    -------------------------
    Employee Entity
    -------------------------
    @Entity
    public class Employee {

        @Id
        private Long employeeId;

        private String name;

        @ManyToOne
        @JoinColumn(name = "manager_id")
        private Employee manager;

        @OneToMany(mappedBy = "manager")
        private List<Employee> subordinates;
    }

    Using DTO Projection:
    -------------------------
    public class EmployeeDTO {
        private Long employeeId;
        private String employeeName;
        private Long managerId;
        private String managerName;
    }

    Repository Method:
    -------------------------
    @Query("SELECT new com.example.EmployeeDTO(
            e.employeeId,
            e.name,
            m.employeeId,
            m.name)
    FROM Employee e LEFT JOIN e.manager m")
    List<EmployeeDTO> findAllEmployeesWithManagers();

    Notice that the same table (employee) is joined twice:
        e = Employee
        m = Manager.
    This is exactly a self join.
*/