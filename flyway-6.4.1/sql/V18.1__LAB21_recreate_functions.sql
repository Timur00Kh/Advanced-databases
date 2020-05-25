CREATE FUNCTION func_sql(value text) RETURNS TABLE(table_name TEXT, owner TEXT) as $$
       select table_name::text, value AS owner FROM information_schema.tables;
$$ LANGUAGE SQL;

CREATE OR REPLACE FUNCTION func_plpgsql(value text) RETURNS TABLE(table_name TEXT, owner TEXT) as $$
   BEGIN
       RETURN QUERY EXECUTE 'select table_name::text as table, ''' ||  value ||  ''' as owner from information_schema.tables; ';
   END;
$$ LANGUAGE plpgsql;

