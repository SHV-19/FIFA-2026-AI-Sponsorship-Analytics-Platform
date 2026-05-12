CREATE OR REPLACE VIEW FIFA_DB.MARKETING.VW_TOP_COUNTRIES AS
SELECT
    country,
    region,
    SUM(fifa_total_sales) AS total_revenue,
    SUM(fifa_operating_profit) AS total_profit,
    AVG(opportunity_score) AS avg_opportunity_score
FROM FIFA_DB.MARKETING.FACT_FIFA_FULL
GROUP BY country, region;

CREATE OR REPLACE VIEW FIFA_DB.MARKETING.VW_COMPANY_PERFORMANCE AS
SELECT
    company_name,
    SUM(fifa_total_sales) AS total_revenue,
    SUM(fifa_operating_profit) AS total_profit,
    AVG(roas) AS avg_roas,
    AVG(opportunity_score) AS avg_opportunity_score
FROM FIFA_DB.MARKETING.FACT_FIFA_FULL
GROUP BY company_name;

CREATE OR REPLACE VIEW FIFA_DB.MARKETING.VW_CUSTOMER_SEGMENTS AS
SELECT
    age_group,
    gender,
    SUM(fifa_total_sales) AS total_revenue,
    AVG(opportunity_score) AS avg_opportunity_score,
    AVG(roas) AS avg_roas
FROM FIFA_DB.MARKETING.FACT_FIFA_FULL
GROUP BY age_group, gender;