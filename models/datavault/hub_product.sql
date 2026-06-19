{{ config(materialized='table') }}

select distinct
  product_id as product_nk,
  'raw_products' as record_source,
  md5(product_id::text) as product_hkey,
  current_timestamp as load_date
from {{ ref('raw_products') }}
where product_id is not null
