{{ config(materialized='table') }}

select distinct
  product_id as product_nk,
  'raw_products' as record_source,
   current_timestamp as load_date,
  md5(product_id::text) as product_hkey
 from {{ ref('raw_products') }}
where product_id is not null
