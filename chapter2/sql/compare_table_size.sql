SELECT 'urev_t2_compress' as table_name,
        pg_size_pretty(pg_total_relation_size('public.urev_t2_compress')) as table_size
UNION
SELECT 'urev_t2_nocompress' as table_name,
        pg_size_pretty(pg_total_relation_size('public.urev_t2_nocompress')) as table_size;