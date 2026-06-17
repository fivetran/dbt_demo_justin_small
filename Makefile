export PYTHONWARNINGS=ignore

.PHONY: run seed reset

run:
	dbt run --profiles-dir .

seed:
	dbt seed --full-refresh --profiles-dir .

reset:
	dbt run-operation drop_marts --profiles-dir . && dbt run --profiles-dir .
