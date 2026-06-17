with products as (
    select * from {{ ref('dim_products') }}
),

reviews as (
    select * from {{ ref('stg_reviews') }}
),

ranked_reviews as (
    select
        r.review_id,
        r.customer_id,
        r.product_id,
        r.order_id,
        r.rating,
        r.review_date,
        row_number() over (
            partition by r.product_id
            order by r.rating desc, r.review_date desc, r.review_id desc
        ) as product_review_rank
    from reviews r
),

final as (
    select
        p.product_id,
        p.product_name,
        p.category,
        rr.review_id,
        rr.customer_id,
        rr.order_id,
        rr.rating,
        rr.review_date,
        rr.product_review_rank
    from ranked_reviews rr
    inner join products p using (product_id)
    where rr.product_review_rank <= 3
)

select * from final
