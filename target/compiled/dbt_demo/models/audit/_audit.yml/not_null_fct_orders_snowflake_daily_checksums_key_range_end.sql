
    
    



select key_range_end
from JUSTIN_SMALL.dbt_demo_audit.fct_orders_snowflake_daily_checksums
where key_range_end is null


