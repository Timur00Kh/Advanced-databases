\set r random(1, 99)
SELECT * FROM lab19_btree WHERE content LIKE 'text' || :r || '%'