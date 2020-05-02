INSERT INTO hub
SELECT k, k
FROM generate_series(0, 999999) AS k(i);