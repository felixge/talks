DROP SCHEMA IF EXISTS uda CASCADE;
CREATE SCHEMA uda;
SET search_path=uda;

CREATE TABLE yields AS
SELECT *
FROM (VALUES
  ('day-1', 'step-1', 0.80),
  ('day-1', 'step-2', 0.90),
  ('day-1', 'step-3', 0.75),
  ('day-2', 'step-1', 0.90),
  ('day-2', 'step-2', 0.80),
  ('day-2', 'step-3', 0.99)
) vals(day, step, yield);

SELECT * FROM yields;

SELECT day, product(yield)
FROM yields
GROUP BY 1;


CREATE FUNCTION product_sf(state anyelement, val anyelement) RETURNS anyelement
LANGUAGE sql IMMUTABLE
AS $$
  SELECT state * val;
$$;


CREATE AGGREGATE product(anyelement) (
  initcond = 1,
  sfunc    = product_sf,
  stype    = anyelement
);

SELECT day, product(yield)
FROM yields
GROUP BY 1;

SELECT *, product(yield) OVER (PARTITION BY day ORDER BY step)
FROM yields;
