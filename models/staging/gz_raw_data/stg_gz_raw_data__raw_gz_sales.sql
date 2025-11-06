WITH
  src AS (
    SELECT * FROM {{ source('gz_raw_data', 'raw_gz_sales') }}
  ),
  renamed AS (
    SELECT
      date_date,
      orders_id,
      pdt_id AS products_id,
      revenue,
      quantity
    FROM src
  )
SELECT * FROM renamed