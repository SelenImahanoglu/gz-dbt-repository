{{ config(enabled = false) }}
SELECT
    date_date,
    campaign_key,
    campaign_name,
    paid_source,
    SUM(click) AS total_clicks,
    SUM(impression) AS total_impressions,
    SUM(ads_cost) AS total_spend,
    SAFE_DIVIDE(SUM(click), SUM(impression)) AS ctr,          
    SAFE_DIVIDE(SUM(ads_cost), SUM(click)) AS cpc,            
    SAFE_DIVIDE(SUM(ads_cost), SUM(impression)) AS cpm      
FROM {{ ref('int_campaigns') }}
GROUP BY
    date_date,
    campaign_key,
    campaign_name,
    paid_source