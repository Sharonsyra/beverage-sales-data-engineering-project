{{
    config(
        materialized='table'
    )
}}

WITH sales AS (
    SELECT
        DATE_TRUNC(Order_Date, MONTH) AS month,
        SUM(Total_Price) AS total_revenue
    FROM {{ ref('fact_sales') }}
    GROUP BY 1
),
prev_sales AS (
    SELECT
        month,
        total_revenue,
        LAG(total_revenue) OVER (ORDER BY month) AS prev_month_revenue
    FROM sales
)
SELECT
    month,
    total_revenue,
    prev_month_revenue,
    SAFE_DIVIDE(total_revenue - prev_month_revenue, prev_month_revenue) * 100 AS month_growth_pct
FROM prev_sales
