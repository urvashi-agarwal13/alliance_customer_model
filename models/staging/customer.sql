{{ config(materialized='incremental', unique_key='customer_id', incremental_strategy='merge') }}

select
  customer_id,
  customer_name,
  customer_address,
  md5(upper(trim(customer_id))) as md_customer_hk,
  current_date() as load_dt,
  'customer' as record_source
from {{ source('SALES', 'raw_customer') }}
