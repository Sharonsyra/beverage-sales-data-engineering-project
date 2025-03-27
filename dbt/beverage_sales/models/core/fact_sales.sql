{{
    config(
        materialized='table'
    )
}}

SELECT
    Sale_ID,
    Order_ID,
    Customer_ID,
    Product,
    Category,
    Unit_Price,
    Quantity,
    Discount,
    Total_Price,
    Region,
    Order_Date,
    EXTRACT(YEAR FROM Order_Date) AS order_year,
    EXTRACT(MONTH FROM Order_Date) AS order_month
FROM {{ ref('stg_sales') }}
