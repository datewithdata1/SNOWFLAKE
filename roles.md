```sql
-- Create or replace TABLE CAR_SALE_CSV(
-- Define a table named CAR_SALE_CSV with specific column data types
CREATE OR REPLACE TABLE CAR_SALE_CSV(
   CAR_NAME          VARCHAR(128)    
   ,YEAR             NUMBER(4,0)  
   ,SELLING_PRICE    NUMBER(20,5)
   ,PRESENT_PRICE    NUMBER(20,5)
   ,KMS_DRIVE        NUMBER(20,5)
   ,FUEL_TYPE        VARCHAR(128)
   ,SELLER_TYPE      VARCHAR(128) 
   ,TRANSMISSION     VARCHAR(128)
   ,OWNER            NUMBER(5,0)
);

-- Create a custom role
-- Define a custom role named marketing_role
CREATE OR REPLACE ROLE marketing_role;

-- Grant the marketing_role the SELECT privilege on a specific table
-- Allow marketing_role to select data from the CAR_SALE_CSV table
GRANT SELECT ON TABLE CAR_SALE_CSV TO ROLE marketing_role;

-- Create a user and assign the marketing_role to the user
-- Create a user named marketing_user with a password and email
CREATE USER marketing_user PASSWORD = 'your_password';
ALTER USER marketing_user SET EMAIL='datewithdata2@gmail.com'

-- Grant the marketing_role to the marketing_user
GRANT ROLE marketing_role TO USER marketing_user;

-- Create a system role
-- Define a system role named analyst_role
CREATE ROLE analyst_role;

-- Grant the analyst_role the SELECT privilege on a different table
-- Allow analyst_role to select data from another_table in your_schema
GRANT SELECT ON TABLE your_schema.another_table TO ROLE analyst_role;

-- Assign the analyst_role to a user
-- Create a user named analyst_user with a password
CREATE USER analyst_user PASSWORD = 'your_password';

-- Grant the analyst_role to the analyst_user
GRANT ROLE analyst_role TO USER analyst_user;

-- Switch to the analyst_user
-- Change the role to analyst_user for the current session
USE ROLE analyst_user;

-- Check the current role (it should be analyst_user)
-- Display the current role to verify the role change
SHOW ROLES;

-- Revert back to the original role (e.g., ACCOUNTADMIN)
-- Switch back to the original role for the current session
USE ROLE ACCOUNTADMIN;

-- Drop the custom and system roles
-- Remove the created users and roles
DROP USER marketing_user;
DROP ROLE marketing_role;

DROP USER analyst_user;
DROP ROLE analyst_role;

-- Switch to the ORGADMIN role
-- Change the role to ORGADMIN for the current session
USE ROLE ORGADMIN;
```

This SQL script covers the creation of a table, custom roles (marketing_role), system roles (analyst_role), users (marketing_user and analyst_user), granting privileges, role switching, and role dropping. It demonstrates role-based access control and user management in Snowflake.