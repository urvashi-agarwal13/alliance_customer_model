{{ config(materialized='table') }}

select distinct
  md5(product_id::text) as product_hkey,
  product_id as product_nk,
  current_timestamp as load_date,
  'raw_products' as record_source
from {{ ref('raw_products') }}
where product_id is not null
