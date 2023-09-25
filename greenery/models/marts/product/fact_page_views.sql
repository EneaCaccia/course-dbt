with product_views as (
    select 
        tgt_product_id product_id,
        sum("page_view") as page_views,
        sum("add_to_cart") as add_to_cart
    from {{ ref("int_product_session") }}
    where tgt_product_id is not null
    group by all
),

orders as (
    select product_id, sum(order_quantity) total_order_num from {{ ref("stg_order_items") }}
    group by all
)

select  
    a.product_id, 
    page_views,
    add_to_cart,
    total_order_num,
    round(add_to_cart/nullif(page_views, 0), 3) view_conversions,
    round(add_to_cart/nullif(total_order_num, 0), 3) cart_conversions
from product_views a
left join orders b on a.product_id = b.product_id