create table lab22_table_1 (
   id bigserial,
   name text
);
create table lab22_table_2 (
    id bigserial,
    name text
);
create table lab22_table_3 (
    id bigserial,
    name text
);

--varchar generator
CREATE OR REPLACE FUNCTION generate_varchar(n INT)
  RETURNS VARCHAR AS
$BODY$
DECLARE
  s     varchar;
  i     int;
  chars text [] := '{0,1,2,3,4,5,6,7,8,9,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z}';
BEGIN
  s = '';
  i = 0;
  LOOP
    s = s || chars[1+random()*(array_length(chars, 1)-1)];
    IF i > n
    THEN
      EXIT;
    END IF;
    i = i + 1;
  END LOOP;
  RETURN s;
END;
$BODY$
LANGUAGE plpgsql;

DO
$do$
   BEGIN
       FOR i IN 1..1000 LOOP
               insert into lab22_table_1 (name) values (generate_varchar(15));
               insert into lab22_table_2 (name) values (generate_varchar(15));
               insert into lab22_table_3 (name) values (generate_varchar(15));
           END LOOP;
   END
$do$;

DO
$do$
   BEGIN
       FOR i IN 1..10000 LOOP
               insert into lab22_table_1 (name) values (generate_varchar(15));
               insert into lab22_table_2 (name) values (generate_varchar(15));
               insert into lab22_table_3 (name) values (generate_varchar(15));
           END LOOP;
   END
$do$;

DO
$do$
   BEGIN
       FOR i IN 1..100000 LOOP
               insert into lab22_table_1 (name) values (generate_varchar(15));
               insert into lab22_table_2 (name) values (generate_varchar(15));
               insert into lab22_table_3 (name) values (generate_varchar(15));
           END LOOP;
   END
$do$;

CREATE EXTENSION pg_prewarm;

SELECT pg_prewarm('lab22_table_1');
SELECT pg_prewarm('lab22_table_2');
SELECT pg_prewarm('lab22_table_3');

