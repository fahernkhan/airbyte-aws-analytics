DROP TABLE IF EXISTS bronze.erp_cust_az12;

CREATE TABLE bronze.erp_cust_az12 (
    _airbyte_raw_id         VARCHAR,
    _airbyte_extracted_at   TIMESTAMP,
    _airbyte_meta           VARCHAR,
    _airbyte_generation_id  VARCHAR,
    cid                     VARCHAR,
    gen                     VARCHAR,
    bdate                   DATE
);
