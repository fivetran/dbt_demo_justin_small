with customers as (
    select * from {{ ref('stg_customers') }}
),

orders as (
    select * from {{ ref('fct_orders') }}
),

order_stats as (
    select
        customer_id,
        count(*)                                                        as total_orders,
        count(case when status = 'completed' then 1 end)               as completed_orders,
        sum(case when status = 'completed' then revenue_usd else 0 end) as total_revenue_usd,
        min(order_date)                                                 as first_order_date,
        max(order_date)                                                 as most_recent_order_date
    from orders
    group by 1
),

final as (
    select
        c.customer_id,
        c.full_name,
        c.email,
        c.country,
        c.created_at                         as customer_since,
        coalesce(s.total_orders, 0)          as total_orders,
        coalesce(s.completed_orders, 0)      as completed_orders,
        coalesce(s.total_revenue_usd, 0)     as total_revenue_usd,
        s.first_order_date,
        s.most_recent_order_date,
        case
            when coalesce(s.total_revenue_usd, 0) >= 200 then 'High'
            when coalesce(s.total_revenue_usd, 0) >= 50  then 'Medium'
            else 'Low'
        end                                  as customer_segment
    from customers c
    left join order_stats s using (customer_id)
)

select * from final
