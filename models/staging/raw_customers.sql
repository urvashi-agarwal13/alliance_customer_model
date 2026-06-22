{{ config(materialized='incremental', unique_key='customer_id', incremental_strategy='merge') }}

select
  customer_id,
  customer_name,
  customer_address,
  cast(hashbytes('SHA2_256', cast(customer_id as varchar(200))) as varbinary(32)) as md_customer_hk,
  load_dt,
  record_source
from {{ source('raw', 'raw_customer') }}
