\set ON_ERROR_STOP on
\echo === WEEK 04: verify all 12 tables, distribution, database size ===
\timing on

SELECT table_name, n_rows FROM (
 SELECT 'category' AS table_name, count(*) AS n_rows FROM food_delivery.category
 UNION ALL SELECT 'courier', count(*) FROM food_delivery.courier
 UNION ALL SELECT 'customer', count(*) FROM food_delivery.customer
 UNION ALL SELECT 'delivery', count(*) FROM food_delivery.delivery
 UNION ALL SELECT 'dish', count(*) FROM food_delivery.dish
 UNION ALL SELECT 'dish_category', count(*) FROM food_delivery.dish_category
 UNION ALL SELECT 'dish_view', count(*) FROM food_delivery.dish_view
 UNION ALL SELECT 'order_item', count(*) FROM food_delivery.order_item
 UNION ALL SELECT 'orders', count(*) FROM food_delivery.orders
 UNION ALL SELECT 'payment', count(*) FROM food_delivery.payment
 UNION ALL SELECT 'restaurant', count(*) FROM food_delivery.restaurant
 UNION ALL SELECT 'review', count(*) FROM food_delivery.review
) AS all_counts ORDER BY table_name;

DO $$
BEGIN
 IF (SELECT count(*) FROM food_delivery.dish_view) <> 300000 THEN
  RAISE EXCEPTION 'Fact row count is not exactly 300000';
 END IF;
 IF (SELECT count(*) FROM food_delivery.category) < 50 OR
    (SELECT count(*) FROM food_delivery.customer) < 50 OR
    (SELECT count(*) FROM food_delivery.courier) < 50 OR
    (SELECT count(*) FROM food_delivery.restaurant) < 50 OR
    (SELECT count(*) FROM food_delivery.dish) < 50 THEN
  RAISE EXCEPTION 'A reference table has fewer than 50 rows';
 END IF;
END $$;

SELECT min(viewed_at) AS first_view, max(viewed_at) AS last_view,
       count(*) AS total_views,
       count(DISTINCT dish_id) AS distinct_dishes
FROM food_delivery.dish_view;

WITH daily AS (
 SELECT COUNT(*) FILTER (WHERE extract(isodow FROM viewed_at AT TIME ZONE 'Asia/Almaty') IN (6,7))::numeric AS weekend_views,
        COUNT(*) FILTER (WHERE extract(isodow FROM viewed_at AT TIME ZONE 'Asia/Almaty') BETWEEN 1 AND 5)::numeric AS weekday_views,
        COUNT(*) FILTER (WHERE extract(hour FROM viewed_at AT TIME ZONE 'Asia/Almaty') BETWEEN 0 AND 5)::numeric AS night_views,
        COUNT(*) FILTER (WHERE extract(hour FROM viewed_at AT TIME ZONE 'Asia/Almaty') BETWEEN 11 AND 14)::numeric AS lunch_views,
        COUNT(*) FILTER (WHERE extract(hour FROM viewed_at AT TIME ZONE 'Asia/Almaty') BETWEEN 18 AND 23)::numeric AS evening_views,
        COUNT(*) FILTER (WHERE extract(month FROM viewed_at AT TIME ZONE 'Asia/Almaty') IN (1,12))::numeric AS winter_views,
        count(*)::numeric AS total_views
 FROM food_delivery.dish_view
)
SELECT round(100*weekend_views/total_views,1) AS weekend_pct,
       round((weekend_views/104.0) / (weekday_views/261.0),2) AS weekend_per_day_vs_weekday,
       round(100*night_views/total_views,1) AS night_pct,
       round(100*lunch_views/total_views,1) AS lunch_pct,
       round(100*evening_views/total_views,1) AS evening_pct,
       round(100*winter_views/total_views,1) AS jan_dec_pct
FROM daily;

SELECT source, count(*) AS views FROM food_delivery.dish_view GROUP BY source ORDER BY source;

-- Save this checksum, rerun 04_fact.sql, check again: it must be the same.
SELECT md5(string_agg(view_id::text || ':' || dish_id::text || ':' ||
    extract(epoch FROM viewed_at)::bigint::text || ':' || source, '|'
    ORDER BY view_id)) AS first_1000_md5
FROM (SELECT view_id,dish_id,viewed_at,source
      FROM food_delivery.dish_view ORDER BY view_id LIMIT 1000) x;

SELECT pg_database_size(current_database()) AS bytes,
       round(pg_database_size(current_database()) / 1024.0 / 1024.0, 2) AS size_mb,
       pg_size_pretty(pg_database_size(current_database())) AS human_size;

\echo === Verification finished: copy actual values to reports/week04.md ===
