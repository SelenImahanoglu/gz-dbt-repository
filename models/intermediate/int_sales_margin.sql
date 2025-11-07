WITH joined AS (
  SELECT
    s.date_date AS date,
    s.orders_id,
    s.products_id,
    CAST(s.quantity AS int64) AS quantity,
    CAST(s.revenue AS float64) AS revenue,
    CAST(p.purchase_price AS float64) AS purchase_price
  FROM {{ ref('stg_gz_raw_data__raw_gz_sales') }} AS s
  LEFT JOIN {{ ref('stg_gz_raw_data__raw_gz_product') }} AS p
    ON s.products_id = p.products_id
)
SELECT
  date,
  orders_id,
  products_id,
  quantity,
  revenue,
  purchase_price,
  (quantity * purchase_price) AS purchase_cost,
  (revenue - (quantity * purchase_price)) AS margin
FROM joined