# 16. Btree Index Usage
 
 ### flyway script
 + [V9.1__LAB19_create_tables.sql](../flyway-6.4.1/sql/V9.1__LAB19_create_tables.sql)

 ### bench scripts
 + [btree_bench.sql](btree_bench.sql)
 + [gin_bench.sql](gin_bench.sql)
 + [gist_bench.sql](gist_bench.sql)

### benchmarking

 
```bash
pgbench -U postgres -h timurs-database.cqahjo27i0vt.us-east-1.rds.amazonaws.com -p 5432 -T 300 -l -n -f bench.sql
```

![](images/1.png)

```sql
SELECT * FROM pg_statio_user_indexes;
```

![](images/3.png)

Число попаданий в буфер для индекса `i_b_desc_c_desc` является наибольшим. 
К тому же это в разы больше остальных.
Мне кажется именно этот индекс покрывает запрос.