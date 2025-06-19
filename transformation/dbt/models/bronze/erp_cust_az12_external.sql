{{ config(materialized='view', schema='external') }}

SELECT
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    _airbyte_generation_id,
    CID,
    BDATE,
    GEN
FROM spectrum.erp_cust_az12
