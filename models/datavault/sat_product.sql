{{ config(materialized='table') }}

select
  product_name,
  'raw_products' as record_source,
  md5(product_id::text) as product_hkey,
  md5(concat(product_id::text, product_name)) as product_hashdiff,
  current_timestamp as load_date
from {{ ref('raw_products') }}
where product_id is not null
