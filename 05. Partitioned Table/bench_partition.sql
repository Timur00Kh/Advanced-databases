\set id random(1,1000000)
begin;
select * from partition_table where id = :id;
commit;
