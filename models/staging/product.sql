{{ config(materialized='incremental', unique_key='product_id', incremental_strategy='merge') }}

select
  product_id,
  product_name,
  product_price,
  md5(upper(trim(product_id))) as md_product_hk,
  current_date() as load_dt,
  'product' as record_source
from {{ source('SALES', 'raw_product') }}