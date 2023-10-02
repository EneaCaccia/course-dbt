{% set event_types = dbt_utils.get_column_values(
    table = ref('stg_events'), 
    column = 'event_type'
) %}

select
    e.session_id,
    e.user_id,
    coalesce(e.tgt_product_id, oi.product_id) as product_id,
    session_start,
    session_end,
    {%- for event_type in event_types %}
    {{ case_sum('e.event_type', event_type) }} as {{ event_type }}s,
    {%- endfor %}
    s.session_duration_minutes
from {{ ref('stg_events') }} e
left join {{ ref('stg_order_items') }} oi
    on oi.order_id = e.tgt_order_id
left join {{ ref('int_session_duration') }} s
    on s.session_id = e.session_id
group by all