{{ config(materialized='incremental', unique_key='product_hk') }}

with new_rows as (
  select
    hp.product_hk,
    s.product_name,
    s.product_price,
    cast(hashbytes('SHA2_256', coalesce(s.product_name,'') + '|' + coalesce(cast(s.product_price as varchar(50)),'')) as varbinary(32)) as hashdiff,
    s.load_dt as eff_start_dt,
    null as eff_end_dt,
    s.load_dt,
    s.record_source
  from {{ ref('product') }} s
  join {{ ref('hub_product') }} hp on hp.product_id = s.product_id
)

select *
from new_rows

{% if is_incremental() %}
where not exists (
  select 1
  from {{ this }} sat
  where sat.product_hk = new_rows.product_hk
    and sat.hashdiff = new_rows.hashdiff
    and sat.eff_end_dt is null
)
{% endif %}