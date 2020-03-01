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


--1-------------------------
----------------------------
CREATE TABLE toast_plain (
    s varchar
);
ALTER TABLE toast_plain
    ALTER COLUMN s SET STORAGE PLAIN;

INSERT INTO toast_plain
    SELECT generate_varchar(3072)
        FROM generate_series(1, 100) AS k(i);

--2-------------------------
----------------------------
CREATE TABLE toast_extended(
    s varchar
);
ALTER TABLE toast_extended
    ALTER COLUMN s SET STORAGE extended;

INSERT INTO toast_extended
    SELECT generate_varchar(3072)
        FROM generate_series(1, 100) AS k(i);

--3-------------------------
----------------------------
CREATE TABLE toast_external(
    s varchar
);
ALTER TABLE toast_external
    ALTER COLUMN s SET STORAGE external;

INSERT INTO toast_external
    SELECT generate_varchar(3072)
        FROM generate_series(1, 100) AS k(i);

--4-------------------------
----------------------------
CREATE TABLE toast_main(
    s varchar
);
ALTER TABLE toast_main
    ALTER COLUMN s SET STORAGE main;

INSERT INTO toast_main
    SELECT generate_varchar(3072)
        FROM generate_series(1, 100) AS k(i);



--Table meta
SELECT class.oid                                   AS "OID",
       relname                                     AS "Relation Name",
       schema.nspname                              AS "Schema",
       usr.rolname                                 AS "Object Owner",
       coalesce(tblsp.spcname, 'pg_default')       AS "Tablespace",
       relpages                                    AS "Amount Pages",
       reltuples                                   AS "Amount Tuples",
       reltoastrelid                               AS "TOAST table",
       CASE
           WHEN relpersistence = 'p' THEN 'Permanent'
           WHEN relpersistence = 't' THEN 'Temporary'
           ELSE 'Unlogged'
           END                                     AS "Type",
       pg_relation_filepath(class.oid)             AS "File Path",
       pg_size_pretty(pg_relation_size(class.oid)) AS "Relation Size"
FROM pg_class class
         INNER JOIN pg_namespace schema
                    ON schema.oid = class.relnamespace
         INNER JOIN pg_authid usr
                    ON usr.oid = class.relowner
         LEFT JOIN pg_tablespace tblsp
                   ON tblsp.oid = class.reltablespace
WHERE relname = ?;
--toast_plain
--toast_extended
--toast_external
--toast_main

--Table TOASTS
SELECT relname, relpages, oid
FROM pg_class,
     (SELECT reltoastrelid
      FROM pg_class
      WHERE relname = ?) AS ss
WHERE oid = ss.reltoastrelid
   OR oid = (SELECT indexrelid
             FROM pg_index
             WHERE indrelid = ss.reltoastrelid);
--toast_plain       pg_toast_16614
--toast_extended    pg_toast_16620
--toast_external    pg_toast_16626
--toast_main        pg_toast_16732

SELECT * FROM pg_toast.pg_toast_16614;
SELECT * FROM pg_toast.pg_toast_16620;
SELECT * FROM pg_toast.pg_toast_16626;
SELECT * FROM pg_toast.pg_toast_16732;

--TOAST strategy
SELECT attr.attname,
       CASE
           WHEN attstorage = 'p' THEN 'plain'
           WHEN attstorage = 'x' THEN 'extended'
           WHEN attstorage = 'e' THEN 'external'
           WHEN attstorage = 'm' THEN 'main'
           END AS attstorage
FROM pg_attribute attr
WHERE attrelid = ?
ORDER BY attr.attnum;
--toast_plain       pg_toast_16614 16614
--toast_extended    pg_toast_16620 16620
--toast_external    pg_toast_16626 16626
--toast_main        pg_toast_16732 16732

--plain         [11,8,10,7,9,17,10,11,9,15,10,12,11,11,7,17,8,12,10,8,10,9,13,13,6,12,9,10,10,8,8,8,7,7,7,13,6,5,7,10,6,8,10,6,7,8,5,5,8,8]     9.24ms
--extended      [16,9,12,9,9,10,9,14,9,17,7,9,5,9,14,6,7,5,8,7,8,6,5,7,9,13,8,13,7,13,6,7,6,6,8,7,35,7,8,7,10,5,7,10,7,6,8,5,9,5]               8.98ms
--external      [14,10,6,8,6,5,7,6,9,13,6,6,8,6,9,6,10,7,6,8,6,7,10,7,15,8,6,7,9,9,8,6,11,22,9,10,11,10,8,9,10,11,6,8,6,8,6,8,7,7]              8.42ms
--main          [8,8,8,8,6,7,6,8,6,5,5,14,7,7,7,7,6,9,7,6,7,8,6,6,6,6,5,14,6,6,6,7,6,9,6,6,7,5,5,6,7,8,11,6,6,9,5,6,5,10]                       7.02ms



SELECT * FROM pgstattuple(16614);
SELECT * FROM pgstattuple(16617);

SELECT * FROM pgstattuple(16620);
SELECT * FROM pgstattuple(16623);

SELECT * FROM pgstattuple(16626);
SELECT * FROM pgstattuple(16629);

SELECT * FROM pgstattuple(16732);
SELECT * FROM pgstattuple(16735);

SELECT * FROM page_header(get_raw_page('pg_toast.pg_toast_16620', 0));
SELECT * FROM page_header(get_raw_page('pg_toast.pg_toast_16626', 0));
