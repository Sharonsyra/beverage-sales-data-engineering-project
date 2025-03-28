# Beverage Sales Data Engineering Project

## Overview

This project is a **cloud-based data engineering pipeline** for analyzing beverage sales. The pipeline ingests raw sales data, transforms it using **dbt**, and orchestrates workflows with **Kestra**. The processed data is stored in **Google BigQuery**, and insights are visualized through **Looker Studio dashboards**.

## Tech Stack

- **Orchestration**: [Kestra](https://kestra.io/) (workflow automation)
- **Transformations**: [dbt (Data Build Tool)](https://www.getdbt.com/) (data modeling and transformations)
- **Cloud Platform**: [Google Cloud Platform (GCP)](https://cloud.google.com/)
- **Infrastructure as Code**: [Terraform](https://www.terraform.io/)
- **Visualization**: [Looker Studio](https://lookerstudio.google.com/)

## Project Structure

```
.
├── README.md           # Project documentation
├── dashboard           # Looker Studio dashboards
├── dbt                 # dbt transformation logic
│   ├── beverage_sales  # dbt project directory
│   │   ├── models      # Core, marts, and staging models
│   │   ├── macros      # Custom dbt macros
│   │   ├── tests       # dbt tests
│   │   ├── seeds       # Seed data
│   │   ├── snapshots   # Snapshot tables
│   │   ├── dbt_project.yml # dbt project config
├── docker              # Docker configuration
│   └── docker-compose.yml # Services setup
├── kestra              # Kestra workflows for orchestration
│   ├── config.yml      # Kestra configuration
│   ├── flows           # Workflow definitions
│   └── data            # Ingested data
└── terraform           # Infrastructure as code
    ├── main.tf         # Terraform configuration
    ├── variables.tf    # Terraform variables
```

## Data Pipeline Workflow

1. **Data Ingestion**
   - Raw CSV data is stored in **Google Cloud Storage (GCS)**.
   - **Kestra** orchestrates ingestion into an **external BigQuery table**.
2. **Transformations with dbt**
   - The data is **cleaned, modeled, and enriched** into core fact and dimension tables.
   - Analytical tables include **customer insights, sales performance, seasonal trends, and top products**.
3. **Orchestration with Kestra**
   - Automates **data loading, transformations, and scheduled runs**.
4. **Visualization in Looker Studio**
   - Data is presented in **interactive dashboards** for analysis.

## Looker Studio Dashboards

- **[Customer Analysis Dashboard](https://lookerstudio.google.com/s/vGrY7Oto0Bc)**
- **[Sales Performance Dashboard](https://lookerstudio.google.com/s/s3OlLa5uu4c)**
- **[Top Products Dashboard](https://lookerstudio.google.com/s/geizRYsycDU)**
- **[Seasonal Trends Dashboard](https://lookerstudio.google.com/s/gZJWip1OKGE)**

## Deployment & Setup

### Prerequisites

- Google Cloud project with **BigQuery and Cloud Storage** enabled.
- Terraform installed (`brew install terraform` or [download](https://www.terraform.io/downloads)).
- Docker installed (`brew install docker` or [Docker Desktop](https://www.docker.com/products/docker-desktop)).

### Setup Instructions

1. **Clone the repository**:
   ```bash
   git clone https://github.com/Sharonsyra
   ```
2. **Deploy infrastructure with Terraform**:
   ```bash
   cd terraform
   terraform init
   terraform apply
   ```
3. **Run dbt transformations**:
   ```bash
   cd dbt/beverage_sales
   dbt run
   ```
4. **Start Kestra workflows**:
   ```bash
   cd kestra
   kestra server start
   ```
5. **Access dashboards in Looker Studio** (links above).

## Future Improvements

- Implement **data quality checks** using **Great Expectations**.
- Optimize **cost efficiency** in BigQuery storage.
- Add **real-time streaming** with Pub/Sub and Dataflow.

## Contributors

- **Sharon Waithîra** – [GitHub](https://github.com/Sharonsyra)
