\set id random(1,100000)
SELECT * FROM lab17_btree
WHERE name = 'name' || :id;
