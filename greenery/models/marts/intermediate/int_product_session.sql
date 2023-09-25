select session_id,
    user_id,
    tgt_product_id,
    {{ dbt_utils.pivot(
        'event_type',
        dbt_utils.get_column_values(
            ref('stg_events'),
            'event_type')
        )
     }}
from {{ ref('stg_events') }}
group by all