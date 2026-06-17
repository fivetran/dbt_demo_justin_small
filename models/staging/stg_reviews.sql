with source as (
    select * from {{ source('raw', 'raw_reviews') }}
),

renamed as (
    select
        review_id,
        customer_id,
        product_id,
        order_id,
        rating,
        review_date
    from source
)

select * from renamed
