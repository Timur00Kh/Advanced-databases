
SHOW parallel_setup_cost;
SHOW min_parallel_table_scan_size;
SHOW max_parallel_workers_per_gather;

SET parallel_setup_cost=0;
SET min_parallel_table_scan_size=0;
SET max_parallel_workers_per_gather=5;

SET parallel_setup_cost=1000;
SET min_parallel_table_scan_size='8MB';
SET max_parallel_workers_per_gather=2;

EXPLAIN (ANALYSE, VERBOSE ,  BUFFERS)
SELECT sum_matrix(m) FROM matrix_table;

EXPLAIN (ANALYSE, VERBOSE ,  BUFFERS)
SELECT subtract_matrix(m) FROM matrix_table;

EXPLAIN (ANALYSE, VERBOSE ,  BUFFERS)
SELECT multiply_matrix(m) FROM matrix_table;




EXPLAIN (ANALYSE, VERBOSE ,  BUFFERS)
SELECT sum_complex(n) FROM complex_heaven;

EXPLAIN (ANALYSE, VERBOSE ,  BUFFERS)
SELECT subtract_complex(n) FROM complex_heaven;

EXPLAIN (ANALYSE, VERBOSE ,  BUFFERS)
SELECT multiply_complex(n) FROM complex_heaven;

EXPLAIN (ANALYSE, VERBOSE ,  BUFFERS)
SELECT divide_complex(n) FROM complex_heaven;