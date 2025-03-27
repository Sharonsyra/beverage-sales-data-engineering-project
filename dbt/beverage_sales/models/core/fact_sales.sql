{{
    config(
        materialized='table'
    )
}}

select
    *
from {{ ref('stg_synthetic_beverage_sales_data') }}
