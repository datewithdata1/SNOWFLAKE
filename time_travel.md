

## Create Database

```sql
CREATE OR REPLACE DATABASE PRACTICE;
```

## Define Tables

```sql
-- Define table for DATA
create or replace table cars(
    car_id number,
    price number,
    manufacturer_id number)
    data_retention_time_in_days=90;

-- Show existing tables
SHOW TABLES;

-- Create another table for testing with a different retention period
create or replace table cars_test(
    car_id number,
    price number,
    manufacturer_id number)
    data_retention_time_in_days=95;

-- Alter retention period for the original cars table
alter table cars set data_retention_time_in_days=30;

-- Show tables after alterations
SHOW TABLES;
```

# Schema Management

```sql
CREATE OR REPLACE SCHEMA CAR_PREM;
-- Use a different schema for car-related data
USE SCHEMA PRACTICE.CAR_PERM;

-- Create a new table in the car schema
create or replace table cars_new(
    car_id number,
    price number,
    manufacturer_id number)
    data_retention_time_in_days=90;

-- Insert some data into the cars table
insert into cars_new values
    (1, 30000, 101),
    (2, 45000, 102),
    (3, 25000, 103),
    (4, 18000, 104),
    (5, 35000, 101),
    (6, 50000, 102),
    (7, 90000, 103),
    (8, 22000, 104);

-- Show tables after insertions
SHOW TABLES;

-- Alter retention period for the CAR_PERM schema
ALTER SCHEMA CAR_PREM set data_retention_time_in_days=55;
```

# Temporary Tables

```sql
-- Create transient and temporary tables for cars
create or replace  table cars_2(
    car_id number,
    price number,
    manufacturer_id number);

-- Show all tables
show tables;

-- Show updated schemas
SHOW SCHEMAS;

-- Query information schema again after schema alteration
SELECT * FROM PRACTICE.INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'CAR_PREM';
```

# Historical Data Query

```sql
-- Query historical data
select current_timestamp();

-- Set timezone to UTC for historical queries
ALTER SESSION SET TIMEZONE = 'UTC';

-- Select historical data from the cars table as of a specific timestamp
select * from cars_new before(timestamp => '2024-01-15 11:36:47.131 +0000'::timestamp);

-- Select historical data from the cars table as of 5 minutes ago
select * from cars_new at(offset => -60*4);

-- Select historical data from the cars table up to a specific statement
```

# Dropping and Restoring Objects

```sql
-- When a table, schema, or database is dropped, it is not immediately overwritten or removed from the system.
-- Instead, it is retained for the data retention period for the object, during which time the object can be restored.
-- Once dropped objects are moved to Fail-safe, you cannot restore them.

drop schema car_prem;
drop table car_prem.cars_new;
```

# Restoring Objects

```sql
-- A dropped object that has not been purged from the system (i.e. the object is displayed in the SHOW <object_type> HISTORY output)
-- can be restored using the following commands:

-- Calling UNDROP restores the object to its most recent state before the DROP command was issued.
undrop schema car_prem;
undrop database cars_new;

-- If an object with the same name already exists, UNDROP fails.
-- You must rename the existing object, which then enables you to restore the previous version of the object.
```

The provided SQL script covers database creation, table and schema management, historical data querying, dropping, and restoring objects. Each section is explained with comments for better understanding.
