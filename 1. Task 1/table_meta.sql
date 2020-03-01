--SOURCE: https://drive.google.com/file/d/1W8SyaxpE4tSWMNimB3r9Y3H-wcCh2Fg0/view

CREATE TABLE two_text_table
(
    one varchar,
    two varchar
);

--page 4
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
WHERE relname = 'two_text_table';

--page 19
BEGIN;
INSERT INTO public.two_text_table
SELECT generate_varchar(30072), generate_varchar(3072)
FROM generate_series(1, 100) AS k(i);
COMMIT;


--page 29
SELECT relname, relpages, oid
FROM pg_class,
     (SELECT reltoastrelid
      FROM pg_class
      WHERE relname = 'two_text_table') AS ss
WHERE oid = ss.reltoastrelid
   OR oid = (SELECT indexrelid
             FROM pg_index
             WHERE indrelid = ss.reltoastrelid);

--page 34
SELECT *
FROM pg_toast.pg_toast_16401;

ALTER TABLE two_text_table
    ALTER COLUMN two SET STORAGE PLAIN;
ANALYSE pg_toast.pg_toast_16401;


--page 39
SELECT attr.attname,
       two_text_table.typname,
       CASE
           WHEN attstorage = 'p' THEN 'plain'
           WHEN attstorage = 'x' THEN 'extended'
           WHEN attstorage = 'e' THEN 'external'
           WHEN attstorage = 'm' THEN 'main'
           END AS attstorage
FROM pg_attribute attr
         INNER JOIN
     pg_type two_text_table ON two_text_table.OID = attr.atttypid
WHERE attrelid = 16401
ORDER BY attr.attnum;

--page 35
SELECT *
FROM page_header(get_raw_page('pg_toast.pg_toast_16556',0));