{{
    config(
        materialized='table'
    )
}}

WITH sales_agg AS (
    SELECT
        d.Year,
        d.Quarter,
        d.Month,
        COUNT(DISTINCT f.Order_ID) AS total_orders,
        SUM(f.Quantity) AS total_quantity,
        SUM(f.Total_Price) AS total_revenue
    FROM {{ ref('fact_sales') }} f
    JOIN {{ ref('dim_dates') }} d ON f.Order_Date = d.Order_Date
    GROUP BY 1, 2, 3
)

SELECT * FROM sales_agg
