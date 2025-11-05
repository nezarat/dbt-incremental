-- This macro implements the logic for incremental loading of data from hot_storage to cold_storage.
-- It checks for new rows and modifications based on the id and timestamp fields.

{% macro mariadb_incremental() %}
    {% set hot_storage_source = ref('hot_storage_source') %}
    {% set cold_storage_source = ref('cold_storage_source') %}

    insert into {{ cold_storage_source }}
    select *
    from {{ hot_storage_source }}
    where (id, timestamp) not in (
        select id, timestamp
        from {{ cold_storage_source }}
    )
    on duplicate key update
        -- Assuming you want to update all fields except the id and timestamp
        column1 = values(column1),
        column2 = values(column2),
        -- Add additional columns as necessary
        timestamp = values(timestamp)
    ;
{% endmacro %}