
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select review_date
from JUSTIN_SMALL.dbt_demo_staging.stg_reviews
where review_date is null



  
  
      
    ) dbt_internal_test