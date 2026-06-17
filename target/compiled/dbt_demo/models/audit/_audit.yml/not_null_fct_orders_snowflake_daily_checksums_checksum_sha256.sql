
    
    



select checksum_sha256
from JUSTIN_SMALL.dbt_demo_audit.fct_orders_snowflake_daily_checksums
where checksum_sha256 is null


