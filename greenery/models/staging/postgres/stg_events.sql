with source as (
      select * from {{ source('postgres', 'events') }}
),
renamed as (
    select
        event_id,
        session_id,
        user_id,
        page_url,
        created_at,
        event_type,
        order_id as tgt_order_id,
        product_id as tgt_product_id

    from source
)
select * from renamed
  