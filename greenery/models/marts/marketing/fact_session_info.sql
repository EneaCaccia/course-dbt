with session_duration as (
    select * from {{ ref("int_session_duration") }}
),

session_info as (
    select session_id, 
            user_id, 
            {%- for payment_method in dbt_utils.get_column_values(
                                        ref('int_session_events'),
                                                'events') %}
            sum("{{payment_method}}") as {{payment_method}}
            {%- if not loop.last %},{%- endif %}
            {%- endfor %}
    from {{ ref("int_product_session") }}
    group by all
)

select a.*, b.session_duration_minutes from session_info a 
left join session_duration b on a.session_id = b.session_id