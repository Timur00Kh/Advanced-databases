CREATE TYPE complex AS
(
    r double precision,
    i double precision
);

CREATE OR REPLACE FUNCTION sum_complex(c1 complex, c2 complex) RETURNS complex
AS
$$
BEGIN
    RETURN ROW (c1.r + c2.r, c1.i + c2.i)::complex;
end
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION subtract_complex(c1 complex, c2 complex) RETURNS complex
AS
$$
BEGIN
    RETURN ROW (c1.r - c2.r, c1.i - c2.i)::complex;
end
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION multiply_complex(c1 complex, c2 complex) RETURNS complex
AS
$$
BEGIN
    RETURN ROW (c1.r * c2.r - c1.i * c2.i, c1.r * c2.i + c2.r * c1.i)::complex;
end
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION divide_complex(c1 complex, c2 complex) RETURNS complex
AS
$$
DECLARE
    r double precision;
    i double precision;
BEGIN
    r = (c1.r * c2.r + c1.i * c2.i) / (pow(c2.r, 2) + pow(c2.i, 2));
    i = (c2.r * c1.i - c1.r * c2.i) / (pow(c2.r, 2) + pow(c2.i, 2));
    RETURN ROW(r, i)::complex;
end
$$ LANGUAGE plpgsql;


SELECT sum_complex((3, 5), (10, 2));
SELECT subtract_complex((3, 5), (10, 2));
SELECT multiply_complex((3, 5), (10, 2));
SELECT divide_complex((3, 5), (10, 2));


--AGGREGATES
CREATE AGGREGATE sum_complex(complex) (
    sfunc = sum_complex,
    stype = complex,
    combinefunc = sum_complex,
    initcond = '(0,0)',
    parallel = safe
);

CREATE AGGREGATE subtract_complex(complex) (
    sfunc = subtract_complex,
    stype = complex,
    combinefunc = subtract_complex,
    initcond = '(0,0)',
    parallel = safe
);

CREATE AGGREGATE multiply_complex(complex) (
    sfunc = multiply_complex,
    stype = complex,
    combinefunc = multiply_complex,
    initcond = '(1,1)',
    parallel = safe
);

CREATE AGGREGATE divide_complex(complex) (
    sfunc = divide_complex,
    stype = complex,
    combinefunc = divide_complex,
    initcond = '(1,1)',
    parallel = safe
);

DROP AGGREGATE multiply_complex(complex);

CREATE TABLE complex_heaven (
    n complex
);

INSERT INTO complex_heaven
SELECT ((random() * k)::int, ((1000 - k) * random())::int)::complex FROM
generate_series(1, 100) AS k(i);

SELECT sum_complex(n) FROM complex_heaven;
SELECT subtract_complex(n) FROM complex_heaven;
SELECT multiply_complex(n) FROM complex_heaven;
SELECT divide_complex(n) FROM complex_heaven;

