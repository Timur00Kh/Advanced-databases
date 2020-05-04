CREATE TABLE clustered_table(
   id BIGSERIAL,
   melon_amount INT
);
CREATE INDEX IF NOT EXISTS clustered_table_index ON clustered_table (melon_amount);
