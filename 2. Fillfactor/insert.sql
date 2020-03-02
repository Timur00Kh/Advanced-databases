TRUNCATE f50;
TRUNCATE f75;
TRUNCATE f90;
TRUNCATE f100;

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
    i = 1;
    LOOP
        s = s || chars[1+random()*(array_length(chars, 1)-1)];
        IF i >= n
        THEN
            EXIT;
        END IF;
        i = i + 1;
    END LOOP;
    RETURN s;
END;
$BODY$
LANGUAGE plpgsql;

INSERT INTO f50
SELECT k, generate_varchar(50), (select current_date)
FROM generate_series(1, 10000) AS k(i);

INSERT INTO f75
SELECT k, generate_varchar(50), (select current_date)
FROM generate_series(1, 10000) AS k(i);

INSERT INTO f90
SELECT k, generate_varchar(50), (select current_date)
FROM generate_series(1, 10000) AS k(i);

INSERT INTO f100
SELECT k, generate_varchar(50), (select current_date)
FROM generate_series(1, 10000) AS k(i);