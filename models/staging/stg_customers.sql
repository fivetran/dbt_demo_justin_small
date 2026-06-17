with source as (
    select * from {{ source('raw', 'raw_customers') }}
),

renamed as (
    select
        customer_id,
        first_name || ' ' || last_name   as full_name,
        first_name,
        last_name,
        lower(email)                     as email,
        upper(country)                   as country,
        cast(created_at as date)         as created_at
    from source
)

select * from renamed
