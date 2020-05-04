INSERT INTO clustered_table
SELECT k, random() * 50000
FROM generate_series(0, 10000) AS k(i);

ANALYZE clustered_table;