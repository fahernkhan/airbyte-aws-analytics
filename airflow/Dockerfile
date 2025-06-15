FROM apache/airflow:2.9.3

USER root
RUN pip install --no-cache-dir \
    apache-airflow-providers-airbyte==3.6.0 \
    apache-airflow-providers-dbt-cloud==2.2.0 \
    pandasql==0.7.3 \
    fastparquet==2024.5.0 \
    pyarrow==17.0.0

USER airflow