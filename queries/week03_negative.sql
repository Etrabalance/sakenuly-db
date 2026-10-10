-- СРС, неделя 3. Пять негативных проверок ограничений.
-- Запускать после 03_constraints.sql через psql, с ON_ERROR_STOP=0.
-- ВАЖНО: все изменения откатываются — основная база НЕ меняется.
-- Используются ID из учебного набора данных (orders 1, dish 1/2, delivery 1, review 1).
\set ON_ERROR_STOP off
\set VERBOSITY verbose
\echo ===== BEGIN NEGATIVE TESTS =====
BEGIN;

-- Тест 1. Несуществующий клиент в заказе.
-- Ожидаемый SQLSTATE 23503, ограничение orders_customer_id_fkey.
\echo [1/5] Expected 23503 orders_customer_id_fkey
SAVEPOINT neg1;
UPDATE food_delivery.orders SET customer_id = -999 WHERE order_id = 1;
ROLLBACK TO SAVEPOINT neg1;

-- Тест 2. В том же ресторане уже есть блюдо «Pepperoni» (dish_id=1).
-- Ожидаемый SQLSTATE 23505, ограничение dish_restaurant_name_uq.
\echo [2/5] Expected 23505 dish_restaurant_name_uq
SAVEPOINT neg2;
UPDATE food_delivery.dish SET name = 'Pepperoni' WHERE dish_id = 2;
ROLLBACK TO SAVEPOINT neg2;

-- Тест 3. Вручение раньше получения курьером.
-- Ожидаемый SQLSTATE 23514, ограничение delivery_arrival_after_pickup_ck.
\echo [3/5] Expected 23514 delivery_arrival_after_pickup_ck
SAVEPOINT neg3;
UPDATE food_delivery.delivery
   SET delivered_at = picked_up_at - INTERVAL '1 minute'
 WHERE delivery_id = 1;
ROLLBACK TO SAVEPOINT neg3;

-- Тест 4. Отзыв состоит только из пробелов.
-- Ожидаемый SQLSTATE 23514, ограничение review_comment_meaningful_ck.
\echo [4/5] Expected 23514 review_comment_meaningful_ck
SAVEPOINT neg4;
UPDATE food_delivery.review SET comment = '  ' WHERE review_id = 1;
ROLLBACK TO SAVEPOINT neg4;

-- Тест 5. Статуса flying нет в ENUM food_delivery.order_status.
-- Ожидаемый SQLSTATE 22P02, неверное значение ENUM order_status.
\echo [5/5] Expected 22P02 food_delivery.order_status
SAVEPOINT neg5;
UPDATE food_delivery.orders SET status = 'flying' WHERE order_id = 1;
ROLLBACK TO SAVEPOINT neg5;

-- Завершаем тест без сохранения каких-либо изменений.
ROLLBACK;
\echo ===== END NEGATIVE TESTS =====
