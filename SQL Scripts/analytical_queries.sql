-- Row count validation
SELECT COUNT(*) AS total_rows
FROM FIFA_DB.MARKETING.FACT_FIFA_FULL;

-- Top countries by revenue
SELECT 
    country,
    SUM(fifa_total_sales) AS total_revenue
FROM FIFA_DB.MARKETING.FACT_FIFA_FULL
GROUP BY country
ORDER BY total_revenue DESC
LIMIT 10;

-- Revenue by region
SELECT 
    region,
    SUM(fifa_total_sales) AS total_revenue
FROM FIFA_DB.MARKETING.FACT_FIFA_FULL
GROUP BY region
ORDER BY total_revenue DESC;

-- Company performance
SELECT 
    company_name,
    SUM(fifa_total_sales) AS total_revenue,
    SUM(fifa_operating_profit) AS total_profit,
    AVG(opportunity_score) AS avg_opportunity_score
FROM FIFA_DB.MARKETING.FACT_FIFA_FULL
GROUP BY company_name
ORDER BY total_revenue DESC;

-- Top opportunity markets
SELECT 
    country,
    region,
    SUM(fifa_total_sales) AS total_revenue,
    AVG(opportunity_score) AS avg_opportunity_score
FROM FIFA_DB.MARKETING.FACT_FIFA_FULL
GROUP BY country, region
ORDER BY avg_opportunity_score DESC
LIMIT 10;

-- Country-level opportunity vs revenue
SELECT
    country,
    region,
    SUM(fifa_total_sales) AS total_revenue,
    AVG(opportunity_score) AS avg_opportunity_score,
    SUM(fifa_units_sold) AS total_units_sold
FROM FIFA_DB.MARKETING.FACT_FIFA_FULL
GROUP BY country, region
ORDER BY total_revenue DESC;

-- Customer segment performance
SELECT
    age_group,
    gender,
    SUM(fifa_total_sales) AS total_revenue,
    AVG(opportunity_score) AS avg_opportunity_score
FROM FIFA_DB.MARKETING.FACT_FIFA_FULL
GROUP BY age_group, gender
ORDER BY total_revenue DESC;

-- Marketing performance
SELECT
    company_name,
    AVG(roas) AS avg_roas,
    AVG(conversion_rate) AS avg_conversion_rate,
    SUM(campaign_spend) AS total_campaign_spend
FROM FIFA_DB.MARKETING.FACT_FIFA_FULL
GROUP BY company_name
ORDER BY avg_roas DESC;

-- High opportunity records
SELECT
    country,
    company_name,
    region,
    opportunity_score,
    fifa_total_sales
FROM FIFA_DB.MARKETING.FACT_FIFA_FULL
WHERE high_opportunity = 1
ORDER BY opportunity_score DESC
LIMIT 25;