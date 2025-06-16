# airbyte-aws-analytics
## 🧱 Architecture

- **Ingestion**: Airbyte imports data from various sources and stores it in the raw layer.
- **Orchestration**: Airflow manages daily pipeline execution and job monitoring.
- **Transformation**: dbt is used for model-based modular SQL transformations (bronze → silver → gold).
- **Metadata Management**: OpenMetadata manages data catalog, lineage, and observability.
- **Infrastructure**: Terraform and Kubernetes are used for provisioning and deployment.

## 📦 How to Run

```bash
docker-compose up -d