
  create or replace   view JUSTIN_SMALL.dbt_demo_staging.stg_orders
  
  
  
  
  as (
    with source as (
    select * from JUSTIN_SMALL.dbt_demo.raw_orders
),

renamed as (
    select
        order_id,
        customer_id,
        product_id,
        quantity,
        cast(order_date as date)  as order_date,
        lower(status)             as status
    from source
)

select * from renamed
  );

