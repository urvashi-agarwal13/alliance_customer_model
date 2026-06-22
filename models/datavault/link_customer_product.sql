{{ config(materialized='incremental', unique_key='customer_product_hk') }}

select distinct
  s. customer_id as customer_product_hk,
  hc.customer_hk,
  hp.product_hk,
  s.load_dt,
  s.record_source
from {{ ref('stg_customer_product') }} s
join {{ ref('hub_customer') }} hc on hc.customer_id = s.customer_id
join {{ ref('hub_product') }} hp on hp.product_id = s.product_id

{% if is_incremental() %}
where not exists (
  select 1
  from {{ this }} l
  where l.customer_hk = hc.customer_hk
    and l.product_hk = hp.product_hk
)
{% endif %}