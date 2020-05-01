\set aid random(:id1, :id2)
BEGIN;
DELETE FROM unlogged_table
WHERE id = :aid;
END;