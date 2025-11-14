{{ config(
    materialized = 'table',
    partition_by = {
      "field": "date_purchase",
      "data_type": "date"
    }
) }}

SELECT
    p.parcel_id,
    p.model_name,
    p.quantity,

    c.date_purchase,
    c.date_shipping,
    c.date_delivery,
    c.status,
    c.qty,
    c.nb_products,
    c.delivery_time,
    c.expedition_time,
    c.transport_time,
    c.delay,
    c.priority,
    c.transporter

FROM {{ ref('stg_cc_parcel_products') }} p
LEFT JOIN {{ ref('cc_parcel') }} c
USING (parcel_id)