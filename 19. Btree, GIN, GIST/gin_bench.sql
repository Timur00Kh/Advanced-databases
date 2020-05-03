\set r random(1, 99)
SELECT * FROM lab19_gin WHERE content LIKE 'text' || :r || '%'