{{ config(materialized='incremental', unique_key='cid', schema='silver') }}

SELECT
    CAST(CID AS VARCHAR(50)) AS cid,
    TRY_CAST(BDATE AS DATE) AS bdate,
    GEN AS gen,
    CURRENT_TIMESTAMP AS dwh_create_date
FROM {{ ref('erp_cust_az12_external') }}
WHERE CID IS NOT NULL
