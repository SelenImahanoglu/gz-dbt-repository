WITH op AS (
  SELECT
    date_date,
    orders_id,
    revenue,
    quantity,
    purchase_cost,
    margin,
    shipping_fee,
    logistic_cost,
    ship_cost,
    (COALESCE(margin,0)
     + COALESCE(shipping_fee,0)
     - COALESCE(logistic_cost,0)
     - COALESCE(ship_cost,0)) AS operational_margin
  FROM {{ ref('int_orders_operational') }}
)
SELECT
  date_date                                        AS date,
  COUNT(DISTINCT orders_id)                        AS total_orders,
  SUM(revenue)                                     AS total_revenue,
  ROUND(SAFE_DIVIDE(SUM(revenue), COUNT(DISTINCT orders_id)), 2) AS avg_cart,
  SUM(operational_margin)                          AS total_operational_margin,
  SUM(purchase_cost)                               AS total_purchase_cost,
  SUM(shipping_fee)                                AS total_shipping_fees,
  SUM(logistic_cost)                               AS total_logistic_costs,
  SUM(quantity)                                    AS total_quantity
FROM op
GROUP BY date_date
ORDER BY date_date