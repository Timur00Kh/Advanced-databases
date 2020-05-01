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
--f50   17937
--f75   17940
--f90   17943
--f100  17946

SELECT * FROM pgstattuple(17937);
SELECT * FROM pgstattuple(17940);
SELECT * FROM pgstattuple(17943);
SELECT * FROM pgstattuple(17946);
