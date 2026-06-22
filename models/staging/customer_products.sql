{{ config(materialized='incremental', unique_key='customer_product_hk', incremental_strategy='merge') }}

select
  customer_id,
  product_id,
  cast(hashbytes('SHA2_256', cast(concat(customer_id, '|', product_id) as varchar(300))) as varbinary(32)) as customer_product_hk,
  load_dt,
  record_source
from {{ source('raw', 'raw_customer_product') }}
