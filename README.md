# Assignment 2

## 1. What is PostgreSQL?

PostgreSQL is a powerful, open-source object-relational database system widely used for enterprise-level performance and reliability. It is known for its robust features, flexibility and standards compliance.

#### Key Features:

**1. Open Source & Free**

- Licensed under the PostgreSQL License
- Actively developed and maintained by a global community.

**2. Relational and Object-Oriented**

- Follows standard SQL for querying data.
- Supports object-oriented features like table inheritance and custom types.

**3. Advanced SQL Support**

- Subqueries, joins, views, stored procedures, triggers and more.
- Full compliance with SQL standards.

**4. Data Integrity and Reliability**

- ACID-compliant (Atomicity, Consistency, Isolation, Durability).
- Robust transactional support and crash recovery.

**5. Extensibility**

- Users can define custom data types, functions and operators.
- Extensions like PostGIS for geographic data and pg_partman for partitioning

**6. Cross-Platform**

- Works on Windows, macOS, Linux and more.

#### Use Cases:

- Web applications
- Data warehousing and analytics
- Geographic information systems
- Financial and scientific applications

#### Example:

```
CREATE TABLE users (
id SERIAL PRIMARY KEY,
name VARCHAR(50) NOT NULL,
email VARCHAR(50) UNIQUE NOT NULL
);

INSERT INTO users (name, email) VALUES ('Shakil', 'sakilahmed7810@gmail.com');
```

## 2. Explain the Primary Key and Foreign Key concepts in PostgreSQL.

In PostgreSQL Primary Key and Foreign Key are crucial for maintaining data integrity and establishing relationships between tables.

### Primary Key

A Primary Key is a column or a combination of columns that:

- Uniquely identifies each row in a table.
- Cannot contain NULL values.
- Is automatically indexed for fast lookups.
- id is the primary key. Each table must have a unique, non-null ID.



#### Example:

```
CREATE TABLE students (
id SERIAL PRIMARY KEY,
name VARCHAR(50) NOT NULL,
email VARCHAR(50) UNIQUE NOT NULL
);
```


### Foreign Key
A Foreign Key is a column or combination of columns in one table that:
- References the Primary Key of another table.
- Establishes a relationship between two tables.
- Enforces referential integrity, meaning you can not insert a value that does not exist in the referenced table.
- user_id is a foreign key that links each order to a user in the table.

#### Example:
```
CREATE TABLE orders (
  order_id SERIAL PRIMARY KEY,
  user_id INTEGER REFERENCES students(id),
  product TEXT
);
```


## 3. What is the difference between the VARCHAR and CHAR data types?
In PostgreSQL both VARCHAR and CHAR are used to store text (string) data, but they behave differently in terms of storage, padding and performance.

### VARCHAR
- Variable-length character string
- Uses only as much space as needed
- No padding
- Slightly slower in rare edge cases
- Most common, flexible

#### Example:
```
CREATE TABLE users (
  name VARCHAR(100)
);
```

### CHAR
- Fixed-length character string
- Always uses exactly n characters
- Pads with spaces if input is shorter
- Can be slightly faster in fixed-size data
- Use when all values are same length 
- Automatically added to match length

#### Example:
```
CREATE TABLE codes (
  country_code CHAR(2)
);
```


## 4. Explain the purpose of the WHERE clause in a SELECT statement
The WHERE clause in a SELECT statement is used to filter rows in a database table based on specific conditions. It ensures that only the rows matching the condition are returned in the query result.
The WHERE clause controls which rows are selected, making your queries more precise, efficient and useful for analysis or reporting.

### Purpose of WHERE Clause:
- Limits data returned by a query
- Applies conditions to columns 
- Makes queries more efficient and targeted

#### Example:
```
CREATE Table rangers (
    ranger_id SERIAL PRIMARY KEY UNIQUE,
    name VARCHAR(100) NOT NULL,
    age INT
);

INSERT INTO rangers VALUES('Shakil Ahamed', 25), ('Sayla', 21), ('Siuli', 17);

SELECT * FROM rangers WHERE age > 18;
SELECT * FROM rangers WHERE name = 'Sayla';

```

### Common Operators Used with WHERE:
- = , != or <>, 
- <, >, <=, >=
- BETWEEN, LIKE, IN
- IS NULL, IS NOT NULL
- Logical: AND, OR, NOT


## 5. What are the LIMIT and OFFSET clauses used for?
The LIMIT and OFFSET clauses in SQL including PostgreSQL are used to control the number of rows returned by a query, especially useful for pagination and performance optimization.

### LIMIT Clause
- Limits the number of returned rows
- Specifies the maximum number of rows to return.
- Helps when you only want a subset of results, such as the top 5 or latest 10 records.

#### Example:
```
SELECT * FROM rangers
LIMIT 5;

**Returns only the first 5 rows from the students table.**
```


### OFFSET Clause
- Skips a number of rows before starting to return results
- Skips a specified number of rows before starting to return rows.
- Often used together with LIMIT to paginate results.


#### Example:
```
SELECT * FROM rangers
OFFSET 5;

**Skips the first 5 rows, then returns all remaining rows.**
```

### Use Case: Pagination in Web Apps
```
SELECT * FROM rangers LIMIT 10 OFFSET 0;
SELECT * FROM rangers LIMIT 10 OFFSET 10;
SELECT * FROM rangers LIMIT 10 OFFSET 20;
```

- **Without ORDER BY, the result set may not be consistent across queries.**
- **For large data sets, OFFSET can become inefficient — consider using keyset pagination or cursors for better performance.**