-- Operators in PostgreSQL:
-- ############################

/*
    Operators in PostgreSQL are special symbols or keywords that are used to perform operations on one or more values (operands) and return a result.
    They can be used in various contexts, such as in expressions, conditions, and queries.
        1. Compare the values of two operands and return a boolean result (true or false).
        2. Perform arithmetic operations on numeric values.
        3. Select subsets of data based on specific conditions.

    There are several types of operators in PostgreSQL, including:

    1. Comparison Operators: Used to compare values (e.g., =, <>, <, >, <=, >=).
    -------------------------------------------------------------------------------------------------
        Equal To                 (=): Checks if two values are equal.
        Not Equal To             (<> or !=): Checks if two values are not equal.
        Less Than                (<): Checks if the left value is less than the right value.
        Greater Than             (>): Checks if the left value is greater than the right value.
        Less Than or Equal To    (<=): Checks if the left value is less than or equal to the right value.
        Greater Than or Equal To (>=): Checks if the left value is greater than or equal to the right value.

    2. Arithmetic Operators: Used for mathematical calculations (e.g., +, -, *, /, %).
    -------------------------------------------------------------------------------------------------
        Addition       (+): Adds two numeric values.
        Subtraction    (-): Subtracts the right numeric value from the left numeric value.
        Multiplication (*): Multiplies two numeric values.
        Division       (/): Divides the left numeric value by the right numeric value.
        Modulus        (%): Returns the remainder of the division of the left numeric value by the right numeric value.

    3. Logical Operators: Used to combine multiple conditions (e.g., AND, OR, NOT, LIKE, IN, BETWEEN).
    -------------------------------------------------------------------------------------------------
        AND:     Returns true if both conditions are true.
        OR:      Returns true if at least one of the conditions is true.
        NOT:     Negates the condition, returning true if the condition is false.
        LIKE:    Used for pattern matching with wildcard characters (e.g., % for any sequence of characters, _ for a single character).
        IN:      Checks if a value is present in a list of values.
        BETWEEN: Checks if a value is within a specified range (inclusive).


    4. String Operators: Used for string manipulation (e.g., || for concatenation).
    -------------------------------------------------------------------------------------------------
        Concatenation (||): Combines two or more strings into a single string.

    5. Bitwise Operators: Used for bit-level operations (e.g., &, |, #).
    -------------------------------------------------------------------------------------------------
        &: Bitwise AND operation.
        |: Bitwise OR operation.
        #: Bitwise XOR operation.

    6. Other Operators: Includes operators for arrays, JSON, and more.
    -------------------------------------------------------------------------------------------------
        array operators: Used to manipulate array data types (e.g., @>, <@, &&).
        JSON operators: Used to manipulate JSON data types (e.g., ->, ->>, #>, @>).
*/