{% macro drop_marts() %}
  {% set schemas = ['dbt_demo_marts', 'dbt_demo_staging'] %}
  {% for schema in schemas %}
    {% set drop_sql %}
      DROP SCHEMA IF EXISTS {{ target.database }}.{{ schema }} CASCADE
    {% endset %}
    {% do run_query(drop_sql) %}
    {{ log("Dropped schema: " ~ schema, info=True) }}
  {% endfor %}
{% endmacro %}
