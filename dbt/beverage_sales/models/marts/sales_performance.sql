{{
    config(
        materialized='table'
    )
}}

WITH sales_agg AS (
    SELECT
        DATE_TRUNC(Order_Date, MONTH) AS month,
        DATE_TRUNC(Order_Date, QUARTER) AS quarter,
        DATE_TRUNC(Order_Date, YEAR) AS year,
        COUNT(DISTINCT Order_ID) AS total_orders,
        SUM(Quantity) AS total_quantity,
        SUM(Total_Price) AS total_revenue
    FROM {{ ref('fact_sales') }}
    GROUP BY 1, 2, 3
)

SELECT * FROM sales_agg
