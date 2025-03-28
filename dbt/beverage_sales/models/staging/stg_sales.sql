{{
    config(
        materialized='view'
    )
}}

with salesdata as
(
  SELECT *,
    row_number() over(PARTITION BY Order_ID, Customer_ID) AS rn
  FROM {{ source('staging','synthetic_beverage_sales_data') }}
  WHERE Order_ID IS NOT NULL
)
SELECT
    {{ dbt_utils.generate_surrogate_key(['Order_ID', 'Customer_ID']) }} AS Sale_ID,
    Order_ID,
    Customer_ID,
    Customer_Type,
    Product,
    Category,
    Unit_Price,
    Quantity,
    Discount,
    Total_Price,
    Region,
    Order_Date
FROM salesdata
WHERE rn = 1
