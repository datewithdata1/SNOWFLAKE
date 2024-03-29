-- Create a new database 
CREATE DATABASE CAR_DEKHO;

-- Switch to the newly created database
USE DATABASE CAR_DEKHO;

-- Create table to load CSV data
CREATE or replace TABLE CAR_SALE_CSV(
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

--Create integration object for external stage
create or replace storage integration s3_int
  type = external_stage
  storage_provider = s3
  enabled = true
  storage_aws_role_arn = ''
  storage_allowed_locations = ('');

--Describe integration object to fetch external_id and to be used in s3
DESC INTEGRATION s3_int;

create or replace file format CAR_DEKHO.public.csv_format
                    type = csv
                    field_delimiter = ','
                    skip_header = 1
                    null_if = ('NULL', 'null')
                    empty_field_as_null = true;
                    
create or replace stage CAR_DEKHO.public.ext_csv_stage
  URL = 's3://hjfjhhg/data/'
  STORAGE_INTEGRATION = s3_int
  file_format = CAR_DEKHO.public.csv_format;

-- Use copy command to ingest data from S3
copy into CAR_SALE_CSV
from @CAR_DEKHO.public.ext_csv_stage
on_error = CONTINUE;

select * from CAR_SALE_CSV
