\set aid random(:id1, :id2)
BEGIN;
UPDATE unlogged_table SET description = 'pgbench_bulk_update_test_text'
WHERE id = :aid;
END;