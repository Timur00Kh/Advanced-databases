# 18. Standard , Geqo
 
 ### flyway script
 + [V8.1__LAB18_create_tables.sql](../flyway-6.4.1/sql/V8.1__LAB18_create_tables.sql)

 ### bench script
 + [bench.sql](bench.sql)

### check geqo defaults

```sql
SHOW geqo;
--  on
SHOW geqo_threshold;
--  12
```

## geqo off

```sql
SET geqo='off'
```

```bash
pgbench -U postgres -h timurs-database.cqahjo27i0vt.us-east-1.rds.amazonaws.com -p 5432 -T 300 -c 10 -l -n -f bench.sql -D id1=1 -D id2=1000
```

![](images/1.png)


```sql
EXPLAIN ANALYSE VERBOSE
SELECT * FROM lab18_hub
    JOIN lab18_1 ON id = lab18_1.hub_id
    JOIN lab18_2 ON id = lab18_2.hub_id
    JOIN lab18_3 ON id = lab18_3.hub_id
    JOIN lab18_4 ON id = lab18_4.hub_id
    JOIN lab18_5 ON lab18_4.hub_id = hub4_id
WHERE id = 534;
```

```
Nested Loop  (cost=0.00..117.05 rows=1 width=119) (actual time=0.258..0.439 rows=1 loops=1)
  Output: lab18_hub.id, lab18_hub.name, lab18_1.hub_id, lab18_1.name, lab18_2.hub_id, lab18_2.name, lab18_3.hub_id, lab18_3.name, lab18_4.hub_id, lab18_4.name, lab18_5.hub4_id, lab18_5.name
  ->  Nested Loop  (cost=0.00..97.54 rows=1 width=99) (actual time=0.218..0.368 rows=1 loops=1)
        Output: lab18_hub.id, lab18_hub.name, lab18_1.hub_id, lab18_1.name, lab18_2.hub_id, lab18_2.name, lab18_3.hub_id, lab18_3.name, lab18_4.hub_id, lab18_4.name
        ->  Nested Loop  (cost=0.00..78.03 rows=1 width=79) (actual time=0.179..0.300 rows=1 loops=1)
              Output: lab18_hub.id, lab18_hub.name, lab18_1.hub_id, lab18_1.name, lab18_2.hub_id, lab18_2.name, lab18_3.hub_id, lab18_3.name
              ->  Nested Loop  (cost=0.00..58.52 rows=1 width=59) (actual time=0.139..0.227 rows=1 loops=1)
                    Output: lab18_hub.id, lab18_hub.name, lab18_1.hub_id, lab18_1.name, lab18_2.hub_id, lab18_2.name
                    ->  Nested Loop  (cost=0.00..39.01 rows=1 width=39) (actual time=0.094..0.153 rows=1 loops=1)
                          Output: lab18_hub.id, lab18_hub.name, lab18_1.hub_id, lab18_1.name
                          ->  Seq Scan on public.lab18_hub  (cost=0.00..19.50 rows=1 width=19) (actual time=0.051..0.080 rows=1 loops=1)
                                Output: lab18_hub.id, lab18_hub.name
                                Filter: (lab18_hub.id = 534)
                                Rows Removed by Filter: 999
                          ->  Seq Scan on public.lab18_1  (cost=0.00..19.50 rows=1 width=20) (actual time=0.041..0.070 rows=1 loops=1)
                                Output: lab18_1.hub_id, lab18_1.name
                                Filter: (lab18_1.hub_id = 534)
                                Rows Removed by Filter: 999
                    ->  Seq Scan on public.lab18_2  (cost=0.00..19.50 rows=1 width=20) (actual time=0.043..0.073 rows=1 loops=1)
                          Output: lab18_2.hub_id, lab18_2.name
                          Filter: (lab18_2.hub_id = 534)
                          Rows Removed by Filter: 999
              ->  Seq Scan on public.lab18_3  (cost=0.00..19.50 rows=1 width=20) (actual time=0.039..0.071 rows=1 loops=1)
                    Output: lab18_3.hub_id, lab18_3.name
                    Filter: (lab18_3.hub_id = 534)
                    Rows Removed by Filter: 999
        ->  Seq Scan on public.lab18_4  (cost=0.00..19.50 rows=1 width=20) (actual time=0.038..0.067 rows=1 loops=1)
              Output: lab18_4.hub_id, lab18_4.name
              Filter: (lab18_4.hub_id = 534)
              Rows Removed by Filter: 999
  ->  Seq Scan on public.lab18_5  (cost=0.00..19.50 rows=1 width=20) (actual time=0.039..0.069 rows=1 loops=1)
        Output: lab18_5.hub4_id, lab18_5.name
        Filter: (lab18_5.hub4_id = 534)
        Rows Removed by Filter: 999
Planning Time: 0.404 ms
Execution Time: 0.488 ms
```


