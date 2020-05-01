--TRUNCATE only for test
TRUNCATE student1;
TRUNCATE student2;
TRUNCATE student3;
TRUNCATE student4;
TRUNCATE student5;
TRUNCATE student6;
TRUNCATE student7;
TRUNCATE student8;
TRUNCATE student9;
TRUNCATE student10;

INSERT INTO student_hub
SELECT k, 'student' || k
FROM generate_series(0, 999999) AS k(i);