
  create or replace   view JUSTIN_SMALL.dbt_demo_staging.stg_products
  
  
  
  
  as (
    with source as (
    select * from JUSTIN_SMALL.dbt_demo.raw_products
),

renamed as (
    select
        product_id,
        product_name,
        category,
        
    round(price_cents / 100.0, 2)
  as price_usd,
        is_active
    from source
)

select * from renamed
  );

