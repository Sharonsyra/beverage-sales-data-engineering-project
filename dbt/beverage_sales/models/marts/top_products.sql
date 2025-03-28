{{
    config(
        materialized='table'
    )
}}

SELECT 
    f.Product,
    f.Category,
    d.Month_Year,
    SUM(f.Quantity) AS total_units_sold,
    SUM(f.Total_Price) AS total_revenue
FROM {{ ref('fact_sales') }} f
    JOIN {{ ref('dim_dates') }} d ON f.Order_Date = d.Order_Date
GROUP BY 1, 2, 3
ORDER BY total_revenue DESC
