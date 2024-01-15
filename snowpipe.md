```sql
-- Create a new database 
CREATE DATABASE CAR_DEKHO;

-- Switch to the newly created database
USE DATABASE CAR_DEKHO;

-- Create table to load CSV data
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

-- Create integration object for external stage
CREATE OR REPLACE STORAGE INTEGRATION s3_int
  TYPE = EXTERNAL_STAGE
  STORAGE_PROVIDER = S3
  ENABLED = TRUE
  STORAGE_AWS_ROLE_ARN = 'arn:aws:iam::3814918:role/snoflake_snowpipe'
  STORAGE_ALLOWED_LOCATIONS = ('s3://snowpipe-datewithdata/csv_data/');

-- Describe integration object to fetch external_id and to be used in s3
DESC INTEGRATION s3_int;

-- Create file format for CSV
CREATE OR REPLACE FILE FORMAT csv_format
                    TYPE = CSV
                    FIELD_DELIMITER = ','
                    SKIP_HEADER = 1
                    NULL_IF = ('NULL', 'null')
                    EMPTY_FIELD_AS_NULL = TRUE;
                    
-- Create external stage
CREATE OR REPLACE STAGE ext_csv_stage
  URL = 's3://snowpipe-datewithdata/csv_data/'
  STORAGE_INTEGRATION = s3_int
  FILE_FORMAT = csv_format;

-- Create pipe to automate data ingestion from S3 to Snowflake
CREATE OR REPLACE PIPE mypipe AUTO_INGEST = TRUE AS
COPY INTO CAR_SALE_CSV
FROM @ext_csv_stage
ON_ERROR = CONTINUE;

-- Show created pipes
SHOW PIPES;

-- Select data from the loaded table
SELECT * FROM CAR_SALE_CSV;
```

This SQL script creates a new database, switches to it, and then sets up a table named `CAR_SALE_CSV` to load data from a CSV file. It utilizes Snowflake's external stage and integration object to fetch data from an S3 bucket. A pipe named `mypipe` is created for automated data ingestion from S3 to Snowflake. The script concludes with a query to display the content of the `CAR_SALE_CSV` table.