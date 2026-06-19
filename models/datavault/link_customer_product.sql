{{ config(materialized='table') }}

select
  customer_id,
  product_id,
  'raw_customer_products' as record_source,
  md5(customer_id::text || product_id::text) as customer_product_lkey,
  md5(customer_id::text) as customer_hkey,
  md5(product_id::text) as product_hkey,
  current_timestamp as load_date
from {{ ref('raw_customer_products') }}
where customer_id is not null
  and product_id is not null
