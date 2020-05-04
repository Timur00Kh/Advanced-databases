CREATE TABLE instead_table (
   type_name VARCHAR,
   value INT
);

CREATE VIEW instead_view AS SELECT type_name, sum(value) AS number FROM instead_table GROUP BY type_name;

CREATE OR REPLACE FUNCTION instead_func() RETURNS TRIGGER AS $$
BEGIN
    insert into instead_table (type_name, value) VALUES (new.type_name, new.number);
    return new;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER instead_trigger
   INSTEAD OF INSERT on instead_view
   FOR EACH ROW EXECUTE PROCEDURE instead_func();

insert into instead_view
SELECT '123456', random() * 10000
FROM generate_series(0, 1000);
