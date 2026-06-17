with source as (
    select * from {{ source('raw', 'raw_products') }}
),

renamed as (
    select
        product_id,
        product_name,
        category,
        {{ cents_to_dollars('price_cents') }}  as price_usd,
        is_active
    from source
)

select * from renamed
