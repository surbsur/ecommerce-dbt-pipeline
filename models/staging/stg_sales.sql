with source as (
    select * from {{ ref('sales') }}
),

cleaned as (
    select
        InvoiceNo                                    as invoice_no,
        StockCode                                    as stock_code,
        trim(Description)                            as description,
        cast(Quantity as integer)                    as quantity,
        cast(InvoiceDate as date)                    as invoice_date,
        cast(UnitPrice as double)                    as unit_price,
        cast(CustomerID as varchar)                  as customer_id,
        trim(Country)                                as country,
        round(cast(Quantity as double) * cast(UnitPrice as double), 2) as revenue

    from source

    where
        cast(Quantity as integer) > 0
        and cast(UnitPrice as double) > 0
        and InvoiceNo not like 'C%'
        and Description is not null
)

select * from cleaned
