
  create or replace   view JUSTIN_SMALL.dbt_demo_staging.stg_reviews
  
  
  
  
  as (
    with source as (
    select * from JUSTIN_SMALL.dbt_demo.raw_reviews
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
  );

