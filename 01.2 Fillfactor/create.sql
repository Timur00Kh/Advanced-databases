CREATE TABLE f50
(
    num  int,
    text VARCHAR(100),
    date date
) WITH (FILLFACTOR = 50);

CREATE TABLE f75
(
    num  int,
    text VARCHAR(100),
    date date
) WITH (FILLFACTOR = 75);

CREATE TABLE f90
(
    num  int,
    text VARCHAR(100),
    date date
) WITH (FILLFACTOR = 90);

CREATE TABLE f100
(
    num  int,
    text VARCHAR(100),
    date date
) WITH (FILLFACTOR = 100);