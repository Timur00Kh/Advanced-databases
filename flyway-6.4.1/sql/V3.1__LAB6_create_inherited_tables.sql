CREATE TABLE student_hub (
    id bigint,
    name VARCHAR
);

CREATE TABLE student1 () INHERITS (student_hub);
ALTER TABLE student1 ADD CONSTRAINT partition_check
CHECK ( id >= 0 and id < 100000 );

CREATE TABLE student2 () INHERITS (student_hub);
ALTER TABLE student2 ADD CONSTRAINT partition_check
CHECK ( id >= 100000 and id < 200000 );

CREATE TABLE student3 () INHERITS (student_hub);
ALTER TABLE student3 ADD CONSTRAINT partition_check
CHECK ( id >= 200000 and id < 300000 );

CREATE TABLE student4 () INHERITS (student_hub);
ALTER TABLE student4 ADD CONSTRAINT partition_check
CHECK ( id >= 300000 and id < 400000 );

CREATE TABLE student5 () INHERITS (student_hub);
ALTER TABLE student5 ADD CONSTRAINT partition_check
CHECK ( id >= 400000 and id < 500000 );

CREATE TABLE student6 () INHERITS (student_hub);
ALTER TABLE student6 ADD CONSTRAINT partition_check
CHECK ( id >= 500000 and id < 600000 );

CREATE TABLE student7 () INHERITS (student_hub);
ALTER TABLE student7 ADD CONSTRAINT partition_check
CHECK ( id >= 600000 and id < 700000 );

CREATE TABLE student8 () INHERITS (student_hub);
ALTER TABLE student8 ADD CONSTRAINT partition_check
CHECK ( id >= 700000 and id < 800000 );

CREATE TABLE student9 () INHERITS (student_hub);
ALTER TABLE student9 ADD CONSTRAINT partition_check
CHECK ( id >= 800000 and id < 900000 );

CREATE TABLE student10 () INHERITS (student_hub);
ALTER TABLE student10 ADD CONSTRAINT partition_check
CHECK ( id >= 900000 and id < 1000000 );