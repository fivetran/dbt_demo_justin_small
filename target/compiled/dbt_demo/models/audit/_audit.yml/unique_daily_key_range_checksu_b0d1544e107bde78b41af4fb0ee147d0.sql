

select
    partition_date,
    key_range_start,
    key_range_end,
    count(*) as records
from JUSTIN_SMALL.dbt_demo_audit.fct_orders_snowflake_daily_checksums
group by 1, 2, 3
having count(*) > 1