```bash
pgbench -U postgres -h timurs-database.cqahjo27i0vt.us-east-1.rds.amazonaws.com -p 5432 -T 300 -c 10 -l -n -f bench2.sql
```

![](images/3.png)


```sql
EXPLAIN ANALYSE VERBOSE
SELECT * FROM lab18_hub
    JOIN lab18_1 ON id = lab18_1.hub_id
    JOIN lab18_2 ON id = lab18_2.hub_id
    JOIN lab18_3 ON id = lab18_3.hub_id
    JOIN lab18_4 ON id = lab18_4.hub_id
    JOIN lab18_5 ON lab18_4.hub_id = hub4_id;
```

```
Hash Join  (cost=147.50..233.25 rows=1000 width=119) (actual time=2.735..5.778 rows=1000 loops=1)
  Output: lab18_hub.id, lab18_hub.name, lab18_1.hub_id, lab18_1.name, lab18_2.hub_id, lab18_2.name, lab18_3.hub_id, lab18_3.name, lab18_4.hub_id, lab18_4.name, lab18_5.hub4_id, lab18_5.name
  Hash Cond: (lab18_hub.id = lab18_5.hub4_id)
  ->  Hash Join  (cost=118.00..190.00 rows=1000 width=99) (actual time=2.174..4.635 rows=1000 loops=1)
        Output: lab18_hub.id, lab18_hub.name, lab18_1.hub_id, lab18_1.name, lab18_2.hub_id, lab18_2.name, lab18_3.hub_id, lab18_3.name, lab18_4.hub_id, lab18_4.name
        Hash Cond: (lab18_hub.id = lab18_4.hub_id)
        ->  Hash Join  (cost=88.50..146.75 rows=1000 width=79) (actual time=1.635..3.534 rows=1000 loops=1)
              Output: lab18_hub.id, lab18_hub.name, lab18_1.hub_id, lab18_1.name, lab18_2.hub_id, lab18_2.name, lab18_3.hub_id, lab18_3.name
              Hash Cond: (lab18_hub.id = lab18_3.hub_id)
              ->  Hash Join  (cost=59.00..103.50 rows=1000 width=59) (actual time=1.105..2.445 rows=1000 loops=1)
                    Output: lab18_hub.id, lab18_hub.name, lab18_1.hub_id, lab18_1.name, lab18_2.hub_id, lab18_2.name
                    Hash Cond: (lab18_hub.id = lab18_2.hub_id)
                    ->  Hash Join  (cost=29.50..60.25 rows=1000 width=39) (actual time=0.540..1.344 rows=1000 loops=1)
                          Output: lab18_hub.id, lab18_hub.name, lab18_1.hub_id, lab18_1.name
                          Hash Cond: (lab18_hub.id = lab18_1.hub_id)
                          ->  Seq Scan on public.lab18_hub  (cost=0.00..17.00 rows=1000 width=19) (actual time=0.004..0.235 rows=1000 loops=1)
                                Output: lab18_hub.id, lab18_hub.name
                          ->  Hash  (cost=17.00..17.00 rows=1000 width=20) (actual time=0.523..0.524 rows=1000 loops=1)
                                Output: lab18_1.hub_id, lab18_1.name
                                Buckets: 1024  Batches: 1  Memory Usage: 60kB
                                ->  Seq Scan on public.lab18_1  (cost=0.00..17.00 rows=1000 width=20) (actual time=0.005..0.227 rows=1000 loops=1)
                                      Output: lab18_1.hub_id, lab18_1.name
                    ->  Hash  (cost=17.00..17.00 rows=1000 width=20) (actual time=0.555..0.555 rows=1000 loops=1)
                          Output: lab18_2.hub_id, lab18_2.name
                          Buckets: 1024  Batches: 1  Memory Usage: 60kB
                          ->  Seq Scan on public.lab18_2  (cost=0.00..17.00 rows=1000 width=20) (actual time=0.004..0.256 rows=1000 loops=1)
                                Output: lab18_2.hub_id, lab18_2.name
              ->  Hash  (cost=17.00..17.00 rows=1000 width=20) (actual time=0.519..0.519 rows=1000 loops=1)
                    Output: lab18_3.hub_id, lab18_3.name
                    Buckets: 1024  Batches: 1  Memory Usage: 60kB
                    ->  Seq Scan on public.lab18_3  (cost=0.00..17.00 rows=1000 width=20) (actual time=0.004..0.237 rows=1000 loops=1)
                          Output: lab18_3.hub_id, lab18_3.name
        ->  Hash  (cost=17.00..17.00 rows=1000 width=20) (actual time=0.528..0.528 rows=1000 loops=1)
              Output: lab18_4.hub_id, lab18_4.name
              Buckets: 1024  Batches: 1  Memory Usage: 60kB
              ->  Seq Scan on public.lab18_4  (cost=0.00..17.00 rows=1000 width=20) (actual time=0.004..0.227 rows=1000 loops=1)
                    Output: lab18_4.hub_id, lab18_4.name
  ->  Hash  (cost=17.00..17.00 rows=1000 width=20) (actual time=0.551..0.551 rows=1000 loops=1)
        Output: lab18_5.hub4_id, lab18_5.name
        Buckets: 1024  Batches: 1  Memory Usage: 60kB
        ->  Seq Scan on public.lab18_5  (cost=0.00..17.00 rows=1000 width=20) (actual time=0.011..0.259 rows=1000 loops=1)
              Output: lab18_5.hub4_id, lab18_5.name
Planning Time: 1.476 ms
Execution Time: 6.036 ms
```

