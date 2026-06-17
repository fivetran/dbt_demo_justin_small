
    
    

select
    email as unique_field,
    count(*) as n_records

from JUSTIN_SMALL.dbt_demo.raw_customers
where email is not null
group by email
having count(*) > 1


