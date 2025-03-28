{{ config(materialized='table') }}

WITH distinct_dates AS (
    SELECT DISTINCT Order_Date
    FROM {{ ref('fact_sales') }}
    WHERE Order_Date IS NOT NULL
),

date_details AS (
    SELECT
        Order_Date,
        EXTRACT(YEAR FROM Order_Date) AS Year,
        EXTRACT(QUARTER FROM Order_Date) AS Quarter,
        EXTRACT(MONTH FROM Order_Date) AS Month,
        FORMAT_DATE('%B', Order_Date) AS Month_Name, -- 'January', 'February', etc.
        EXTRACT(DAYOFWEEK FROM Order_Date) AS Weekday, -- 1 (Sunday) to 7 (Saturday)
        CASE WHEN EXTRACT(DAYOFWEEK FROM Order_Date) IN (1, 7) THEN TRUE ELSE FALSE END AS is_weekend
    FROM distinct_dates
)

SELECT
    {{ dbt_utils.generate_surrogate_key(['Order_Date']) }} AS Date_ID,
    Order_Date,
    Year,
    Quarter,
    Month,
    Month_Name,
    Weekday,
    is_weekend,
    DATE_TRUNC(Order_Date, MONTH) AS Month_Year,
    CONCAT(Year, '-', 'Q', Quarter) AS Year_Quarter
FROM date_details
