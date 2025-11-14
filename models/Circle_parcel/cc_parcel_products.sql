{{ config(materialized='table') }}

SELECT
    parcel_id,
    model_name,
    quantity
FROM {{ ref('stg_cc_parcel_products') }}