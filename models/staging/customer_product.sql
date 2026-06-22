{{ config(materialized='incremental', unique_key='customer_product_hk', incremental_strategy='merge') }}

select
  customer_id,
  product_id,
  cast(hashbytes('SHA2_256', cast(concat(customer_id, '|', product_id) as varchar(300))) as varbinary(32)) as customer_product_hk,
  current_date() as load_dt,
  'customer_product' as record_source
from {{ source('SALES', 'raw_customer_product') }}
