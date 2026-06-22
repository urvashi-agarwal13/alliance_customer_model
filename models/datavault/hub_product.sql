{{ config(materialized='incremental', unique_key='product_hk') }}

select distinct
  md_product_hk as product_hk,
  product_id,
  load_dt,
  record_source
from {{ ref('stg_product') }}

{% if is_incremental() %}
where product_id not in (select product_id from {{ this }})
{% endif %}