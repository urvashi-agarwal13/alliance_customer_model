{{ config(materialized='table') }}

select
  md5(customer_id::text) as customer_hkey,
  customer_name,
  md5(concat(customer_id::text, customer_name)) as customer_hashdiff,
  current_timestamp as load_date,
  'raw_customers' as record_source
from {{ ref('raw_customers') }}
where customer_id is not null
