{% macro check_source_exists(schema_name, table_name) -%}

{#- On Redshift, ask the catalog directly rather than adapter.get_relation. get_relation reads dbt's relation
    cache, which fills a schema one relation at a time and marks the schema cached after the first one. A model
    on another thread can read the schema in the middle of that and get "missing" for a table that exists.
    Incremental models then fail on the dropped columns. Table models silently lose the optional part.
    Example: Mustela 2026-11-27, where the googleads convtype table was read as missing, the conversion columns
    were dropped, and the insert failed with: column "dasale" does not exist.
    The source() relation is also found when the catalog misses it, so this never says missing where the old
    check said present. -#}

{%- set src = source(schema_name, table_name) -%}

{%- if execute and target.type == 'redshift' -%}
    {%- set query -%}
        select count(*) from svv_tables
        where table_catalog = '{{ src.database | lower }}'
          and table_schema = '{{ src.schema | lower }}'
          and table_name = '{{ src.identifier | lower }}'
    {%- endset -%}
    {%- if run_query(query).columns[0].values()[0] > 0 -%}
        {{ return(true) }}
    {%- endif -%}
{%- endif -%}

{%- set source_relation = adapter.get_relation(
      database=src.database,
      schema=src.schema,
      identifier=src.identifier) -%}

{{ return(source_relation is not none) }}

{%- endmacro -%}
