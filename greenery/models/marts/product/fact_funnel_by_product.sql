with sums as (
    select
        product_id,
        sum(page_views) page_views,
        sum(add_to_carts) add_to_carts,
        sum(checkouts) checkouts
    from
       {{ ref('fact_page_views') }}
    group by all
)
select
    sums.*,
    round(add_to_carts / page_views, 2) as conversion_to_cart,
    round(checkouts / page_views, 2) as conversion_to_checkout
from
    sums