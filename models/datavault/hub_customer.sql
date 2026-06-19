{{ config(materialized='table') }}

select distinct
  customer_id as customer_nk,
  'raw_customers' as record_source,
   current_timestamp as load_date,
   md5(customer_id::text) as customer_hkey
   from {{ ref('raw_customers') }}
where customer_id is not null
