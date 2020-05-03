CREATE EXTENSION IF NOT EXISTS pg_trgm;

CREATE TABLE lab19_gin (
    id integer,
    content varchar
);

CREATE INDEX ON public.lab19_gin USING gin(content gin_trgm_ops);

CREATE TABLE lab19_btree (
    id integer,
    content varchar
);

CREATE INDEX ON lab19_btree USING btree(content varchar_pattern_ops);


CREATE TABLE lab19_gist (
    id integer,
    content varchar
);

CREATE INDEX ON lab19_gist USING gist(content gist_trgm_ops);



INSERT INTO lab19_gin
SELECT k, 'text' || (random() * 100)::integer || ' lab19_gin'FROM generate_series(1, 100000) as k(i);

INSERT INTO lab19_btree
SELECT k, 'text' || (random() * 100)::integer || ' lab19_btree'FROM generate_series(1, 100000) as k(i);

INSERT INTO lab19_gist
SELECT k, 'text' || (random() * 100)::integer || ' lab19_gist'FROM generate_series(1, 100000) as k(i);

