
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select product_id
from JUSTIN_SMALL.dbt_demo_marts.top_product_reviews
where product_id is null



  
  
      
    ) dbt_internal_test