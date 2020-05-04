# 04. Foreign Table
 
 ### flyway script
 + [V12.1__LAB4_create_foreign_table.sqlsql](../flyway-6.4.1/sql/V12.1__LAB4_create_foreign_table.sql)

 ## insert data 
 
```sql
DO
$do$
    DECLARE
        id bigint;
    BEGIN
        FOR i IN 1..10000
            LOOP
                id = random() * 10000;
                IF (id BETWEEN 0 AND 100) THEN
                    INSERT INTO schema1_table VALUES (id, 'text' || id);
                    CONTINUE;
                end if;
                IF (id BETWEEN 100 AND 200) THEN
                    INSERT INTO schema2_table VALUES (id, 'text' || id);
                    CONTINUE;
                end if;
                INSERT INTO schema3_table VALUES (id, 'text' || id);
            END LOOP;
    END
$do$;
```  

 ## data distribution

```sql
SELECT
       (SELECT count(1) FROM schema1_table) as c1,
       (SELECT count(1) FROM schema2_table) as c2,
       (SELECT count(1) FROM schema3_table) as c3;
```

![](d.png)