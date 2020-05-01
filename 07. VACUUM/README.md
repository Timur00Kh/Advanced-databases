# 07. VACUUM

### flyway scripts
+ [V4.1__LAB7_cteate_table.sql](../flyway-6.4.1/sql/V4.1__LAB7_cteate_table.sql)

### benchmark script
+ [select_bench.sql](select_bench.sql)
 
 ```sql
SELECT pg_size_pretty(pg_total_relation_size('lab7')); 

-- returned 16 kB
```


```bash
pgbench -U postgres -h timurs-database.cqahjo27i0vt.us-east-1.rds.amazonaws.com -p 5432 -T 30 -n -f select_bench.sql -D id=1
```