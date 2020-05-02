# 12. Triggers

## Complex

### flyway scripts
+ [V6.1__LAB14_init_complex.sql](../flyway-6.4.1/sql/V6.1__LAB14_init_complex.sql)
+ [V6.2__LAB14_create_complex_table.sql](../flyway-6.4.1/sql/V6.2__LAB14_create_complex_table.sql)
+ [V6.3__LAB14_init_matrix.sql](../flyway-6.4.1/sql/V6.3__LAB14_init_matrix.sql)
+ [V6.4__LAB14_create_matrix_table.sql](../flyway-6.4.1/sql/V6.4__LAB14_create_matrix_table.sql)

### test math
```sql
SELECT sum_complex((3, 5), (10, 2));
--  (13,7)

SELECT subtract_complex((3, 5), (10, 2));
--  (-7,3)

SELECT multiply_complex((3, 5), (10, 2));
--  (20,56)

SELECT divide_complex((3, 5), (10, 2));
-- (0.38461538461538464,0.4230769230769231)
```
Все посчитано верно!

### test aggregate
```sql
SELECT sum_complex(n) FROM complex_heaven;
--  (241473,252458)

SELECT subtract_complex(n) FROM complex_heaven;
--  (-241473,-252458)

SELECT multiply_complex(n) FROM complex_heaven;
--  (2.1299380625821788e+256,-4.783381682611767e+255)

SELECT divide_complex(n) FROM complex_heaven;
--  (-2.007528419446381e-257,8.939096806424233e-257)
```

## Matrix

### test math
```sql
SELECT sum_matrix(ROW (ARRAY [
    [1,2,3],
    [1,2,3],
    [1,2,3]
    ])::matrix, ROW (ARRAY [
    [1,2,3],
    [1,2,3],
    [1,2,3]
    ])::matrix);
-- ("{{2,4,6},{2,4,6},{2,4,6}}")

SELECT subtract_matrix(ROW (ARRAY [
    [1,2,3],
    [1,2,3],
    [1,2,3]
    ])::matrix, ROW (ARRAY [
    [1,2,3],
    [1,2,3],
    [1,2,3]
    ])::matrix);
-- ("{{0,0,0},{0,0,0},{0,0,0}}")

SELECT multiply_matrix(ROW (ARRAY [
    [1,2,3],
    [1,2,3],
    [1,2,3]
    ])::matrix, ROW (ARRAY [
    [1,2,3],
    [1,2,3],
    [1,2,3]
    ])::matrix);
-- ("{{6,12,18},{6,12,18},{6,12,18}}")
```

Все посчитано верно!

### test aggregate

```sql
SELECT sum_matrix(m) FROM matrix_table;
-- ("{{5,10,15},{5,10,15},{5,10,15}}")

SELECT subtract_matrix(m) FROM matrix_table;
-- ("{{-5,-10,-15},{-5,-10,-15},{-5,-10,-15}}")

SELECT multiply_matrix(m) FROM matrix_table;
-- ("{{3888,7776,11664},{3888,7776,11664},{3888,7776,11664}}")
```

## Parallel workers

### check my defaults

```sql
SHOW parallel_setup_cost;
-- 1000
SHOW min_parallel_table_scan_size;
--  8MB
SHOW max_parallel_workers_per_gather;
-- 2
``` 

### Parallel workers off

#### sum_complex

```sql
EXPLAIN (ANALYSE, VERBOSE ,  BUFFERS)
SELECT sum_complex(n) FROM complex_heaven;
```

```
Aggregate  (cost=335.00..335.01 rows=1 width=32) (actual time=5.222..5.222 rows=1 loops=1)
  Output: sum_complex(n)
  Buffers: shared hit=9
  ->  Seq Scan on public.complex_heaven  (cost=0.00..22.50 rows=1250 width=37) (actual time=0.029..0.313 rows=1000 loops=1)
        Output: n
        Buffers: shared hit=9
Planning Time: 0.114 ms
Execution Time: 5.277 ms
```

#### subtract_complex

```sql
EXPLAIN (ANALYSE, VERBOSE ,  BUFFERS)
SELECT subtract_complex(n) FROM complex_heaven;
```

```
Aggregate  (cost=335.00..335.01 rows=1 width=32) (actual time=4.566..4.566 rows=1 loops=1)
  Output: subtract_complex(n)
  Buffers: shared hit=9
  ->  Seq Scan on public.complex_heaven  (cost=0.00..22.50 rows=1250 width=37) (actual time=0.024..0.226 rows=1000 loops=1)
        Output: n
        Buffers: shared hit=9
Planning Time: 0.062 ms
Execution Time: 4.702 ms
```

#### multiply_complex

```sql
EXPLAIN (ANALYSE, VERBOSE ,  BUFFERS)
SELECT multiply_complex(n) FROM complex_heaven;
```

