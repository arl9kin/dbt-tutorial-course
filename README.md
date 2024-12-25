# Data Insights Project: Advanced dbt Modeling in BigQuery with Looker Studio Visualization
This repository (repo) is build on top of the project within the scope of ([link here](https://www.udemy.com/course/mastering-dbt-data-build-tool-bootcamp/?referralCode=FFF494163B7B9E5E846F)). But I decided to enhance it to full pet-project.

## Project Description

This project is my first dbt project, which emphasizes data modeling using dbt in Google BigQuery, aiming to manage and analyze ([theLook eCommerce](https://console.cloud.google.com/bigquery(cameo:product/bigquery-public-data/thelook-ecommerce)?hl=ru&inv=1&invt=AblDyA&project=winged-precept-406816)) data effectively. The Looker Studio dashboard enhances the model's practicality by providing visual interpretations of the data insights.

## Key Features
- **dbt Modeling**: Centerpiece of the project focusing on transforming raw data into analytics-ready structures as well as applying testing, macros and documentation.
- **Visual Analytics**: Secondary yet insightful, the Looker Studio dashboard offers a graphical representation of the processed data.

## Architecture Overview
Here's how the project flows:
- **Data Source:** theLook eCommerce public data stored in Google BigQuery. More details: ([source definition](https://github.com/arl9kin/dbt-tutorial-course/blob/main/lessons/models/staging/scr_ecommerce.yml))
- **Primary Focus - dbt Modeling:** Transformational dbt models that cleanse, organize, and enrich raw data making it ready for deep analytics.
- **Supporting Component - Visualization:** A comprehensive ([Looker Studio Dashboard](https://lookerstudio.google.com/s/hpIVwJ3ljsU)) that leverages the dbt models to display key metrics.
![High Level Architecture](https://github.com/arl9kin/dbt-tutorial-course/blob/main/files/arhitecture.drawio.png?raw=true)

## dbt Data Modeling
- Leveraging a Medallion-like architecture, this project implements dbt to sequentially transform data through three layers—Bronze for initial cleaning, Silver for detailed business logic application, and Gold for final refinements with rigorous testing—to ensure the highest data quality for reporting in Looker Studio.
- Powerfull dbt's features like tests, ([documentation](https://ih107.us1.dbt.com/accounts/70471823409407/jobs/70471823411326/docs/#!/overview)) (avaliable after sign in to DBT account) are also a part of the project.

![Data Model](https://github.com/arl9kin/dbt-tutorial-course/blob/main/files/dbt-dag.png?raw=true)

## Dashboard Overview
While secondary, the dashboard in Looker Studio adds value by:
- Graphically displaying outcomes from dbt models.
- Enabling interactive exploration of data trends over time.
- Highlighting areas of interest like order fulfillment efficiency and customer engagement metrics.
