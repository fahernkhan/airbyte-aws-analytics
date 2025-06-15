#!/bin/bash

# Build custom images
docker build -t crm-airflow:2.5.1-custom -f airflow/Dockerfile ./airflow
docker build -t crm-dbt:1.5.0-custom -f dbt/Dockerfile ./dbt
docker-compose build --no-cache

# Gunakan docker compose V2
docker compose up -d --build

