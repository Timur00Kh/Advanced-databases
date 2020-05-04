# 13. Instead-of Trigger

### flyway scripts
+ [V16.1__LAB13_create_tables.sql](../flyway-6.4.1/sql/V16.1__LAB13_create_tables.sql)

```sql
INSERT INTO instead_view VALUES ('insert into view', 10);
SELECT *FROM instead_table WHERE value = 10;
```

![](1.png)

```sql
SELECT * FROM instead_view;
```

![](2.png)
