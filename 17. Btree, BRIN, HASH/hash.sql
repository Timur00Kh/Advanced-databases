\set id random(1,100000)
SELECT * FROM lab17_hash
WHERE name = 'name' || :id;

