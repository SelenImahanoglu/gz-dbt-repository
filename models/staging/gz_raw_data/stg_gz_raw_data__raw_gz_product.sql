{{ config(enabled = false) }}
WITH
  src AS (
    SELECT * FROM {{ source('gz_raw_data', 'raw_gz_product') }}
  ),
  renamed AS (
    SELECT
      products_id,
      CAST(purchSE_PRICE AS FLOAT64) AS purchase_price
    FROM src
  )
SELECT * FROM renamed