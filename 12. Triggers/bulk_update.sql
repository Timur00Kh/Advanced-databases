\set old_id random(:id1, :id2)
\set new_id random(:id1, :id2)
BEGIN;
UPDATE hub SET id = :new_id
WHERE id = :old_id;
END;