\set r random(1, 99)
SELECT * FROM lab19_gist WHERE content LIKE 'text' || :r || '%'