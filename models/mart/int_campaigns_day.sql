SELECT
    date_date,
    campaign_id,
    campaign_name,
    channel,
    SUM(clicks) AS total_clicks,
    SUM(impressions) AS total_impressions,
    SUM(total_spend) AS total_spend,
    SAFE_DIVIDE(SUM(clicks), SUM(impressions)) AS ctr,
    SAFE_DIVIDE(SUM(total_spend), SUM(clicks)) AS cpc,
    SAFE_DIVIDE(SUM(total_spend), SUM(impressions)) AS cpm
FROM {{ ref('int_campaigns') }}
GROUP BY
    date_date,
    campaign_id,
    campaign_name,
    channel