## geqo on

```sql
SET geqo='on';
SET geqo_threshold=2;
```

```bash
pgbench -U postgres -h timurs-database.cqahjo27i0vt.us-east-1.rds.amazonaws.com -p 5432 -T 300 -c 10 -l -n -f bench.sql -D id1=1 -D id2=1000
```

![](images/2.png)


```sql
EXPLAIN ANALYSE VERBOSE
SELECT * FROM lab18_hub
    JOIN lab18_1 ON id = lab18_1.hub_id
    JOIN lab18_2 ON id = lab18_2.hub_id
    JOIN lab18_3 ON id = lab18_3.hub_id
    JOIN lab18_4 ON id = lab18_4.hub_id
    JOIN lab18_5 ON lab18_4.hub_id = hub4_id
WHERE id = 534;
```

```
Nested Loop  (cost=0.00..117.05 rows=1 width=119) (actual time=0.247..0.425 rows=1 loops=1)
  Output: lab18_hub.id, lab18_hub.name, lab18_1.hub_id, lab18_1.name, lab18_2.hub_id, lab18_2.name, lab18_3.hub_id, lab18_3.name, lab18_4.hub_id, lab18_4.name, lab18_5.hub4_id, lab18_5.name
  ->  Nested Loop  (cost=0.00..97.54 rows=1 width=100) (actual time=0.208..0.356 rows=1 loops=1)
        Output: lab18_1.hub_id, lab18_1.name, lab18_2.hub_id, lab18_2.name, lab18_5.hub4_id, lab18_5.name, lab18_4.hub_id, lab18_4.name, lab18_3.hub_id, lab18_3.name
        ->  Nested Loop  (cost=0.00..78.03 rows=1 width=80) (actual time=0.169..0.288 rows=1 loops=1)
              Output: lab18_1.hub_id, lab18_1.name, lab18_2.hub_id, lab18_2.name, lab18_5.hub4_id, lab18_5.name, lab18_4.hub_id, lab18_4.name
              ->  Nested Loop  (cost=0.00..58.52 rows=1 width=60) (actual time=0.129..0.217 rows=1 loops=1)
                    Output: lab18_1.hub_id, lab18_1.name, lab18_2.hub_id, lab18_2.name, lab18_5.hub4_id, lab18_5.name
                    ->  Nested Loop  (cost=0.00..39.01 rows=1 width=40) (actual time=0.089..0.149 rows=1 loops=1)
                          Output: lab18_1.hub_id, lab18_1.name, lab18_2.hub_id, lab18_2.name
                          ->  Seq Scan on public.lab18_1  (cost=0.00..19.50 rows=1 width=20) (actual time=0.048..0.077 rows=1 loops=1)
                                Output: lab18_1.hub_id, lab18_1.name
                                Filter: (lab18_1.hub_id = 534)
                                Rows Removed by Filter: 999
                          ->  Seq Scan on public.lab18_2  (cost=0.00..19.50 rows=1 width=20) (actual time=0.039..0.069 rows=1 loops=1)
                                Output: lab18_2.hub_id, lab18_2.name
                                Filter: (lab18_2.hub_id = 534)
                                Rows Removed by Filter: 999
                    ->  Seq Scan on public.lab18_5  (cost=0.00..19.50 rows=1 width=20) (actual time=0.039..0.067 rows=1 loops=1)
                          Output: lab18_5.hub4_id, lab18_5.name
                          Filter: (lab18_5.hub4_id = 534)
                          Rows Removed by Filter: 999
              ->  Seq Scan on public.lab18_4  (cost=0.00..19.50 rows=1 width=20) (actual time=0.039..0.069 rows=1 loops=1)
                    Output: lab18_4.hub_id, lab18_4.name
                    Filter: (lab18_4.hub_id = 534)
                    Rows Removed by Filter: 999
        ->  Seq Scan on public.lab18_3  (cost=0.00..19.50 rows=1 width=20) (actual time=0.037..0.067 rows=1 loops=1)
              Output: lab18_3.hub_id, lab18_3.name
              Filter: (lab18_3.hub_id = 534)
              Rows Removed by Filter: 999
  ->  Seq Scan on public.lab18_hub  (cost=0.00..19.50 rows=1 width=19) (actual time=0.038..0.067 rows=1 loops=1)
        Output: lab18_hub.id, lab18_hub.name
        Filter: (lab18_hub.id = 534)
        Rows Removed by Filter: 999
Planning Time: 1.802 ms
Execution Time: 0.473 ms
```

