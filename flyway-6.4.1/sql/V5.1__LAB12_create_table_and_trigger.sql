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
    old_table_id int    = ceil((OLD.id / pa));
BEGIN
    IF (TG_RELNAME = 'hub_inherit_' || table_id ) THEN
        RETURN NEW;
    end if;

    IF NOT EXISTS (SELECT FROM pg_catalog.pg_tables
              WHERE  schemaname = 'public'
              AND    tablename  = 'hub_inherit_' || table_id) THEN
        EXECUTE 'create table if not exists hub_inherit_' || table_id || ' () inherits(hub);';
        EXECUTE 'alter table hub_inherit_'  || table_id || ' add constraint partition_check check (id >=' || pa * table_id || 'and id <' || pa * (table_id + 1) ||  ');';
        EXECUTE 'create trigger bf_insert_trigger before insert or update on  hub_inherit_'  || table_id || ' for each row execute procedure bf_insert();';
    END IF;

    IF (TG_OP = 'UPDATE') THEN
        EXECUTE 'delete from hub_inherit_' || old_table_id || ' where id = ' || OLD.id || ' and melon_amount = ' || OLD.melon_amount;
    END IF;

    EXECUTE 'insert into hub_inherit_' || table_id || ' (id, melon_amount) values ('
                || NEW.id || ', ' || NEW.melon_amount || ');';
    RETURN NULL;
END
$$ LANGUAGE plpgsql;


CREATE TRIGGER bf_insert_trigger
    BEFORE INSERT ON hub
    FOR EACH ROW
EXECUTE PROCEDURE bf_insert();