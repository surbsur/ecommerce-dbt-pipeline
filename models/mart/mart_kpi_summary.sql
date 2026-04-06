with country_data as (
    select * from {{ ref('int_sales_by_country') }}
),

month_data as (
    select * from {{ ref('int_sales_by_month') }}
),

totals as (
    select
        round(sum(total_revenue), 2)        as total_revenue,
        sum(total_orders)                   as total_orders,
        sum(total_customers)                as total_customers,
        round(avg(avg_order_value), 2)      as avg_order_value,
        sum(total_units_sold)               as total_units_sold
    from country_data
),

best_country as (
    select country, total_revenue
    from country_data
    order by total_revenue desc
    limit 1
),

best_month as (
    select year_month, monthly_revenue
    from month_data
    order by monthly_revenue desc
    limit 1
),

avg_monthly as (
    select round(avg(monthly_revenue), 2) as avg_monthly_revenue
    from month_data
)

select
    t.total_revenue,
    t.total_orders,
    t.total_customers,
    t.avg_order_value,
    t.total_units_sold,
    c.country                           as top_country,
    c.total_revenue                     as top_country_revenue,
    m.year_month                        as best_month,
    m.monthly_revenue                   as best_month_revenue,
    a.avg_monthly_revenue
from totals t
cross join best_country c
cross join best_month m
cross join avg_monthly a