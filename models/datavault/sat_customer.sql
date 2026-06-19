{{ config(materialized='table') }}

select
  customer_name,
  'raw_customers' as record_source,
  current_timestamp as load_date,
  md5(customer_id::text) as customer_hkey,
  md5(concat(customer_id::text, customer_name)) as customer_hashdiff
  from {{ ref('raw_customers') }}
where customer_id is not null
