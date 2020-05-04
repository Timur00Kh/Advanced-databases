\set id random(1,1000000)
begin;
select * from heap_table_lab5 where id = :id;
commit;