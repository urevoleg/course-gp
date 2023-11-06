set gp_autostats_mode=none; --для примера отключите автоматический сбор статистики

--Создайте и наполните таблицу big_table, создайте индексы
DROP TABLE IF EXISTS big_table;
CREATE TABLE big_table
(id int, int1k int, int10k int, int100k int, int1m int, int10m int)
DISTRIBUTED BY (id);

INSERT INTO big_table (id, int1k, int10k, int100k, int1m, int10m)
SELECT
  id,
  floor(random() * 1000 + 1)::int AS int1k,
  floor(random() * 10000 + 1)::int AS int10k,
  floor(random() * 100000 + 1)::int AS int100k,
  floor(random() * 1000000 + 1)::int AS int1m,
  floor(random() * 10000000 + 1)::int AS int10m
FROM generate_series(1,100000) as id;

DROP INDEX IF EXISTS idx_big_table_int100k;
CREATE INDEX idx_big_table_int100k ON big_table USING btree (int100k);

DROP INDEX IF EXISTS idx_big_table_int1m;
CREATE INDEX idx_big_table_int1m ON big_table USING btree (int1m);

--Создайте и наполните таблицу small_table
DROP TABLE IF EXISTS small_table;
CREATE TABLE small_table
(id int, int1k int, int10k int, int100k int, int1m int, int10m int)
DISTRIBUTED BY (id);

INSERT INTO small_table (id, int1k, int10k, int100k, int1m, int10m)
SELECT *
FROM big_table
OFFSET floor(random()*100)
LIMIT floor(random()*100 + 1000);

--Создайте и наполните таблицу medium_table
DROP TABLE IF EXISTS medium_table;
CREATE TABLE medium_table
(id int, int1k int, int10k int, int100k int, int1m int, int10m int)
DISTRIBUTED BY (id);

INSERT INTO medium_table (id, int1k, int10k, int100k, int1m, int10m)
SELECT *
FROM big_table
OFFSET floor(random()*100)
LIMIT floor(random()*100 + 10000);

ANALYZE medium_table;

--Создайте и наполните партицированную таблицу partitioned_table
DROP TABLE IF EXISTS partitioned_table;
CREATE TABLE partitioned_table
(id int, int1k int, int10k int, int100k int, int1m int, int10m int)
DISTRIBUTED BY (id)
PARTITION BY RANGE (int1k)
(
DEFAULT PARTITION pdef,
PARTITION p1  START (1)   END (100),
PARTITION p2  START (101) END (200),
PARTITION p3  START (201) END (300),
PARTITION p4  START (301) END (400),
PARTITION p5  START (401) END (500),
PARTITION p6  START (501) END (600),
PARTITION p7  START (601) END (700),
PARTITION p8  START (701) END (800),
PARTITION p9  START (801) END (900),
PARTITION p10 START (901) END (1000)
);

INSERT INTO partitioned_table (id, int1k, int10k, int100k, int1m, int10m)
SELECT * FROM big_table
OFFSET floor(random()*100)
LIMIT floor(random()*100 + 100000);

ANALYZE partitioned_table;

--Создайте и наполните таблицу low_selectivity_table
DROP TABLE IF EXISTS low_selectivity_table;
CREATE TABLE low_selectivity_table
(id int, int1k int, int10k int, int100k int, int1m int, int10m int)
DISTRIBUTED BY (id);

INSERT INTO low_selectivity_table (id, int1k, int10k, int100k, int1m, int10m)
SELECT * FROM big_table
OFFSET floor(random()*100)
LIMIT floor(random()*100 + 10000);

ANALYZE low_selectivity_table;