{{ config(materialized='incremental', unique_key='customer_hk') }}

with new_rows as (
  select
    hc.customer_hk,
    s.customer_name,
    s.customer_address,
    cast(hashbytes('SHA2_256', coalesce(s.customer_name,'') + '|' + coalesce(s.customer_address,'')) as varbinary(32)) as hashdiff,
    s.load_dt as eff_start_dt,
    null as eff_end_dt,
    s.load_dt,
    s.record_source
  from {{ ref('customer') }} s
  join {{ ref('hub_customer') }} hc on hc.customer_id = s.customer_id
)

select *
from new_rows

{% if is_incremental() %}
where not exists (
  select 1
  from {{ this }} sat
  where sat.customer_hk = new_rows.customer_hk
    and sat.hashdiff = new_rows.hashdiff
    and sat.eff_end_dt is null
)
{% endif %}
