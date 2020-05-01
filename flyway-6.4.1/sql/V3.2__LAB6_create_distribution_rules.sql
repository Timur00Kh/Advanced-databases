CREATE OR REPLACE RULE redirect_insert_to_student1
    AS ON INSERT TO student_hub
    WHERE NEW.id BETWEEN 0 AND 99999
    DO INSTEAD
    INSERT INTO student1
    VALUES (NEW.id, NEW.name);

CREATE OR REPLACE RULE redirect_insert_to_student2
    AS ON INSERT TO student_hub
    WHERE NEW.id BETWEEN 100000 AND 199999
    DO INSTEAD
    INSERT INTO student2
    VALUES (NEW.id, NEW.name);

CREATE OR REPLACE RULE redirect_insert_to_student3
    AS ON INSERT TO student_hub
    WHERE NEW.id BETWEEN 200000 AND 299999
    DO INSTEAD
    INSERT INTO student3
    VALUES (NEW.id, NEW.name);

CREATE OR REPLACE RULE redirect_insert_to_student4
    AS ON INSERT TO student_hub
    WHERE NEW.id BETWEEN 300000 AND 399999
    DO INSTEAD
    INSERT INTO student4
    VALUES (NEW.id, NEW.name);

CREATE OR REPLACE RULE redirect_insert_to_student5
    AS ON INSERT TO student_hub
    WHERE NEW.id BETWEEN 400000 AND 499999
    DO INSTEAD
    INSERT INTO student5
    VALUES (NEW.id, NEW.name);

CREATE OR REPLACE RULE redirect_insert_to_student6
    AS ON INSERT TO student_hub
    WHERE NEW.id BETWEEN 500000 AND 599999
    DO INSTEAD
    INSERT INTO student6
    VALUES (NEW.id, NEW.name);

CREATE OR REPLACE RULE redirect_insert_to_student7
    AS ON INSERT TO student_hub
    WHERE NEW.id BETWEEN 600000 AND 699999
    DO INSTEAD
    INSERT INTO student7
    VALUES (NEW.id, NEW.name);

CREATE OR REPLACE RULE redirect_insert_to_student8
    AS ON INSERT TO student_hub
    WHERE NEW.id BETWEEN 700000 AND 799999
    DO INSTEAD
    INSERT INTO student8
    VALUES (NEW.id, NEW.name);

CREATE OR REPLACE RULE redirect_insert_to_student9
    AS ON INSERT TO student_hub
    WHERE NEW.id BETWEEN 800000 AND 899999
    DO INSTEAD
    INSERT INTO student9
    VALUES (NEW.id, NEW.name);

CREATE OR REPLACE RULE redirect_insert_to_student10
    AS ON INSERT TO student_hub
    WHERE NEW.id BETWEEN 900000 AND 999999
    DO INSTEAD
    INSERT INTO student10
    VALUES (NEW.id, NEW.name);