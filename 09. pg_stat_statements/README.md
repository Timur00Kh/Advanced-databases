# 09. pg_stat_statements

```sql
CREATE EXTENSION pg_stat_statements;
CREATE TABLE lab9 (
    name varchar
);
```

```bash 
echo "shared_preload_libraries = 'pg_stat_statements'" >> postgresql.conf
```

```sql
SELECT pg_stat_statements_reset()
```


