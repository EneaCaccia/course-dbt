select 
    product_id,
    product_name,
    price_dollars 
from {{ref('stg_products')}}