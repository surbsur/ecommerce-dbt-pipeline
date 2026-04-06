with base as (
    select * from {{ ref('stg_sales') }}
)

select
    country,
    count(distinct invoice_no)          as total_orders,
    count(distinct customer_id)         as total_customers,
    round(sum(revenue), 2)              as total_revenue,
    round(avg(revenue), 2)              as avg_order_value,
    sum(quantity)                       as total_units_sold

from base
group by country
order by total_revenue desc
