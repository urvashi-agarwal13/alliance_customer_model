{{ config(materialized='incremental', unique_key='customer_hk') }}

select distinct
  md_customer_hk as customer_hk,
  customer_id,
  load_dt,
  record_source
from {{ ref('customer') }}

{% if is_incremental() %}
where customer_id not in (select customer_id from {{ this }})
{% endif %}
