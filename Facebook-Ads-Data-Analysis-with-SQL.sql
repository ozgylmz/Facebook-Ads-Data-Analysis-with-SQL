SELECT * FROM facebook_ads_basic_daily;

--toplam maliyet
SELECT ad_date, campaign_id,sum(spend) AS total_cost
FROM facebook_ads_basic_daily
GROUP BY ad_date, campaign_id 
ORDER BY 1;

--gösterim sayısı
SELECT ad_date, campaign_id,sum(impressions) AS total_impressions
FROM facebook_ads_basic_daily
GROUP BY ad_date, campaign_id 
ORDER BY 1;

--tıklama sayısı
SELECT ad_date, campaign_id,sum(clicks) AS total_clicks
FROM facebook_ads_basic_daily
GROUP BY ad_date, campaign_id 
ORDER BY 1;

--total value değeri
SELECT ad_date, campaign_id,sum(value) AS total_value
FROM facebook_ads_basic_daily
GROUP BY ad_date, campaign_id 
ORDER BY 1;

--toplu gösterim
SELECT ad_date, campaign_id,
sum(spend) AS total_cost,
sum(clicks) AS total_clicks,
sum(impressions) AS total_impressions,
sum(value) AS total_value 
FROM facebook_ads_basic_daily
GROUP BY ad_date, campaign_id 
ORDER BY 1;

------------------------------------

--CPC (cost per click)
SELECT ad_date, campaign_id, 
sum(spend) / sum(clicks) AS CPC FROM facebook_ads_basic_daily
WHERE clicks <> 0 AND clicks IS NOT NULL
GROUP BY ad_date, campaign_id
ORDER BY 1;

--CPM (cost per millie)
SELECT ad_date, campaign_id, 
round(sum(spend)::NUMERIC /sum(impressions)::NUMERIC,2) * 1000  AS CPM FROM facebook_ads_basic_daily
WHERE impressions <> 0 AND impressions IS NOT NULL
GROUP BY ad_date, campaign_id
ORDER BY 1;

--CTR (click through rate)
SELECT ad_date, campaign_id,
round(sum(clicks)::NUMERIC / sum(impressions)::NUMERIC,2)*100 AS CTR FROM facebook_ads_basic_daily
WHERE impressions <> 0 AND impressions IS NOT NULL
GROUP BY ad_date, campaign_id
ORDER BY 1

--ROMI (return on marketing investments)
SELECT ad_date, campaign_id,
round((SUM(value)::NUMERIC - SUM(spend)::NUMERIC) / SUM(spend)::NUMERIC,2) * 100 AS ROMI FROM facebook_ads_basic_daily
WHERE spend <> 0 AND spend IS NOT NULL
GROUP BY ad_date, campaign_id
ORDER BY 1

---------------------------------------

--toplam harcaması 500.000'den fazla olan kampanyalar arasında en yüksek ROMI'ye sahip kampanya
SELECT campaign_id,sum(spend) AS total_cost,
round((SUM(value)::NUMERIC - SUM(spend)::NUMERIC) / SUM(spend)::NUMERIC,2) * 100 AS ROMI
FROM facebook_ads_basic_daily
WHERE spend <> 0 AND spend IS NOT NULL
GROUP BY campaign_id 
HAVING sum(spend) > 500000
ORDER BY ROMI DESC LIMIT 1

