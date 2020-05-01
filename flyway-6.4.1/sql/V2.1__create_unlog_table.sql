BEGIN;
CREATE TABLE unlogged_table
(
    id          bigserial,
    description VARCHAR
);
ALTER TABLE unlogged_table SET UNLOGGED;
COMMIT;