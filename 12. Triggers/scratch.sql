CREATE TABLE hub
(
    id           bigint,
    melon_amount int
);

CREATE OR REPLACE FUNCTION bf_insert()
    RETURNS TRIGGER AS
$$
DECLARE
    pa       bigint = 100000; --partition tuples amount
    table_id int    = ceil((NEW.id / pa));
BEGIN
    IF NOT EXISTS (SELECT FROM pg_catalog.pg_tables
              WHERE  schemaname = 'public'
              AND    tablename  = 'hub_inherit_' || table_id) THEN
        EXECUTE 'create table if not exists hub_inherit_' || table_id || ' () inherits(hub);';
        EXECUTE 'alter table hub_inherit_'  || table_id || ' add constraint partition_check CHECK (id >=' || pa * table_id || 'and id <' || pa * (table_id + 1) ||  ');';
    END IF;
    EXECUTE 'insert into hub_inherit_' || table_id || ' (id, melon_amount) values ('
                || NEW.id || ', ' || NEW.melon_amount || ');';
    RETURN NULL;
END
$$ LANGUAGE plpgsql;

ALTER TABLE hub_inherit_0 ADD CONSTRAINT partition_check
CHECK ( id >= 0 and id < 100000 );


CREATE TRIGGER bf_insert_trigger
    BEFORE INSERT ON hub
    FOR EACH ROW
EXECUTE PROCEDURE bf_insert();

CREATE OR REPLACE FUNCTION bf_update()
    RETURNS TRIGGER AS
$$
DECLARE
    pa       bigint = 100000; --partition tuples amount
    table_id int    = ceil((NEW.id / pa));
    old_table_id int    = ceil((OLD.id / pa));
BEGIN
    IF NOT EXISTS (SELECT FROM pg_catalog.pg_tables
              WHERE  schemaname = 'public'
              AND    tablename  = 'hub_inherit_' || table_id) THEN
        EXECUTE 'create table if not exists hub_inherit_' || table_id || ' () inherits(hub);';
        EXECUTE 'alter table hub_inherit_'  || table_id || ' add constraint partition_check CHECK (id >=' || pa * table_id || 'and id <' || pa * (table_id + 1) ||  ');';
    END IF;
    EXECUTE 'delete from hub_inherit_' || old_table_id || 'where id = ' || OLD.id;
    EXECUTE 'insert into hub_inherit_' || table_id || ' (id, melon_amount) values ('
                || NEW.id || ', ' || NEW.melon_amount || ');';
    RETURN NULL;
END
$$ LANGUAGE plpgsql;

alter table hub_inherit_0 add constraint CHECK (id > 0) DEFERRABLE 

CREATE TRIGGER bf_update_trigger
    BEFORE UPDATE ON hub
    FOR EACH ROW
EXECUTE PROCEDURE bf_update();


UPDATE hub SET id = 888888 WHERE id = 555;

insert into hub (id, melon_amount) values (888888, 777);

SHOW server_version

