# Brazilian E-Commerce (Olist) End-to-End Market Dynamics and Customer Segmentation

An end-to-end data analytics project evaluating transactional performance, customer retention, logistics impact on review scores, and RFM customer segmentation across 100k+ orders using PostgreSQL and Python.

---

## Executive Summary
* **Marketplace Decentralization:** The top 10 sellers collectively contribute under 15% of total platform revenue, indicating a healthy, non-monopolistic vendor ecosystem.
* **Logistics SLA Impact on CSAT:** Late deliveries reduce the average review score from 4.29 to 2.57, spiking bad reviews (<= 2 stars) from 9.23% to 54.03% (a nearly 6x increase in churn risk).
* **Customer Retention Challenge:** 97.00% of unique customers are one-time buyers. Monthly cohort retention drops below 1.0% by Month 1, confirming an acquire-and-churn transactional marketplace model.
* **Category Drivers:** `health_beauty`, `watches_gifts`, and `bed_bath_table` lead overall gross merchandise value (GMV), generating over 1M BRL each.

---

## Executive Visualizations

### 1. Executive Market Dynamics Dashboard
![Brazilian E-Commerce Executive Dashboard](./olist_executive_dashboard.png)

### 2. Monthly Cohort Retention Heatmap
![Cohort Retention Matrix](./olist_cohort_retention.png)
---

## Tech Stack and Workflow
* **Database Layer (PostgreSQL):** Relational schema setup (9 tables), DDL indexing, multi-table joins, aggregations, and window functions (`LAG`, `OVER()`, `FILTER`).
* **Analytics Layer (Python):** `pandas`, `numpy`, `SQLAlchemy`, RFM customer segmentation scoring, and monthly cohort retention matrix modeling.
* **Visualization Layer:** `matplotlib` and `seaborn` with minimalist styling for executive decision-making.

---

## Repository Structure
```text
├── analysis_data.sql                   # Advanced business KPI SQL queries
├── cleaning_data.sql                   # Schema creation and ingestion DDL
├── notebook.ipynb                      # RFM segmentation and cohort analysis
├── olist_executive_dashboard.png       # Executive visual asset
└── README.md

## Dataset Source
The raw data used in this project is the Brazilian E-Commerce Public Dataset by Olist, available publicly on [Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce).
