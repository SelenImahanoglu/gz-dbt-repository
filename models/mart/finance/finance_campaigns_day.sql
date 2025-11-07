SELECT
    f.date AS date,
    (f.total_operational_margin - IFNULL(c.total_spend, 0)) AS ads_margin,
    f.avg_cart AS average_basket,
    f.total_operational_margin AS operational_margin,
    IFNULL(c.total_spend, 0) AS ads_cost,
    IFNULL(c.total_impressions, 0) AS ads_impression,
    IFNULL(c.total_clicks, 0) AS ads_clicks,
    f.total_quantity AS quantity,
    f.total_revenue AS revenue,
    f.total_purchase_cost AS purchase_cost,
    f.total_operational_margin AS margin,
    f.total_shipping_fees AS shipping_fee,
    f.total_logistic_costs AS log_cost
FROM {{ ref('finance_days') }} AS f
LEFT JOIN {{ ref('int_campaigns_day') }} AS c
  ON f.date = c.date_date