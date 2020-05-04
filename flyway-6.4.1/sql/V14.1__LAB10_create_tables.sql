DO
$do$
    DECLARE
        b varchar = 'b1 bigint';
    BEGIN
        FOR i IN 2..100
            LOOP
                b = b || ', b' || i || ' bigint';
            END LOOP;
        RAISE NOTICE '%', b;

        EXECUTE 'CREATE TABLE lab10_1 (' || b || ', name varchar)';
        EXECUTE 'CREATE TABLE lab10_2 (name varchar, ' || b || ')';
    END
$do$;

DO
$do$
    DECLARE
        b varchar = '1001';
    BEGIN
        FOR i IN 2..100
            LOOP
                b = b || ', 100' || i;
            END LOOP;
       FOR i IN 1..100000
            LOOP
               EXECUTE 'INSERT INTO lab10_1 VALUES (' || b || ', ''name' || i || ''')';
               EXECUTE 'INSERT INTO lab10_2 VALUES (''name' || i || ''', ' || b || ')';
            END LOOP;
    END
$do$;

