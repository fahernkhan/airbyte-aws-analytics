from airflow import DAG
from airflow.providers.airbyte.operators.airbyte import AirbyteTriggerSyncOperator
from airflow.operators.bash import BashOperator
from datetime import datetime

with DAG('crm_elt', schedule_interval='@daily', start_date=datetime(2023,1,1)) as dag:
    extract = AirbyteTriggerSyncOperator(
        task_id='extract_data',
        airbyte_conn_id='airbyte_default',
        connection_id='{{ var.value.AIRBYTE_CONN_ID }}',
        timeout=3600
    )

    transform = BashOperator(
        task_id='transform_data',
        bash_command='cd /usr/app/dbt && dbt run --profiles-dir .'
    )

    test = BashOperator(
        task_id='test_data',
        bash_command='cd /usr/app/dbt && dbt test --profiles-dir .'
    )

    extract >> transform >> test