with base as (
    select * from {{ ref('stg_sales') }}
),

monthly as (
    select
        strftime(invoice_date, '%Y-%m')     as year_month,
        count(distinct invoice_no)          as total_orders,
        count(distinct customer_id)         as active_customers,
        round(sum(revenue), 2)              as monthly_revenue,
        sum(quantity)                       as units_sold

    from base
    group by strftime(invoice_date, '%Y-%m')
    order by year_month
)

select
    year_month,
    total_orders,
    active_customers,
    monthly_revenue,
    units_sold,
    round(sum(monthly_revenue) over (
        order by year_month
    ), 2)                               as cumulative_revenue

from monthly
