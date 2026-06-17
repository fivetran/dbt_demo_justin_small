{% test unique_daily_key_range_checksum_slice(model, partition_date, key_range_start, key_range_end) %}

select
    {{ partition_date }},
    {{ key_range_start }},
    {{ key_range_end }},
    count(*) as records
from {{ model }}
group by 1, 2, 3
having count(*) > 1

{% endtest %}
