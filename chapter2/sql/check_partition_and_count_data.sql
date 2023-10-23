with info as (select tablename,
       partitiontablename as p,
       to_timestamp(REPLACE(split_part(partitionrangestart, '::', 1), '''', ''), 'YYYY-MM-DD H24:MI:SS') AS s,
       to_timestamp(REPLACE(split_part(partitionrangeend, '::', 1), '''', ''), 'YYYY-MM-DD H24:MI:SS') AS e
from pg_partitions
where tablename = 'urev_partitioned_table'),
d as  (select * from urev_partitioned_table)
select i.tablename,
       i.p,
       count(d.value_dttm) as records
from d
right join info i
on d.value_dttm >= i.s and d.value_dttm < i.e
group by i.tablename, i.p;