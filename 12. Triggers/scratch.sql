CREATE TABLE hub (
                     id SERIAL PRIMARY KEY,
                     melon_amount int
);

CREATE OR REPLACE FUNCTION bf_insert()
    RETURNS TRIGGER AS
$$
DECLARE
    pa       bigint = 100000; --partition tuples amount
    table_id int    = ceil((NEW.id / pa));
BEGIN
    EXECUTE 'create table if not exists hub_inherit_' || table_id || ' () inherits(hub);';
    EXECUTE 'insert into hub_inherit_' || table_id || ' (id, melon_amount) values ('
                || NEW.id || ', ' || NEW.melon_amount || ');';
    RETURN NULL;
END
$$ LANGUAGE plpgsql;


CREATE TRIGGER bf_insert_trigger
    BEFORE INSERT ON hub
    FOR EACH ROW
EXECUTE PROCEDURE bf_insert();

INSERT INTO hub (melon_amount) VALUES (7107);
SELECT currval(pg_get_serial_sequence('hub', 'id'));
SELECT setval(pg_get_serial_sequence('hub', 'id'), 100001);
UPDATE hub SET melon_amount = 100002 WHERE id = 888;
SELECT * FROM hub_inherit_1;

create table if not exists hub_inherit_1 () inherits(hub);
insert into hub_inherit_1 (id, melon_amount) values (18, '777');