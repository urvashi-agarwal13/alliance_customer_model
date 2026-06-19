select
  l.customer_product_lkey,
  l.customer_hkey,
  l.product_hkey
from {{ ref('link_customer_product') }} l
left join {{ ref('hub_customer') }} hc on l.customer_hkey = hc.customer_hkey
left join {{ ref('hub_product') }} hp on l.product_hkey = hp.product_hkey
where hc.customer_hkey is null
  or hp.product_hkey is null
