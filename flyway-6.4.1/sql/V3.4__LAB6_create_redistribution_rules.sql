--INSERTS
CREATE OR REPLACE RULE redirect_update_to_student1
    AS ON UPDATE TO student_hub
    WHERE NEW.id BETWEEN 0 AND 99999
    DO INSTEAD
    INSERT INTO student1
    VALUES (NEW.id, NEW.name);

CREATE OR REPLACE RULE redirect_update_to_student2
    AS ON UPDATE TO student_hub
    WHERE NEW.id BETWEEN 100000 AND 199999
    DO INSTEAD
    INSERT INTO student2
    VALUES (NEW.id, NEW.name);

CREATE OR REPLACE RULE redirect_update_to_student3
    AS ON UPDATE TO student_hub
    WHERE NEW.id BETWEEN 200000 AND 299999
    DO INSTEAD
    INSERT INTO student3
    VALUES (NEW.id, NEW.name);

CREATE OR REPLACE RULE redirect_update_to_student4
    AS ON UPDATE TO student_hub
    WHERE NEW.id BETWEEN 300000 AND 399999
    DO INSTEAD
    INSERT INTO student4
    VALUES (NEW.id, NEW.name);

CREATE OR REPLACE RULE redirect_update_to_student5
    AS ON UPDATE TO student_hub
    WHERE NEW.id BETWEEN 400000 AND 499999
    DO INSTEAD
    INSERT INTO student5
    VALUES (NEW.id, NEW.name);

CREATE OR REPLACE RULE redirect_update_to_student6
    AS ON UPDATE TO student_hub
    WHERE NEW.id BETWEEN 500000 AND 599999
    DO INSTEAD
    INSERT INTO student6
    VALUES (NEW.id, NEW.name);

CREATE OR REPLACE RULE redirect_update_to_student7
    AS ON UPDATE TO student_hub
    WHERE NEW.id BETWEEN 600000 AND 699999
    DO INSTEAD
    INSERT INTO student7
    VALUES (NEW.id, NEW.name);

CREATE OR REPLACE RULE redirect_update_to_student8
    AS ON UPDATE TO student_hub
    WHERE NEW.id BETWEEN 700000 AND 799999
    DO INSTEAD
    INSERT INTO student8
    VALUES (NEW.id, NEW.name);

CREATE OR REPLACE RULE redirect_update_to_student9
    AS ON UPDATE TO student_hub
    WHERE NEW.id BETWEEN 800000 AND 899999
    DO INSTEAD
    INSERT INTO student9
    VALUES (NEW.id, NEW.name);

CREATE OR REPLACE RULE redirect_update_to_student10
    AS ON UPDATE TO student_hub
    WHERE NEW.id BETWEEN 900000 AND 999999
    DO INSTEAD
    INSERT INTO student10
    VALUES (NEW.id, NEW.name);

--DELETES
CREATE OR REPLACE RULE redirect_w_delete_from_student1
    AS ON UPDATE TO student_hub
    WHERE OLD.id BETWEEN 0 AND 99999
    DO INSTEAD
    DELETE FROM student1
    WHERE student1.id = OLD.id;

CREATE OR REPLACE RULE redirect_w_delete_from_student2
    AS ON UPDATE TO student_hub
    WHERE OLD.id BETWEEN 100000 AND 199999
    DO INSTEAD
    DELETE FROM student2
    WHERE student2.id = OLD.id;

CREATE OR REPLACE RULE redirect_w_delete_from_student3
    AS ON UPDATE TO student_hub
    WHERE OLD.id BETWEEN 200000 AND 299999
    DO INSTEAD
    DELETE FROM student3
    WHERE student3.id = OLD.id;

CREATE OR REPLACE RULE redirect_w_delete_from_student4
    AS ON UPDATE TO student_hub
    WHERE OLD.id BETWEEN 300000 AND 399999
    DO INSTEAD
    DELETE FROM student4
    WHERE student4.id = OLD.id;

CREATE OR REPLACE RULE redirect_w_delete_from_student5
    AS ON UPDATE TO student_hub
    WHERE OLD.id BETWEEN 400000 AND 499999
    DO INSTEAD
    DELETE FROM student5
    WHERE student5.id = OLD.id;

CREATE OR REPLACE RULE redirect_w_delete_from_student6
    AS ON UPDATE TO student_hub
    WHERE OLD.id BETWEEN 500000 AND 599999
    DO INSTEAD
    DELETE FROM student6
    WHERE student6.id = OLD.id;

CREATE OR REPLACE RULE redirect_w_delete_from_student7
    AS ON UPDATE TO student_hub
    WHERE OLD.id BETWEEN 600000 AND 699999
    DO INSTEAD
    DELETE FROM student7
    WHERE student7.id = OLD.id;

CREATE OR REPLACE RULE redirect_w_delete_from_student8
    AS ON UPDATE TO student_hub
    WHERE OLD.id BETWEEN 700000 AND 799999
    DO INSTEAD
    DELETE FROM student8
    WHERE student8.id = OLD.id;

CREATE OR REPLACE RULE redirect_w_delete_from_student9
    AS ON UPDATE TO student_hub
    WHERE OLD.id BETWEEN 800000 AND 899999
    DO INSTEAD
    DELETE FROM student9
    WHERE student9.id = OLD.id;

CREATE OR REPLACE RULE redirect_w_delete_from_student10
    AS ON UPDATE TO student_hub
    WHERE OLD.id BETWEEN 9000000 AND 999999
    DO INSTEAD
    DELETE FROM student10
    WHERE student10.id = OLD.id;