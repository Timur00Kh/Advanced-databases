BEGIN;
CREATE TABLE logged_table
(
    id          bigserial,
    description VARCHAR
);
ALTER TABLE logged_table SET LOGGED;
COMMIT;