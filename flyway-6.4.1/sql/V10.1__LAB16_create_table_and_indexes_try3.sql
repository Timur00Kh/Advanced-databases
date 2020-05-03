DROP TABLE IF EXISTS index_test;

CREATE TABLE index_test (
    A integer,
    B integer,
    C integer
);

CREATE INDEX i_A ON index_test USING btree (A);
CREATE INDEX i_B ON index_test USING btree (B);
CREATE INDEX i_C ON index_test USING btree (C);

CREATE INDEX i_AB ON index_test USING btree (A, B);
CREATE INDEX i_AC ON index_test USING btree (A, C);
CREATE INDEX i_BA ON index_test USING btree (B, A);
CREATE INDEX i_BC ON index_test USING btree (B, C);
CREATE INDEX i_CA ON index_test USING btree (C, A);
CREATE INDEX i_CB ON index_test USING btree (C, B);

CREATE INDEX i_ABC ON index_test USING btree (A, B, C);
CREATE INDEX i_ACB ON index_test USING btree (A, C, B);
CREATE INDEX i_BAC ON index_test USING btree (B, A, C);
CREATE INDEX i_BCA ON index_test USING btree (B, C, A);
CREATE INDEX i_CAB ON index_test USING btree (C, A, B);
CREATE INDEX i_CBA ON index_test USING btree (C, B, A);



INSERT INTO index_test
SELECT random() * 10, random() * 10, random() * 10
FROM generate_series(1, 1000) AS k(i);