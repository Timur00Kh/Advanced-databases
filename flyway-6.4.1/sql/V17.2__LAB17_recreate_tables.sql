DROP TABLE IF EXISTS lab17_btree;
DROP TABLE IF EXISTS lab17_hash;
DROP TABLE IF EXISTS lab17_brin;

create table lab17_btree (
   id bigint,
   name varchar
);

create table lab17_hash (
  id bigint,
  name varchar
);

create table lab17_brin (
  id bigint,
  name varchar
);

create index btree_index on lab17_btree using btree(name);
create index hash_index on lab17_hash using hash(name);
create index brin_index on lab17_brin using brin(name);

DO
$do$
   BEGIN
       FOR i IN 1..100000 LOOP
            insert into lab17_btree (id, name) values (random() * 10000, 'name' || i);
            insert into lab17_hash (id, name) values (random() * 10000, 'name' || i);
            insert into lab17_brin (id, name) values (random() * 10000, 'name' || i);
           END LOOP;
   END
$do$;
