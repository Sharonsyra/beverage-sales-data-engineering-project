{{
    config(
        materialized='table'
    )
}}

WITH sales AS (
    SELECT
        d.Year,
        d.Month,
        d.Month_Year,
        SUM(f.Total_Price) AS total_revenue
    FROM {{ ref('fact_sales') }} f
    JOIN {{ ref('dim_dates') }} d ON f.Order_Date = d.Order_Date
    GROUP BY 1, 2, 3
),
prev_sales AS (
    SELECT
        Year,
        Month,
        Month_Year,
        total_revenue,
        LAG(total_revenue) OVER (ORDER BY Year, Month) AS prev_month_revenue
    FROM sales
)

SELECT
    Year,
    Month,
    Month_Year,
    total_revenue,
    prev_month_revenue,
    SAFE_DIVIDE(total_revenue - prev_month_revenue, prev_month_revenue) * 100 AS month_growth_pct
FROM prev_sales
