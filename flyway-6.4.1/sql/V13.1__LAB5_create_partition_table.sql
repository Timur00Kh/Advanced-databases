CREATE TABLE heap_table_lab5 (
   id BIGSERIAL,
   name VARCHAR
);

CREATE TABLE partition_table (
   id BIGSERIAL,
   name VARCHAR
) PARTITION BY RANGE (id);

CREATE TABLE partition_table_1 PARTITION OF partition_table FOR VALUES FROM (0) TO (10000);
CREATE TABLE partition_table_2 PARTITION OF partition_table FOR VALUES FROM (10001) TO (20000);
CREATE TABLE partition_table_3 PARTITION OF partition_table FOR VALUES FROM (20001) TO (30000);
CREATE TABLE partition_table_4 PARTITION OF partition_table FOR VALUES FROM (30001) TO (40000);
CREATE TABLE partition_table_5 PARTITION OF partition_table FOR VALUES FROM (40001) TO (50000);
CREATE TABLE partition_table_6 PARTITION OF partition_table FOR VALUES FROM (50001) TO (60000);
CREATE TABLE partition_table_7 PARTITION OF partition_table FOR VALUES FROM (60001) TO (70000);
CREATE TABLE partition_table_8 PARTITION OF partition_table FOR VALUES FROM (70001) TO (80000);
CREATE TABLE partition_table_9 PARTITION OF partition_table FOR VALUES FROM (80001) TO (90000);
CREATE TABLE partition_table_10 PARTITION OF partition_table DEFAULT;
