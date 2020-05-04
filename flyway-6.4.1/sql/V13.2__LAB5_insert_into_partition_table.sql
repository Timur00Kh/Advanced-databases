INSERT INTO partition_table
SELECT random() * k, 'name' || k
FROM generate_series(0, 100000) as k(i);

INSERT INTO heap_table_lab5
SELECT random() * k, 'name' || k
FROM generate_series(0, 100000) as k(i);
