
    
    

with all_values as (

    select
        product_review_rank as value_field,
        count(*) as n_records

    from JUSTIN_SMALL.dbt_demo_marts.top_product_reviews
    group by product_review_rank

)

select *
from all_values
where value_field not in (
    '1','2','3'
)


