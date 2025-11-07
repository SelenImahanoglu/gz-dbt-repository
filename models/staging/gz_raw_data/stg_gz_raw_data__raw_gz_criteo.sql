SELECT
  date_date,
  paid_source,
  campaign_key,
  LOWER(camPGN_name) AS campaign_name,
  SAFE_CAST(ads_cost AS FLOAT64) AS ads_cost,
  impression,
  click
FROM {{ source('gz_raw_data', 'raw_gz_criteo') }}