with source as (
      select * from {{ source('postgres', 'products') }}
),
renamed as (
    select
        product_id,
        name as product_name,
        price as price_dollars,
        inventory

    from source
)
select * from renamed
  