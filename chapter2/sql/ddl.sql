CREATE TABLE public.urev_t2_compress (
    id int,
    category int,
    value float
)
WITH (appendoptimized=TRUE,
    compresstype=zstd,
    compresslevel=2);

CREATE TABLE public.urev_t2_nocompress (
    id int,
    category int,
    value float
)
WITH (appendoptimized=TRUE);