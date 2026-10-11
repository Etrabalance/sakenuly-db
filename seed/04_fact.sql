\set ON_ERROR_STOP on
\echo === WEEK 04: generating 300,000 synthetic menu views ===
\echo === Simulation year: 2027. These are NOT real customer visits. ===
\echo === The new dish_view table is TRUNCATED on rerun; all other tables are preserved. ===
\timing on

CREATE TABLE IF NOT EXISTS food_delivery.dish_view (
    view_id bigint PRIMARY KEY,
    dish_id bigint NOT NULL REFERENCES food_delivery.dish(dish_id) ON DELETE RESTRICT,
    viewed_at timestamptz NOT NULL,
    source text NOT NULL CHECK (source IN ('app','web','partner'))
);

BEGIN;
TRUNCATE TABLE food_delivery.dish_view;
-- PostgreSQL's seeded random sequence makes repeated runs reproducible.
SELECT setseed(0.2026);

-- Weekends 43% of views although only ~29% of the days;
-- January/December 25% of views although only ~17% of days;
-- midnight-05:59 only 3% of views; lunch and evening are peak hours.
WITH calendar AS MATERIALIZED (
 SELECT
  array_agg(d::date ORDER BY d) FILTER (
    WHERE extract(isodow FROM d) IN (6,7) AND extract(month FROM d) IN (1,12)) AS winter_weekends,
  array_agg(d::date ORDER BY d) FILTER (
    WHERE extract(isodow FROM d) BETWEEN 1 AND 5 AND extract(month FROM d) IN (1,12)) AS winter_weekdays,
  array_agg(d::date ORDER BY d) FILTER (
    WHERE extract(isodow FROM d) IN (6,7) AND extract(month FROM d) NOT IN (1,12)) AS other_weekends,
  array_agg(d::date ORDER BY d) FILTER (
    WHERE extract(isodow FROM d) BETWEEN 1 AND 5 AND extract(month FROM d) NOT IN (1,12)) AS other_weekdays
 FROM generate_series(date '2027-01-01',date '2027-12-31', interval '1 day') AS x(d)
),
dish_ids AS MATERIALIZED (
  SELECT array_agg(dish_id ORDER BY dish_id) AS ids
  FROM food_delivery.dish WHERE is_available = true
),
samples AS MATERIALIZED (
 SELECT n,
        random() AS r_weekend,
        random() AS r_winter,
        random() AS r_day,
        random() AS r_hour,
        random() AS r_minute,
        random() AS r_second,
        random() AS r_dish,
        random() AS r_source
 FROM generate_series(1,300000) AS g(n)
),
chosen AS (
 SELECT s.n, s.r_hour, s.r_minute, s.r_second, s.r_source, s.r_dish,
   CASE
      WHEN s.r_winter < 0.25 AND s.r_weekend < 0.43 THEN
          c.winter_weekends[1 + floor(s.r_day * array_length(c.winter_weekends,1))::int]
      WHEN s.r_winter < 0.25 THEN
          c.winter_weekdays[1 + floor(s.r_day * array_length(c.winter_weekdays,1))::int]
      WHEN s.r_weekend < 0.43 THEN
          c.other_weekends[1 + floor(s.r_day * array_length(c.other_weekends,1))::int]
      ELSE
          c.other_weekdays[1 + floor(s.r_day * array_length(c.other_weekdays,1))::int]
   END AS day_date,
   d.ids[1 + floor(s.r_dish * array_length(d.ids,1))::int] AS selected_dish
 FROM samples s CROSS JOIN calendar c CROSS JOIN dish_ids d
),
times AS (
 SELECT n, selected_dish, day_date, r_minute, r_second, r_source,
  CASE
   WHEN r_hour < 0.03 THEN floor(r_hour / 0.03 * 6)::int
   WHEN r_hour < 0.13 THEN 6 + floor((r_hour - 0.03) / 0.10 * 5)::int
   WHEN r_hour < 0.48 THEN 11 + floor((r_hour - 0.13) / 0.35 * 4)::int
   WHEN r_hour < 0.58 THEN 15 + floor((r_hour - 0.48) / 0.10 * 3)::int
   ELSE 18 + floor((r_hour - 0.58) / 0.42 * 6)::int
  END AS local_hour
 FROM chosen
)
INSERT INTO food_delivery.dish_view (view_id,dish_id,viewed_at,source)
SELECT n, selected_dish,
  (day_date::timestamp AT TIME ZONE 'Asia/Almaty')
       + local_hour * interval '1 hour'
       + floor(r_minute * 60)::int * interval '1 minute'
       + floor(r_second * 60)::int * interval '1 second',
  CASE WHEN r_source < 0.70 THEN 'app'
       WHEN r_source < 0.95 THEN 'web'
       ELSE 'partner' END
FROM times
ORDER BY n;

COMMIT;

-- Secondary indexes accelerate later queries; their creation is timed separately.
CREATE INDEX IF NOT EXISTS dish_view_viewed_at_idx ON food_delivery.dish_view(viewed_at);
CREATE INDEX IF NOT EXISTS dish_view_dish_id_idx ON food_delivery.dish_view(dish_id);

SELECT count(*) AS fact_rows FROM food_delivery.dish_view;
SELECT pg_size_pretty(pg_database_size(current_database())) AS database_size,
       round(pg_database_size(current_database()) / 1024.0 / 1024.0, 2) AS size_mb;
\echo === Fact generation finished ===
