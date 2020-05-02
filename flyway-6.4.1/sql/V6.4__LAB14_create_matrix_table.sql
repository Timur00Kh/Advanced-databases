CREATE TABLE matrix_table
(
    m matrix
);

INSERT INTO matrix_table
VALUES (ROW (ARRAY [
    [1,2,3],
    [1,2,3],
    [1,2,3]
    ])::matrix);

INSERT INTO matrix_table
VALUES (ROW (ARRAY [
    [1,2,3],
    [1,2,3],
    [1,2,3]
    ])::matrix);

INSERT INTO matrix_table
VALUES (ROW (ARRAY [
    [1,2,3],
    [1,2,3],
    [1,2,3]
    ])::matrix);

INSERT INTO matrix_table
VALUES (ROW (ARRAY [
    [1,2,3],
    [1,2,3],
    [1,2,3]
    ])::matrix);

INSERT INTO matrix_table
VALUES (ROW (ARRAY [
    [1,2,3],
    [1,2,3],
    [1,2,3]
    ])::matrix);


INSERT INTO matrix_table
SELECT (ROW (ARRAY [
    [random() * 10, random() * 10, random() * 10],
    [random() * 10, random() * 10, random() * 10],
    [random() * 10, random() * 10, random() * 10]
    ])::matrix) FROM
generate_series(1, 1000) AS k(i);
