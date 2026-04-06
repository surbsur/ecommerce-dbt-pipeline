# E-Commerce Sales Analytics Pipeline

![dbt](https://img.shields.io/badge/dbt-1.11-orange) ![DuckDB](https://img.shields.io/badge/DuckDB-1.10-yellow) ![Python](https://img.shields.io/badge/Python-3.13-blue) ![SQL](https://img.shields.io/badge/SQL-DuckDB-lightgrey)

An end-to-end data engineering pipeline built with **dbt** and **DuckDB**, transforming 541,909 raw retail transactions into clean, business-ready analytics models.

This is **Project 2** in a two-project portfolio built on the same UK e-commerce dataset:


| **Project 2 — dbt Pipeline (this repo)** | Engineering pipeline — *how do we track it consistently?* | dbt, DuckDB, SQL, Python |

> Note: Revenue figures differ slightly between projects due to different cleaning rules applied at the staging layer.

---

## Pipeline Architecture

Raw Data (541,909 rows)
└── stg_sales                    <- clean, validate, calculate revenue
├── int_sales_by_country <- aggregate by market
├── int_sales_by_month   <- aggregate by month + cumulative revenue
└── mart_kpi_summary     <- final business KPIs

### Layer Design

| Layer | Model | Purpose |
|-------|-------|---------|
| Staging | stg_sales | Remove cancellations, negatives, nulls. Cast types. Calculate revenue. |
| Intermediate | int_sales_by_country | Revenue, orders, customers, avg order value per country |
| Intermediate | int_sales_by_month | Monthly revenue, active customers, cumulative revenue |
| Mart | mart_kpi_summary | Single-row KPI summary for dashboards |

---

## Key Business Insights

| Metric | Value |
|--------|-------|
| Total Revenue | £10,666,684 |
| Total Orders | 19,960 |
| Total Customers | 4,346 |
| Average Order Value | £38.73 |
| Total Units Sold | 5,588,376 |
| Top Market | United Kingdom — £9,025,222 (85% of revenue) |
| Best Month | November 2011 — £1,509,496 |
| Avg Monthly Revenue | £820,514 |

### What the pipeline revealed

- **UK dependency:** 85% of revenue comes from one market. All other 36 countries combined contribute just 15% — a concentration risk worth monitoring.
- **High-value international buyers:** Netherlands (£121 avg order) and Australia (£117) significantly outperform the UK (£18.60), suggesting wholesale purchasing behaviour from international customers.
- **Seasonal peak:** Revenue nearly doubled between August and November 2011. September to November alone contributed 35% of full-year revenue — consistent with pre-Christmas retail demand.
- **December anomaly:** Sharp drop in December 2011 likely reflects incomplete data rather than a real decline — an example of the kind of data quality flag a pipeline should surface automatically.

---

## Project Structure

ecommerce-dbt-pipeline/
├── models/
│   ├── staging/
│   │   └── stg_sales.sql
│   ├── intermediate/
│   │   ├── int_sales_by_country.sql
│   │   └── int_sales_by_month.sql
│   └── mart/
│       └── mart_kpi_summary.sql
├── exports/
│   ├── kpi_summary.csv
│   ├── sales_by_country.csv
│   └── sales_by_month.csv
├── seeds/
│   └── sales.csv              <- excluded from git (541k rows)
├── dbt_project.yml
└── README.md

---

## How to Run This Project

### Prerequisites
- Python 3.9+
- Git

### Setup

**1. Clone the repo:**

git clone https://github.com/surbsur/ecommerce-dbt-pipeline.git
cd ecommerce-dbt-pipeline

**2. Create and activate a virtual environment:**
python3 -m venv dbt-env
source dbt-env/bin/activate

**3. Install dependencies:**
pip install dbt-core dbt-duckdb pandas openpyxl

**4. Add source data:**
Download the UCI Online Retail dataset and save it as seeds/sales.csv.

**5. Load data into DuckDB:**
dbt seed

**6. Run the pipeline:**
dbt run

**7. Export results to CSV:**
python3 export.py

---

## Tools and Technologies

| Tool | Version | Purpose |
|------|---------|---------|
| dbt Core | 1.11 | Data transformation and pipeline orchestration |
| DuckDB | 1.10 | Local analytical database |
| Python | 3.13 | Data conversion and export scripts |
| pandas | latest | Excel to CSV conversion |
| SQL | — | All transformation logic |
| Git / GitHub | — | Version control |

---

## Author

**Surya Surendran**
M.Sc. E-Government, University of Koblenz, Germany

[LinkedIn](https://linkedin.com/in/surya-surendran-aab448200) | [GitHub](https://github.com/surbsur) | [Project 1 — SQL Sales Analysis](https://github.com/surbsur/sql-sales-analysis)
