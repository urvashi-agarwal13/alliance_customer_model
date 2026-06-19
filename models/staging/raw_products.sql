select
  product_id,
  product_name
from {{ ref('products') }}
