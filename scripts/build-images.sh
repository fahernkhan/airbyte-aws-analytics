#!/bin/bash

# Build custom images
docker build -t crm-airflow:2.9.3-custom -f airflow/Dockerfile ./airflow
docker build -t crm-dbt:1.8.1-custom -f dbt/Dockerfile ./dbt

# Start services using Docker Compose V2
docker compose up -d --build