select
  customer_id,
  product_id
from {{ ref('customer_products') }}
