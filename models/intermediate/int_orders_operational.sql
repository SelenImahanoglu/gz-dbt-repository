WITH orders_margin AS (
    SELECT
        orders_id,
        date_date,
        revenue,
        quantity,
        purchase_cost,
        margin
    FROM {{ ref('int_orders_margin') }}
),
shipping AS (
    SELECT
        orders_id,
        CAST(shipping_fee AS FLOAT64) AS shipping_fee,
        CAST(logistic_cost AS FLOAT64) AS logistic_cost,
        CAST(ship_cost AS FLOAT64) AS ship_cost
    FROM {{ ref('stg_gz_raw_data__raw_gz_ship') }}
)
SELECT
    om.orders_id,
    om.date_date,
    om.revenue,
    om.quantity,
    om.purchase_cost,
    om.margin,
    sh.shipping_fee,
    sh.logistic_cost,
    sh.ship_cost,
    (COALESCE(om.margin, 0)
     + COALESCE(sh.shipping_fee, 0)
     - COALESCE(sh.logistic_cost, 0)
     - COALESCE(sh.ship_cost, 0)) AS operational_margin
FROM orders_margin AS om
LEFT JOIN shipping AS sh
    ON om.orders_id = sh.orders_id