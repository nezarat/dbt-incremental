-- This is a data test: it should return zero rows when passing.
-- It flags any ids that exist in hot_storage_source but are missing in cold_storage_incremental,
-- OR where the timestamps don't match (we expect cold to have the same ts as hot for current rows).

select h.id, h.ts as hot_ts, c.ts as cold_ts
from {{ source('dbt_mariadb_storage', 'hot_storage') }} h
left join {{ ref('cold_storage_incremental') }} c
  on c.id = h.id
where c.id is null
   or c.ts <> h.ts