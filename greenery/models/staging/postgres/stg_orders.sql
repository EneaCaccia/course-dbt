with source as (
      select * from {{ source('postgres', 'orders') }}
),
renamed as (
    select
        order_id,
        user_id,
        promo_id,
        address_id,
        created_at as created_at_utc,
        
        order_cost,
        shipping_cost,
        order_total as order_total_cost,
        tracking_id,
        shipping_service as shipping_service_name,
        estimated_delivery_at as estimated_delivery_at_utc,
        delivered_at as delivered_at_utc,
        status as delivery_status

    from source
)
select * from renamed
  