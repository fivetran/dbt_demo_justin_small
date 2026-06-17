
  create or replace   view JUSTIN_SMALL.dbt_demo_staging.stg_customers
  
  
  
  
  as (
    with source as (
    select * from JUSTIN_SMALL.dbt_demo.raw_customers
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
  );

