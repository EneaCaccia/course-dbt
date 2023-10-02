select
    a.product_id,
    product_name,
    round(count(
        distinct case
            when checkouts >= 1 then session_id
        end
    ) / count(distinct session_id), 2) conversion_rate
from
    {{ ref("fact_page_views") }} a
    left join {{ ref("stg_products") }} b on a.product_id = b.product_id
group by all
order by conversion_rate desc