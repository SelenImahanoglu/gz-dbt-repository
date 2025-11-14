{{ config(materialized='table') }}

WITH nb_products_parcel AS (
    SELECT
        parcel_id,
        SUM(quantity) AS qty,
        COUNT(DISTINCT model_name) AS nb_products
    FROM {{ ref('stg_cc_parcel_products') }}
    GROUP BY parcel_id
)

SELECT
    p.parcel_id,

    p.parcel_tracking,
    p.transporter,
    p.priority,

    p.date_purchase,
    p.date_shipping,
    p.date_delivery,
    p.date_cancelled,

    EXTRACT(MONTH FROM p.date_purchase) AS month_purchase,

    CASE
        WHEN p.date_cancelled IS NOT NULL THEN 'İptal Edildi'
        WHEN p.date_shipping IS NULL THEN 'Devam Ediyor'
        WHEN p.date_delivery IS NULL THEN 'Taşınıyor'
        ELSE 'Teslim Edildi'
    END AS status,

    DATE_DIFF(p.date_shipping, p.date_purchase, DAY) AS expedition_time,
    DATE_DIFF(p.date_delivery, p.date_shipping, DAY) AS transport_time,
    DATE_DIFF(p.date_delivery, p.date_purchase, DAY) AS delivery_time,

    CASE 
        WHEN p.date_delivery IS NULL THEN NULL
        WHEN DATE_DIFF(p.date_delivery, p.date_purchase, DAY) > 5 THEN 1
        ELSE 0
    END AS delay,

    n.qty,
    n.nb_products

FROM {{ ref('stg_cc_parcel') }} p
LEFT JOIN nb_products_parcel n
USING (parcel_id)