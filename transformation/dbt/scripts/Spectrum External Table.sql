CREATE EXTERNAL TABLE spectrum.erp_cust_az12 (
  _airbyte_raw_id VARCHAR,
  cid VARCHAR,
  bdate VARCHAR,
  gen VARCHAR
)
PARTITIONED BY (year INT, month INT, day INT)
STORED AS PARQUET
LOCATION 's3://v1-data-lake/bronze/erp/cust_az12/';