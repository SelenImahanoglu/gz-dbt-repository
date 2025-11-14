{{ config(materialized='view') }}

SELECT
  ParCEL_id    AS parcel_id,
  Model_mAME   AS model_name,
  QUANTITY     AS quantity
FROM {{ source('raw_data_circle', 'raw_cc_parcel_product') }};