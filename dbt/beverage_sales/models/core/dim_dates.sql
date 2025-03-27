{{ config(materialized='table') }}

with distinct_dates as (
    select distinct Order_Date
    from {{ ref('fact_sales') }}
    where Order_Date is not null
),

date_details as (
    select
        Order_Date,
        EXTRACT(YEAR FROM Order_Date) AS Year,
        EXTRACT(QUARTER FROM Order_Date) AS Quarter,
        EXTRACT(MONTH FROM Order_Date) AS Month,
        EXTRACT(DAYOFWEEK FROM Order_Date) AS Weekday -- Returns 1 (Sunday) to 7 (Saturday)
    from distinct_dates
)

select
    {{ dbt_utils.generate_surrogate_key(['Order_Date']) }} as Date_ID,
    Order_Date,
    Year,
    Quarter,
    Month,
    Weekday
from date_details
