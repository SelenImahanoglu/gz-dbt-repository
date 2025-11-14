{{ config(materialized='view') }}

SELECT
  Parcel_id       AS parcel_id,
  Parcel_tracking AS parcel_tracking,
  Transporter     AS transporter,
  Priority        AS priority,
  Date_purCHase   AS date_purchase,
  Date_sHIpping   AS date_shipping,
  DATE_delivery   AS date_delivery,
  DaTeCANcelled   AS date_cancelled
FROM {{ source('raw_data_circle', 'raw_cc_parcel') }};