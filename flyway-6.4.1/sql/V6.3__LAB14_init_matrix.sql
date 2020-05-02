CREATE TYPE matrix AS
(
    m int[][]
);

CREATE OR REPLACE FUNCTION sum_matrix(m1 matrix, m2 matrix) RETURNS matrix AS
$$
DECLARE
    l1 int         = greatest(array_length(m1.m, 1), array_length(m2.m, 1));
    l2 int         = greatest(array_length(m1.m, 2), array_length(m2.m, 2));
    m  integer[][] = array_fill(0, ARRAY [l1, l2]);
BEGIN
    -- сейчас матрицы разных размеров достраиваются до нужного размера.
-- в проде лучше RAISE EXCEPTION наверное
    FOR i IN 1..l1
        LOOP
            FOR j IN 1..l2
                LOOP
                    m[i][j] = coalesce(m1.m[i][j], 0) + coalesce(m2.m[i][j], 0);
                END LOOP;
        END LOOP;
    RETURN ROW (m)::matrix;

end;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION subtract_matrix(m1 matrix, m2 matrix) RETURNS matrix AS
$$
DECLARE
    l1 int         = greatest(array_length(m1.m, 1), array_length(m2.m, 1));
    l2 int         = greatest(array_length(m1.m, 2), array_length(m2.m, 2));
    m  integer[][] = array_fill(0, ARRAY [l1, l2]);
BEGIN
    -- сейчас матрицы разных размеров достраиваются до нужного размера.
    -- в проде лучше RAISE EXCEPTION наверное
    FOR i IN 1..l1
        LOOP
            FOR j IN 1..l2
                LOOP
                    m[i][j] = coalesce(m1.m[i][j], 0) - coalesce(m2.m[i][j], 0);
                END LOOP;
        END LOOP;
    RETURN ROW (m)::matrix;

end;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION multiply_matrix(m1 matrix, m2 matrix) RETURNS matrix AS
$$
DECLARE
    m   int         = array_length(m1.m, 1);
    n1  int         = array_length(m1.m, 2);
    n2  int         = array_length(m2.m, 1);
    k   int         = array_length(m2.m, 2);
    mat integer[][] = array_fill(0, ARRAY [m, k]);
BEGIN
    IF NOT (n1 = n2) THEN
        RAISE EXCEPTION 'Две матрицы можно перемножить между собой тогда и только тогда,
            когда количество столбцов первой матрицы равно количеству строк второй матрицы.';
    end if;
    FOR i IN 1..m
        LOOP
            FOR j IN 1..k
                LOOP
                    FOR s IN 1..n1
                        LOOP
                            mat[i][j] = mat[i][j] + m1.m[i][s] * m2.m[s][j];
                        END LOOP;
                END LOOP;
        END LOOP;
    RETURN ROW (mat)::matrix;

end;
$$ LANGUAGE plpgsql;


-- AGGREGATES
CREATE AGGREGATE sum_matrix(matrix) (
    sfunc = sum_matrix,
    stype = matrix,
    combinefunc = sum_matrix,
    initcond = '("{{0,0,0},{0,0,0},{0,0,0}}")',
    parallel = safe
);

CREATE AGGREGATE subtract_matrix(matrix) (
    sfunc = subtract_matrix,
    stype = matrix,
    combinefunc = subtract_matrix,
    initcond = '("{{0,0,0},{0,0,0},{0,0,0}}")',
    parallel = safe
);

CREATE AGGREGATE multiply_matrix(matrix) (
    sfunc = multiply_matrix,
    stype = matrix,
    combinefunc = multiply_matrix,
    initcond = '("{{1,1,1},{1,1,1},{1,1,1}}")',
    parallel = safe
);

