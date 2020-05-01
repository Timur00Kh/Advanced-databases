CREATE TABLE lab7 (
    id bigint,
    name varchar
) WITH (autovacuum_enabled = false);

INSERT INTO lab7 VALUES (1, 'first and only row');