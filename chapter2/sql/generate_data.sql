insert into public.urev_t2_compress
SELECT
    gs.num AS id,
    (gs.num % 10) + 1 AS category,
    random() * 100 AS value
FROM generate_series(1, 100001) AS gs(num);

insert into public.urev_t2_nocompress
SELECT
    gs.num AS id,
    (gs.num % 10) + 1 AS category,
    random() * 100 AS value
FROM generate_series(1, 100001) AS gs(num);