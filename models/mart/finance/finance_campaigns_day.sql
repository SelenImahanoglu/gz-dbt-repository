SELECT
    f.date_date AS date,
    (f.operational_margin - c.total_spend) AS ads_margin,
    f.average_basket,
    f.operational_margin,
    c.total_spend AS ads_cost,
    c.total_impressions AS ads_impression,
    c.total_clicks AS ads_clicks,
    f.quantity,
    f.revenue,
    f.purchase_cost,
    f.margin,
    f.shipping_fee,
    f.log_cost,
    f.ship_cost
FROM {{ ref('finance_days') }} AS f
LEFT JOIN {{ ref('int_campaigns_day') }} AS c
  ON f.date_date = c.date_date