\set ON_ERROR_STOP on
\echo === WEEK 04: COPY, ON CONFLICT, UPDATE FROM ===
\timing on
BEGIN;

-- COPY FROM: import an external CSV into a staging table, not into the live table.
CREATE TEMP TABLE week04_category_staging (
  name text NOT NULL,
  description text NOT NULL
) ON COMMIT DROP;
\copy week04_category_staging (name,description) FROM 'seed/week04_category_updates.csv' WITH (FORMAT csv, HEADER true, ENCODING 'UTF8')

-- ON CONFLICT: existing category descriptions are updated, new categories inserted.
INSERT INTO food_delivery.category (name,description)
SELECT name, description FROM week04_category_staging
WHERE true
ON CONFLICT (name) DO UPDATE
SET description = EXCLUDED.description;

-- UPDATE FROM: restaurant ratings follow actual existing review scores.
UPDATE food_delivery.restaurant AS r
SET rating = s.avg_rating
FROM (
  SELECT o.restaurant_id, round(avg(rv.rating)::numeric,1) AS avg_rating
  FROM food_delivery.review AS rv
  JOIN food_delivery.orders AS o ON o.order_id = rv.order_id
  GROUP BY o.restaurant_id
) AS s
WHERE r.restaurant_id = s.restaurant_id;

COMMIT;

-- COPY TO: export the updated live category directory to a CSV file.
\copy (SELECT category_id, name, description FROM food_delivery.category ORDER BY category_id) TO 'seed/week04_categories_export.csv' WITH (FORMAT csv, HEADER true, ENCODING 'UTF8')
\echo === DML tasks finished; exported seed/week04_categories_export.csv ===
