##TOTAL REVENUE
##ByCountry

SELECT 
    country,
    SUM(fifa_total_sales) AS total_revenue
FROM FIFA_DB.MARKETING.FACT_FIFA_FULL
GROUP BY country
ORDER BY total_revenue DESC
LIMIT 10;

##TOTAL REVENUE
##ByRegion

SELECT 
    region,
    SUM(fifa_total_sales) AS total_revenue
FROM FIFA_DB.MARKETING.FACT_FIFA_FULL
GROUP BY region
ORDER BY total_revenue DESC;

##Opportunity Score

SELECT
    country,
    AVG(opportunity_score) AS avg_opportunity_score
FROM FIFA_DB.MARKETING.FACT_FIFA_FULL
GROUP BY country
ORDER BY avg_opportunity_score DESC
LIMIT 10;
