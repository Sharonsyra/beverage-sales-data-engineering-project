{{
    config(
        materialized='table'
    )
}}

SELECT 
    Product, 
    Category,
    SUM(Quantity) AS total_units_sold,
    SUM(Total_Price) AS total_revenue
FROM {{ ref('fact_sales') }}
GROUP BY 1, 2
ORDER BY total_revenue DESC
LIMIT 100
