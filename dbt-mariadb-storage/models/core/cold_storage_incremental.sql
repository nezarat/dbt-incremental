{{ config(
        materialized = 'incremental',
        incremental_strategy = 'delete+insert',
        unique_key = 'id'
) }}

-- First run: load everything. Incremental: only rows that are new or have a newer ts than target.
{% if is_incremental() %}
with src as (
    select id, title, ts from {{ source('dbt_mariadb_storage', 'hot_storage') }}
), tgt as (
    select id, ts from {{ this }}
), changed as (
    select s.*
    from src s
    left join tgt t on t.id = s.id
    where t.id is null or s.ts > t.ts
)
select * from changed
{% else %}
select id, title, ts from {{ source('dbt_mariadb_storage', 'hot_storage') }}
{% endif %}