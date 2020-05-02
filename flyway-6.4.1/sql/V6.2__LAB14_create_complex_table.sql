CREATE TABLE complex_heaven (
    n complex
);

TRUNCATE complex_heaven;

INSERT INTO complex_heaven
SELECT ((random() * k)::int, ((1000 - k) * random())::int)::complex FROM
generate_series(1, 100) AS k(i);