```
Finalize Aggregate  (cost=115.84..115.85 rows=1 width=32) (actual time=89.291..89.291 rows=1 loops=1)
  Output: multiply_complex(n)
  Buffers: shared hit=1
  ->  Gather  (cost=114.78..115.09 rows=3 width=32) (actual time=17.961..94.172 rows=4 loops=1)
        Output: (PARTIAL multiply_complex(n))
        Workers Planned: 3
        Workers Launched: 3
        Buffers: shared hit=1
        ->  Partial Aggregate  (cost=114.78..114.79 rows=1 width=32) (actual time=0.114..0.115 rows=1 loops=4)
              Output: PARTIAL multiply_complex(n)
              Buffers: shared hit=1
              Worker 0: actual time=0.014..0.014 rows=1 loops=1
              Worker 1: actual time=0.029..0.030 rows=1 loops=1
              Worker 2: actual time=0.015..0.015 rows=1 loops=1
              ->  Parallel Seq Scan on public.complex_heaven  (cost=0.00..14.03 rows=403 width=37) (actual time=0.010..0.014 rows=25 loops=4)
                    Output: n
                    Buffers: shared hit=1
                    Worker 0: actual time=0.002..0.002 rows=0 loops=1
                    Worker 1: actual time=0.004..0.004 rows=0 loops=1
                    Worker 2: actual time=0.002..0.002 rows=0 loops=1
Planning Time: 0.120 ms
Execution Time: 94.402 ms
```

#### sum_matrix

```sql
EXPLAIN (ANALYSE, VERBOSE ,  BUFFERS)
SELECT sum_matrix(n) FROM complex_heaven;
```

```
Aggregate  (cost=276.30..276.31 rows=1 width=32) (actual time=340.570..340.570 rows=1 loops=1)
  Output: sum_matrix(m)
  Buffers: shared hit=15
  ->  Seq Scan on public.matrix_table  (cost=0.00..25.05 rows=1005 width=86) (actual time=0.016..0.675 rows=1005 loops=1)
        Output: m
        Buffers: shared hit=15
Planning Time: 0.057 ms
Execution Time: 340.610 ms
```

#### subtract_matrix

```sql
EXPLAIN (ANALYSE, VERBOSE ,  BUFFERS)
SELECT subtract_matrix(n) FROM complex_heaven;
```

```
Aggregate  (cost=276.30..276.31 rows=1 width=32) (actual time=25.815..25.815 rows=1 loops=1)
  Output: subtract_matrix(m)
  Buffers: shared hit=15
  ->  Seq Scan on public.matrix_table  (cost=0.00..25.05 rows=1005 width=86) (actual time=0.024..0.364 rows=1005 loops=1)
        Output: m
        Buffers: shared hit=15
Planning Time: 0.110 ms
Execution Time: 25.888 ms
```


#### multiply_matrix

```sql
EXPLAIN (ANALYSE, VERBOSE ,  BUFFERS)
SELECT multiply_matrix(n) FROM complex_heaven;
```

```

```

### Parallel workers on

```sql
SET parallel_setup_cost=0;
SET min_parallel_table_scan_size=0;
SET max_parallel_workers_per_gather=5;
```


#### sum_complex

```sql
EXPLAIN (ANALYSE, VERBOSE ,  BUFFERS)
SELECT sum_complex(n) FROM complex_heaven;
```

```
Finalize Aggregate  (cost=94.04..94.05 rows=1 width=32) (actual time=100.174..100.174 rows=1 loops=1)
  Output: sum_complex(n)
  Buffers: shared hit=9
  ->  Gather  (cost=92.98..93.29 rows=3 width=32) (actual time=22.684..115.310 rows=4 loops=1)
        Output: (PARTIAL sum_complex(n))
        Workers Planned: 3
        Workers Launched: 3
        Buffers: shared hit=9
        ->  Partial Aggregate  (cost=92.98..92.99 rows=1 width=32) (actual time=0.903..0.903 rows=1 loops=4)
              Output: PARTIAL sum_complex(n)
              Buffers: shared hit=9
              Worker 0: actual time=0.025..0.025 rows=1 loops=1
              Worker 1: actual time=0.020..0.020 rows=1 loops=1
              Worker 2: actual time=0.020..0.020 rows=1 loops=1
              ->  Parallel Seq Scan on public.complex_heaven  (cost=0.00..12.23 rows=323 width=37) (actual time=0.006..0.062 rows=250 loops=4)
                    Output: n
                    Buffers: shared hit=9
                    Worker 0: actual time=0.003..0.003 rows=0 loops=1
                    Worker 1: actual time=0.003..0.003 rows=0 loops=1
                    Worker 2: actual time=0.003..0.003 rows=0 loops=1
Planning Time: 0.143 ms
Execution Time: 116.268 ms
```

#### subtract_complex

```sql
EXPLAIN (ANALYSE, VERBOSE ,  BUFFERS)
SELECT subtract_complex(n) FROM complex_heaven;
```

