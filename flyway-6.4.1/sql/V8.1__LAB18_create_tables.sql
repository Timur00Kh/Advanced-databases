CREATE TABLE lab18_hub (
    id BIGINT,
    name varchar
);

CREATE TABLE lab18_1 (
    hub_id BIGINT,
    name varchar
);

CREATE TABLE lab18_2 (
    hub_id BIGINT,
    name varchar
);

CREATE TABLE lab18_3 (
    hub_id BIGINT,
    name varchar
);

CREATE TABLE lab18_4 (
    hub_id BIGINT,
    name varchar
);

CREATE TABLE lab18_5 (
    hub4_id BIGINT,
    name varchar
);

INSERT INTO lab18_hub
SELECT k, 'hub text' || k FROM generate_series(1, 1000) as k(i);

INSERT INTO lab18_1
SELECT k, 'hub1 text' || k FROM generate_series(1, 1000) as k(i);

INSERT INTO lab18_2
SELECT k, 'hub2 text' || k FROM generate_series(1, 1000) as k(i);

INSERT INTO lab18_3
SELECT k, 'hub3 text' || k FROM generate_series(1, 1000) as k(i);

INSERT INTO lab18_4
SELECT k, 'hub4 text' || k FROM generate_series(1, 1000) as k(i);

INSERT INTO lab18_5
SELECT k, 'hub5 text' || k FROM generate_series(1, 1000) as k(i);