```bash
pgbench -U postgres -h timurs-database.cqahjo27i0vt.us-east-1.rds.amazonaws.com -p 5432 -T 300 -c 10 -l -n -f bench2.sql
```

![](images/4.png)


```sql
EXPLAIN ANALYSE VERBOSE
SELECT * FROM lab18_hub
    JOIN lab18_1 ON id = lab18_1.hub_id
    JOIN lab18_2 ON id = lab18_2.hub_id
    JOIN lab18_3 ON id = lab18_3.hub_id
    JOIN lab18_4 ON id = lab18_4.hub_id
    JOIN lab18_5 ON lab18_4.hub_id = hub4_id;
```

```
Hash Join  (cost=147.50..233.25 rows=1000 width=119) (actual time=2.543..5.496 rows=1000 loops=1)
  Output: lab18_hub.id, lab18_hub.name, lab18_1.hub_id, lab18_1.name, lab18_2.hub_id, lab18_2.name, lab18_3.hub_id, lab18_3.name, lab18_4.hub_id, lab18_4.name, lab18_5.hub4_id, lab18_5.name
  Hash Cond: (lab18_1.hub_id = lab18_hub.id)
  ->  Hash Join  (cost=118.00..190.00 rows=1000 width=100) (actual time=2.025..4.410 rows=1000 loops=1)
        Output: lab18_1.hub_id, lab18_1.name, lab18_2.hub_id, lab18_2.name, lab18_5.hub4_id, lab18_5.name, lab18_4.hub_id, lab18_4.name, lab18_3.hub_id, lab18_3.name
        Hash Cond: (lab18_1.hub_id = lab18_3.hub_id)
        ->  Hash Join  (cost=88.50..146.75 rows=1000 width=80) (actual time=1.523..3.353 rows=1000 loops=1)
              Output: lab18_1.hub_id, lab18_1.name, lab18_2.hub_id, lab18_2.name, lab18_5.hub4_id, lab18_5.name, lab18_4.hub_id, lab18_4.name
              Hash Cond: (lab18_1.hub_id = lab18_4.hub_id)
              ->  Hash Join  (cost=59.00..103.50 rows=1000 width=60) (actual time=1.020..2.323 rows=1000 loops=1)
                    Output: lab18_1.hub_id, lab18_1.name, lab18_2.hub_id, lab18_2.name, lab18_5.hub4_id, lab18_5.name
                    Hash Cond: (lab18_1.hub_id = lab18_5.hub4_id)
                    ->  Hash Join  (cost=29.50..60.25 rows=1000 width=40) (actual time=0.517..1.301 rows=1000 loops=1)
                          Output: lab18_1.hub_id, lab18_1.name, lab18_2.hub_id, lab18_2.name
                          Hash Cond: (lab18_1.hub_id = lab18_2.hub_id)
                          ->  Seq Scan on public.lab18_1  (cost=0.00..17.00 rows=1000 width=20) (actual time=0.004..0.241 rows=1000 loops=1)
                                Output: lab18_1.hub_id, lab18_1.name
                          ->  Hash  (cost=17.00..17.00 rows=1000 width=20) (actual time=0.505..0.505 rows=1000 loops=1)
                                Output: lab18_2.hub_id, lab18_2.name
                                Buckets: 1024  Batches: 1  Memory Usage: 60kB
                                ->  Seq Scan on public.lab18_2  (cost=0.00..17.00 rows=1000 width=20) (actual time=0.005..0.233 rows=1000 loops=1)
                                      Output: lab18_2.hub_id, lab18_2.name
                    ->  Hash  (cost=17.00..17.00 rows=1000 width=20) (actual time=0.499..0.499 rows=1000 loops=1)
                          Output: lab18_5.hub4_id, lab18_5.name
                          Buckets: 1024  Batches: 1  Memory Usage: 60kB
                          ->  Seq Scan on public.lab18_5  (cost=0.00..17.00 rows=1000 width=20) (actual time=0.005..0.230 rows=1000 loops=1)
                                Output: lab18_5.hub4_id, lab18_5.name
              ->  Hash  (cost=17.00..17.00 rows=1000 width=20) (actual time=0.498..0.498 rows=1000 loops=1)
                    Output: lab18_4.hub_id, lab18_4.name
                    Buckets: 1024  Batches: 1  Memory Usage: 60kB
                    ->  Seq Scan on public.lab18_4  (cost=0.00..17.00 rows=1000 width=20) (actual time=0.005..0.230 rows=1000 loops=1)
                          Output: lab18_4.hub_id, lab18_4.name
        ->  Hash  (cost=17.00..17.00 rows=1000 width=20) (actual time=0.497..0.497 rows=1000 loops=1)
              Output: lab18_3.hub_id, lab18_3.name
              Buckets: 1024  Batches: 1  Memory Usage: 60kB
              ->  Seq Scan on public.lab18_3  (cost=0.00..17.00 rows=1000 width=20) (actual time=0.006..0.234 rows=1000 loops=1)
                    Output: lab18_3.hub_id, lab18_3.name
  ->  Hash  (cost=17.00..17.00 rows=1000 width=19) (actual time=0.511..0.511 rows=1000 loops=1)
        Output: lab18_hub.id, lab18_hub.name
        Buckets: 1024  Batches: 1  Memory Usage: 59kB
        ->  Seq Scan on public.lab18_hub  (cost=0.00..17.00 rows=1000 width=19) (actual time=0.011..0.238 rows=1000 loops=1)
              Output: lab18_hub.id, lab18_hub.name
Planning Time: 4.547 ms
Execution Time: 5.773 ms
```

## Вывод

Получилось запрос с 6 join и условием where лучше выполнаялся без geqo. 
Однако запрос с 6 join и без условия where с geqo выиграл 4 tps. 
