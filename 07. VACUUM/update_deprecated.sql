DO
$$
    BEGIN
        FOR i IN 1..1000000
            LOOP
                UPDATE lab7 SET name = 'first and only row (UPD' || i || ')' WHERE id = 1;
            END LOOP;
    END
$$ LANGUAGE plpgsql;