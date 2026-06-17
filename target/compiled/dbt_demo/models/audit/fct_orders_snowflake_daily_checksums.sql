

with orders as (
    select
        order_id,
        order_date,
        status,
        customer_id,
        customer_name,
        customer_email,
        customer_country,
        product_id,
        product_name,
        product_category,
        price_usd,
        quantity,
        revenue_usd
    from JUSTIN_SMALL.dbt_demo_marts.fct_orders
),

canonical_rows as (
    select
        order_date as partition_date,
        (floor(cast(order_id as number(38, 0)) / 10000) * 10000)::number(38, 0) as key_range_start,
        ((floor(cast(order_id as number(38, 0)) / 10000) * 10000) + 9999)::number(38, 0) as key_range_end,
        order_id,
        concat_ws(
            '|',
            'order_id=' || coalesce(to_varchar(order_id), '__dbt_null__'),
            'order_date=' || coalesce(to_varchar(order_date, 'YYYY-MM-DD'), '__dbt_null__'),
            'status=' || coalesce(status, '__dbt_null__'),
            'customer_id=' || coalesce(to_varchar(customer_id), '__dbt_null__'),
            'customer_name=' || coalesce(customer_name, '__dbt_null__'),
            'customer_email=' || coalesce(customer_email, '__dbt_null__'),
            'customer_country=' || coalesce(customer_country, '__dbt_null__'),
            'product_id=' || coalesce(to_varchar(product_id), '__dbt_null__'),
            'product_name=' || coalesce(product_name, '__dbt_null__'),
            'product_category=' || coalesce(product_category, '__dbt_null__'),
            'price_usd=' || coalesce(to_varchar(cast(price_usd as number(38, 2))), '__dbt_null__'),
            'quantity=' || coalesce(to_varchar(quantity), '__dbt_null__'),
            'revenue_usd=' || coalesce(to_varchar(cast(revenue_usd as number(38, 2))), '__dbt_null__')
        ) as canonical_row_payload
    from orders
),

aggregated as (
    select
        partition_date,
        key_range_start,
        key_range_end,
        count(*) as row_count,
        sum(quantity) as quantity_sum,
        sum(cast(revenue_usd as number(38, 2))) as revenue_usd_sum,
        min(order_id) as min_order_id,
        max(order_id) as max_order_id,
        hash_agg(canonical_row_payload) as row_hash_agg,
        sha2(
            listagg(canonical_row_payload, '\n') within group (order by order_id),
            256
        ) as checksum_sha256
    from canonical_rows
    group by 1, 2, 3
)

select
    partition_date,
    key_range_start,
    key_range_end,
    row_count,
    quantity_sum,
    revenue_usd_sum,
    min_order_id,
    max_order_id,
    row_hash_agg,
    checksum_sha256,
    current_timestamp() as checksum_generated_at
from aggregated