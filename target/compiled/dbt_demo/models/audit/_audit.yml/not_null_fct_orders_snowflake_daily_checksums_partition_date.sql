
    
    



select partition_date
from JUSTIN_SMALL.dbt_demo_audit.fct_orders_snowflake_daily_checksums
where partition_date is null


