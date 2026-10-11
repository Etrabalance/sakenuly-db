-- СРС, неделя 5. SELECT: выборка, выражения, дата и время.
-- Проект: доставка еды, PostgreSQL 18.6.
-- Основано на состоянии базы после недели 4 (включая 300000 dish_view).
-- Десять основных запросов ниже читают по ОДНОЙ таблице каждый.
-- Изменения в данных не производятся (только SELECT и настройка сессии).
\set ON_ERROR_STOP on
\pset pager off
\timing on
SET TIME ZONE 'Asia/Almaty';

\echo === 01. Available dishes in a price range ===
-- 1. Вопрос владельца: какие доступные блюда стоят от 1500 до 3500 тенге,
--    и какие из них дешевле остальных?
SELECT dish_id, name, price, restaurant_id
FROM food_delivery.dish
WHERE is_available = true
  AND price BETWEEN 1500 AND 3500
ORDER BY price ASC, dish_id ASC
LIMIT 20;

\echo === 02. Highly rated restaurants ===
-- 2. Вопрос владельца: какие рестораны имеют рейтинг не ниже 4.5,
--    чтобы рекомендовать их клиентам?
SELECT restaurant_id, name, rating, address
FROM food_delivery.restaurant
WHERE rating >= 4.5
ORDER BY rating DESC, name ASC, restaurant_id ASC
LIMIT 20;

\echo === 03. COALESCE for missing payment time ===
-- 3. Вопрос владельца: как показать время оплаты в админ-панели,
--    не выводя пустое значение, если платеж ещё не оплачен?
--    Записи с NULL показываем первыми, чтобы было видно действие COALESCE.
SELECT payment_id, payment_status, amount,
       COALESCE(
          to_char(paid_at AT TIME ZONE 'Asia/Almaty', 'YYYY-MM-DD HH24:MI'),
          'Время оплаты не указано'
       ) AS payment_time
FROM food_delivery.payment
ORDER BY (paid_at IS NULL) DESC, payment_id ASC
LIMIT 15;

\echo === 04. Views during January 2027 (period) ===
-- 4. Вопрос владельца: сколько просмотров блюд было в январе 2027 года
--    через приложение, веб-сайт и партнёров?
--    ВАЖНО: просмотры синтетические, сгенерированы в задании недели 4.
SELECT source, count(*) AS views_in_january
FROM food_delivery.dish_view
WHERE viewed_at >= TIMESTAMPTZ '2027-01-01 00:00:00+05'
  AND viewed_at <  TIMESTAMPTZ '2027-02-01 00:00:00+05'
GROUP BY source
ORDER BY views_in_january DESC, source ASC;

\echo === 05. Daily views using date_trunc ===
-- 5. Вопрос владельца: как менялось количество просмотров блюд
--    по дням за первую неделю января 2027 года (время Алматы)?
SELECT date_trunc('day', viewed_at AT TIME ZONE 'Asia/Almaty')::date AS local_day,
       count(*) AS views_per_day
FROM food_delivery.dish_view
WHERE viewed_at >= TIMESTAMPTZ '2027-01-01 00:00:00+05'
  AND viewed_at <  TIMESTAMPTZ '2027-01-08 00:00:00+05'
GROUP BY date_trunc('day', viewed_at AT TIME ZONE 'Asia/Almaty')::date
ORDER BY local_day ASC;

\echo === 06. Delivery duration (timestamptz difference) ===
-- 6. Вопрос владельца: какие заказы курьеры доставляли дольше всего,
--    если считать от получения заказа до вручения клиенту?
SELECT delivery_id, order_id, picked_up_at, delivered_at,
       round((extract(epoch FROM (delivered_at - picked_up_at)) / 60.0)::numeric, 1)
         AS delivery_minutes
FROM food_delivery.delivery
WHERE picked_up_at IS NOT NULL
  AND delivered_at IS NOT NULL
ORDER BY delivery_minutes DESC, delivery_id ASC
LIMIT 15;

\echo === 07. CASE for readable order status ===
-- 7. Вопрос владельца: как показать статус заказа на русском языке
--    вместо технического значения ENUM?
SELECT order_id, status,
       CASE status
          WHEN 'new' THEN 'Новый'
          WHEN 'preparing' THEN 'Готовится'
          WHEN 'on_the_way' THEN 'В пути'
          WHEN 'delivered' THEN 'Доставлен'
          WHEN 'cancelled' THEN 'Отменён'
          ELSE 'Неизвестно'
       END AS status_ru,
       total_amount
FROM food_delivery.orders
ORDER BY order_id ASC
LIMIT 20;

\echo === 08. Second page of menu (LIMIT / OFFSET) ===
-- 8. Вопрос владельца: какие блюда вывести на второй странице каталога,
--    если на каждой странице по 10 блюд?
SELECT dish_id, name, price, is_available
FROM food_delivery.dish
ORDER BY dish_id ASC
LIMIT 10 OFFSET 10;

\echo === 09. Missing delivery timestamps ===
-- 9. Вопрос владельца: у скольких доставок пока не заполнено время вручения?
--    IS NULL корректно находит отсутствие значения.
SELECT count(*) AS deliveries_without_delivery_time
FROM food_delivery.delivery
WHERE delivered_at IS NULL;

\echo === 10. Customers with mail.kz email ===
-- 10. Вопрос владельца: какие клиенты указали почту в домене mail.kz,
--     чтобы проверить контактные данные учебных пользователей?
SELECT customer_id, full_name, email
FROM food_delivery.customer
WHERE email ILIKE '%@mail.kz'
ORDER BY customer_id ASC
LIMIT 15;

\echo === Extra demonstration: WRONG NULL comparison (not one of the ten tasks) ===
-- ДОПОЛНИТЕЛЬНАЯ ДЕМОНСТРАЦИЯ ЛОВУШКИ NULL.
-- Намеренно неверно: = NULL не даёт TRUE даже для строки с NULL;
-- запрос синтаксически корректен, но ошибочен по смыслу.
SELECT count(*) AS wrong_equal_null_found
FROM food_delivery.delivery
WHERE delivered_at = NULL;
-- Исправление представлено основным запросом № 9 (IS NULL).

\echo === WEEK 05 finished: ten correct SELECTs and one NULL-trap demo ===
