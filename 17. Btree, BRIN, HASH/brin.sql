\set id random(1,100000)
SELECT * FROM lab17_brin
WHERE name = 'name' || :id;
