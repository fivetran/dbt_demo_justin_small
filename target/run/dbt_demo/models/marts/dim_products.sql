
  
    

create or replace transient table JUSTIN_SMALL.dbt_demo_marts.dim_products
    
    
    
    as (with products as (
    select * from JUSTIN_SMALL.dbt_demo_staging.stg_products
),

orders as (
    select * from JUSTIN_SMALL.dbt_demo_marts.fct_orders
),

sales_stats as (
    select
        product_id,
        sum(case when status = 'completed' then quantity else 0 end)        as total_units_sold,
        sum(case when status = 'completed' then revenue_usd else 0 end)     as total_revenue_usd,
        count(distinct case when status = 'completed' then customer_id end) as unique_customers
    from orders
    group by 1
),

final as (
    select
        p.product_id,
        p.product_name,
        p.category,
        p.price_usd,
        p.is_active,
        coalesce(s.total_units_sold, 0)   as total_units_sold,
        coalesce(s.total_revenue_usd, 0)  as total_revenue_usd,
        coalesce(s.unique_customers, 0)   as unique_customers
    from products p
    left join sales_stats s using (product_id)
)

select * from final
    )
;


  