{{
    config(
        materialized='table'
    )
}}

WITH first_order AS (
    SELECT Customer_ID, MIN(Order_Date) AS first_order_date
    FROM {{ ref('fact_sales') }}
    GROUP BY Customer_ID
)

SELECT
    s.Customer_ID,
    d.Order_Date,
    d.Month_Year,
    CASE
        WHEN s.Order_Date = f.first_order_date THEN 'New Customer'
        ELSE 'Returning Customer'
    END AS new_or_returning_customer,
    SUM(s.Total_Price) AS total_spent
FROM {{ ref('fact_sales') }} s
JOIN first_order f ON s.Customer_ID = f.Customer_ID
JOIN {{ ref('dim_dates') }} d ON s.Order_Date = d.Order_Date
GROUP BY 1, 2, 3, 4
