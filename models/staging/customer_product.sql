{{ config(materialized='incremental', unique_key='customer_product_hk', incremental_strategy='merge') }}

select
  customer_id,
  product_id,
  to_binary(md5(customer_id || '|' || product_id)) as customer_product_hk,
  current_date() as load_dt,
  'customer_product' as record_source
from {{ source('SALES', 'raw_customer_product') }}
