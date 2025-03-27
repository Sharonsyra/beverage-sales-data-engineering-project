{{
    config(
        materialized='view'
    )
}}

with salesdata as
(
  select *,
    row_number() over(partition by Order_ID, Customer_ID) as rn
  from {{ source('staging','synthetic_beverage_sales_data') }}
  where Order_ID is not null
)
select
    {{ dbt_utils.generate_surrogate_key(['Order_ID', 'Customer_ID']) }} as Sale_ID,
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
from salesdata
where rn = 1

-- dbt build --select <model_name> --vars '{'is_test_run': 'false'}'
{% if var('is_test_run', default=true) %}

  limit 100

{% endif %}
