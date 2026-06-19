{{ config(materialized='table') }}

select distinct
  md5(customer_id::text) as customer_hkey,
  customer_id as customer_nk,
  current_timestamp as load_date,
  'raw_customers' as record_source
from {{ ref('raw_customers') }}
where customer_id is not null
