
  
    

create or replace transient table JUSTIN_SMALL.dbt_demo_marts.fct_orders
    
    
    
    as (with orders as (
    select
        order_id,
        order_date,
        status,
        customer_id,
        product_id,
        quantity
    from JUSTIN_SMALL.dbt_demo_staging.stg_orders
),

customers as (
    select
        customer_id,
        full_name,
        email,
        country
    from JUSTIN_SMALL.dbt_demo_staging.stg_customers
),

products as (
    select
        product_id,
        product_name,
        category,
        price_usd
    from JUSTIN_SMALL.dbt_demo_staging.stg_products
),

joined as (
    select
        o.order_id,
        o.order_date,
        o.status,

        -- Customer fields
        o.customer_id,
        c.full_name               as customer_name,
        c.email                   as customer_email,
        c.country                 as customer_country,

        -- Product fields
        o.product_id,
        p.product_name,
        p.category                as product_category,
        p.price_usd,

        -- Metrics
        o.quantity,
        o.quantity * p.price_usd  as revenue_usd
    from orders o
    left join customers c on o.customer_id = c.customer_id
    left join products  p on o.product_id  = p.product_id
)

select * from joined
    )
;


  