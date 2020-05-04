# 04. Foreign Table
 
 ### flyway script
 + [V12.1__LAB4_create_foreign_table.sqlsql](../flyway-6.4.1/sql/V12.1__LAB4_create_foreign_table.sql)

 ### bench scripts
 + [bench.sql](bench.sql)
 

### benchmarking without clusterization

migrate to `11.2`
 
```bash
pgbench -U postgres -h timurs-database.cqahjo27i0vt.us-east-1.rds.amazonaws.com -p 5432 -T 300 -c 10 -l -n -f bench.sql
``` 
![](images/1.png)

### benchmarking with clusterization

migrate to `11.3`

```bash
pgbench -U postgres -h timurs-database.cqahjo27i0vt.us-east-1.rds.amazonaws.com -p 5432 -T 300 -c 10 -l -n -f bench.sql
``` 

![](images/2.png)


### Вывод

|  |  latency | tps |
|:-----:|:--------:|:---:|
| without clusterization |  37.374 ms | 267 |
| with clusterization   |  38.194 ms| 261  |