```
Finalize Aggregate  (cost=94.04..94.05 rows=1 width=32) (actual time=72.831..72.832 rows=1 loops=1)
  Output: subtract_complex(n)
  Buffers: shared hit=9
  ->  Gather  (cost=92.98..93.29 rows=3 width=32) (actual time=10.218..86.225 rows=4 loops=1)
        Output: (PARTIAL subtract_complex(n))
        Workers Planned: 3
        Workers Launched: 3
        Buffers: shared hit=9
        ->  Partial Aggregate  (cost=92.98..92.99 rows=1 width=32) (actual time=0.753..0.754 rows=1 loops=4)
              Output: PARTIAL subtract_complex(n)
              Buffers: shared hit=9
              Worker 0: actual time=0.020..0.020 rows=1 loops=1
              Worker 1: actual time=0.019..0.019 rows=1 loops=1
              Worker 2: actual time=0.018..0.018 rows=1 loops=1
              ->  Parallel Seq Scan on public.complex_heaven  (cost=0.00..12.23 rows=323 width=37) (actual time=0.004..0.044 rows=250 loops=4)
                    Output: n
                    Buffers: shared hit=9
                    Worker 0: actual time=0.002..0.002 rows=0 loops=1
                    Worker 1: actual time=0.002..0.002 rows=0 loops=1
                    Worker 2: actual time=0.002..0.002 rows=0 loops=1
Planning Time: 0.070 ms
Execution Time: 86.416 ms
```

#### sum_matrix

```sql
EXPLAIN (ANALYSE, VERBOSE ,  BUFFERS)
SELECT sum_matrix(m) FROM matrix_table;
```

```
Finalize Aggregate  (cost=100.30..100.31 rows=1 width=32) (actual time=614.122..614.122 rows=1 loops=1)
  Output: sum_matrix(m)
  Buffers: shared hit=588
  ->  Gather  (cost=99.24..99.55 rows=3 width=32) (actual time=611.090..626.312 rows=4 loops=1)
        Output: (PARTIAL sum_matrix(m))
        Workers Planned: 3
        Workers Launched: 3
        Buffers: shared hit=588
        ->  Partial Aggregate  (cost=99.24..99.25 rows=1 width=32) (actual time=498.531..498.531 rows=1 loops=4)
              Output: PARTIAL sum_matrix(m)
              Buffers: shared hit=588
              Worker 0: actual time=456.628..456.628 rows=1 loops=1
                Buffers: shared hit=192
              Worker 1: actual time=477.865..477.865 rows=1 loops=1
                Buffers: shared hit=192
              Worker 2: actual time=449.925..449.926 rows=1 loops=1
                Buffers: shared hit=192
              ->  Parallel Seq Scan on public.matrix_table  (cost=0.00..18.24 rows=324 width=86) (actual time=0.021..2.191 rows=251 loops=4)
                    Output: m
                    Buffers: shared hit=15
                    Worker 0: actual time=0.015..0.132 rows=70 loops=1
                      Buffers: shared hit=1
                    Worker 1: actual time=0.039..0.175 rows=70 loops=1
                      Buffers: shared hit=1
                    Worker 2: actual time=0.015..0.133 rows=70 loops=1
                      Buffers: shared hit=1
Planning Time: 0.343 ms
Execution Time: 629.574 ms
```

#### subtract_matrix

```sql
EXPLAIN (ANALYSE, VERBOSE ,  BUFFERS)
SELECT subtract_matrix(m) FROM matrix_table;
```

```
Finalize Aggregate  (cost=100.30..100.31 rows=1 width=32) (actual time=107.723..107.723 rows=1 loops=1)
  Output: subtract_matrix(m)
  Buffers: shared hit=15
  ->  Gather  (cost=99.24..99.55 rows=3 width=32) (actual time=49.159..121.624 rows=4 loops=1)
        Output: (PARTIAL subtract_matrix(m))
        Workers Planned: 3
        Workers Launched: 3
        Buffers: shared hit=15
        ->  Partial Aggregate  (cost=99.24..99.25 rows=1 width=32) (actual time=6.793..6.793 rows=1 loops=4)
              Output: PARTIAL subtract_matrix(m)
              Buffers: shared hit=15
              Worker 0: actual time=0.017..0.017 rows=1 loops=1
              Worker 1: actual time=0.020..0.020 rows=1 loops=1
              Worker 2: actual time=0.017..0.017 rows=1 loops=1
              ->  Parallel Seq Scan on public.matrix_table  (cost=0.00..18.24 rows=324 width=86) (actual time=0.006..0.111 rows=251 loops=4)
                    Output: m
                    Buffers: shared hit=15
                    Worker 0: actual time=0.003..0.003 rows=0 loops=1
                    Worker 1: actual time=0.002..0.002 rows=0 loops=1
                    Worker 2: actual time=0.002..0.002 rows=0 loops=1
Planning Time: 1.589 ms
Execution Time: 125.380 ms
```

#### Вывод

На агрегатные операции умножений и делений не хватает памяти, 
а скорее всего числа выходят за границы дабла. 
Где-то снижал кол-во данных для того, чтобы запускать тесты.
В целом, воркеры показывают себя в 10-100 раз хуже. 

#### Вывод


### Parallel workers default

```sql
SET parallel_setup_cost=1000;
SET min_parallel_table_scan_size='8MB';
SET max_parallel_workers_per_gather=2;
```
