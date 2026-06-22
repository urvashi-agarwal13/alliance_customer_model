{{ config(materialized='incremental', unique_key='product_id', incremental_strategy='merge') }}

select
  product_id,
  product_name,
  product_price,
  cast(hashbytes('SHA2_256', cast(product_id as varchar(200))) as varbinary(32)) as md_product_hk,
  load_dt,
  record_source
from {{ source('raw', 'raw_product') }}