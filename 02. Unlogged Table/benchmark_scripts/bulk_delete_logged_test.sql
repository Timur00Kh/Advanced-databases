\set aid random(:id1, :id2)
BEGIN;
DELETE FROM logged_table
WHERE id = :aid;
END;