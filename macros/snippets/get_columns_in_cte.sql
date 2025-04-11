{% macro get_cte_column_names(cte_name) %}
    {% set query %}
        SELECT * FROM {{ cte_name }}
        LIMIT 0
    {% endset %}

    {% set results = run_query(query) %}
    {{ return(results.column_names) }}
{% endmacro %}
