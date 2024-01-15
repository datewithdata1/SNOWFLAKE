# Database and Schema Setup

```sql
-- Create Database and Schema
CREATE OR REPLACE DATABASE CAR_DATABASE;
CREATE OR REPLACE SCHEMA CAR_SCHEMA;

-- Changing Database and Schema to Car
USE DATABASE CAR_DATABASE;
USE SCHEMA CAR_SCHEMA;
```

# Creating and Populating Car Tables

```sql
-- Create the car table
CREATE OR REPLACE TABLE CAR_DATABASE.CAR_SCHEMA.CAR (
    car_id INT,
    make VARCHAR(255),
    model VARCHAR(255),
    year INT,
    color VARCHAR(255),
    owner_id INT
);

INSERT INTO CAR_DATABASE.CAR_SCHEMA.CAR (car_id, make, model, year, color, owner_id)
VALUES (1, 'Toyota', 'Camry', 2022, 'Blue', 101),
       (2, 'Honda', 'Accord', 2020, 'Red', 102),
       (3, 'Ford', 'Mustang', 2021, 'Black', 103),
       (4, 'Chevrolet', 'Cruze', 2019, 'Silver', 104);

-- Car table to compare
CREATE OR REPLACE TABLE CAR_DATABASE.CAR_SCHEMA.CAR_012923 (
    car_id INT,
    make VARCHAR(255),
    model VARCHAR(255),
    year INT,
    color VARCHAR(255),
    owner_id INT
);

INSERT INTO CAR_DATABASE.CAR_SCHEMA.CAR_012923 (car_id, make, model, year, color, owner_id)
VALUES (1, 'Toyota', 'Camry', 2022, 'Blue', 101),
       (2, 'Honda', 'Accord', 2020, 'Green', 102), -- Modified color
       (3, 'Ford', 'Mustang', 2021, 'Black', 103),
       (4, 'Chevrolet', 'Cruze', 2019, 'Silver', 104);
```

# Comparing Datasets

```sql
-- Making Comparisons Between The Datasets
SELECT CAR_ID, MAKE, MODEL, YEAR, COLOR, OWNER_ID
FROM CAR_DATABASE.CAR_SCHEMA.CAR
EXCEPT 
SELECT CAR_ID, MAKE, MODEL, YEAR, COLOR, OWNER_ID
FROM CAR_DATABASE.CAR_SCHEMA.CAR_012923;
```

# Comparing Datasets with UNION and Table Names

```sql
-- Making Comparisons Between The Datasets with UNION and Table Names
WITH CAR_DIFFERENCE AS (
    SELECT CAR_ID, MAKE, MODEL, YEAR, COLOR, OWNER_ID
    FROM CAR_DATABASE.CAR_SCHEMA.CAR
    EXCEPT 
    SELECT CAR_ID, MAKE, MODEL, YEAR, COLOR, OWNER_ID
    FROM CAR_DATABASE.CAR_SCHEMA.CAR_012923
), CAR_012923_DIFFERENCE AS (
    SELECT CAR_ID, MAKE, MODEL, YEAR, COLOR, OWNER_ID
    FROM CAR_DATABASE.CAR_SCHEMA.CAR_012923
    EXCEPT 
    SELECT CAR_ID, MAKE, MODEL, YEAR, COLOR, OWNER_ID
    FROM CAR_DATABASE.CAR_SCHEMA.CAR
)
SELECT CAR_ID, MAKE, MODEL, YEAR, COLOR, OWNER_ID, 'CAR' AS TABLE_NAME
FROM CAR_DIFFERENCE 
UNION
SELECT CAR_ID, MAKE, MODEL, YEAR, COLOR, OWNER_ID, 'CAR_012923' AS TABLE_NAME
FROM CAR_012923_DIFFERENCE
ORDER BY CAR_ID ASC;
```

This SQL script sets up a database and schema, creates two tables, populates them with data, and then compares the datasets using the EXCEPT operator. Additionally, it utilizes a UNION operation with table names to show the differences between the datasets. The final result includes the differing records along with a column indicating the source table.