{{ config(materialized='table') }}

select
  md5(product_id::text) as product_hkey,
  product_name,
  md5(concat(product_id::text, product_name)) as product_hashdiff,
  current_timestamp as load_date,
  'raw_products' as record_source
from {{ ref('raw_products') }}
where product_id is not null
