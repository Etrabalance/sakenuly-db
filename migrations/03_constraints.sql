-- СРС, неделя 3: ограничения целостности базы «Доставка еды».
-- Запускать ПОСЛЕ migrations/02_schema.sql; использует существующие данные.
-- PostgreSQL 18. Файл в кодировке UTF-8. Перед запуском сохранить pg_dump.
-- Все изменения выполняются в одной транзакции: при ошибке они откатываются.
BEGIN;

-- 1. ENUM: статус заказа, значения ограничены жизненным циклом заказа.
DO $enum$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_type AS t
        JOIN pg_namespace AS n ON n.oid = t.typnamespace
        WHERE n.nspname = 'food_delivery' AND t.typname = 'order_status'
    ) THEN
        CREATE TYPE food_delivery.order_status AS ENUM
            ('new', 'preparing', 'on_the_way', 'delivered', 'cancelled');
    END IF;
END
$enum$;

-- Прежний CHECK был рассчитан на TEXT. Перед приведением к ENUM снимаем его.
ALTER TABLE food_delivery.orders
    DROP CONSTRAINT IF EXISTS orders_status_check;
ALTER TABLE food_delivery.orders
    ALTER COLUMN status TYPE food_delivery.order_status
    USING status::text::food_delivery.order_status;
COMMENT ON COLUMN food_delivery.orders.status IS 'Статус заказа; ENUM food_delivery.order_status (неделя 3)';

-- 2. Внешние ключи с осознанным ON DELETE и ON UPDATE RESTRICT.
-- Ограничения уже были созданы в предыдущих неделях, поэтому заменяем их
-- одноимёнными ограничениями с явно выбранной политикой удаления.
-- dish.restaurant_id -> restaurant.restaurant_id: ON DELETE RESTRICT.
-- Обоснование: Блюдо нельзя оставить без ресторана; удаление ресторана с меню запрещено.
ALTER TABLE food_delivery.dish
    DROP CONSTRAINT IF EXISTS dish_restaurant_id_fkey;
ALTER TABLE food_delivery.dish
    ADD CONSTRAINT dish_restaurant_id_fkey
    FOREIGN KEY (restaurant_id) REFERENCES food_delivery.restaurant (restaurant_id)
    ON DELETE RESTRICT ON UPDATE RESTRICT;

-- orders.customer_id -> customer.customer_id: ON DELETE RESTRICT.
-- Обоснование: История заказов должна сохранять ссылку на клиента.
ALTER TABLE food_delivery.orders
    DROP CONSTRAINT IF EXISTS orders_customer_id_fkey;
ALTER TABLE food_delivery.orders
    ADD CONSTRAINT orders_customer_id_fkey
    FOREIGN KEY (customer_id) REFERENCES food_delivery.customer (customer_id)
    ON DELETE RESTRICT ON UPDATE RESTRICT;

-- orders.restaurant_id -> restaurant.restaurant_id: ON DELETE RESTRICT.
-- Обоснование: Ресторан с заказами не удаляется из истории продаж.
ALTER TABLE food_delivery.orders
    DROP CONSTRAINT IF EXISTS orders_restaurant_id_fkey;
ALTER TABLE food_delivery.orders
    ADD CONSTRAINT orders_restaurant_id_fkey
    FOREIGN KEY (restaurant_id) REFERENCES food_delivery.restaurant (restaurant_id)
    ON DELETE RESTRICT ON UPDATE RESTRICT;

-- dish_category.dish_id -> dish.dish_id: ON DELETE CASCADE.
-- Обоснование: При удалении блюда удаляются лишь строки присвоения ему категорий.
ALTER TABLE food_delivery.dish_category
    DROP CONSTRAINT IF EXISTS dish_category_dish_id_fkey;
ALTER TABLE food_delivery.dish_category
    ADD CONSTRAINT dish_category_dish_id_fkey
    FOREIGN KEY (dish_id) REFERENCES food_delivery.dish (dish_id)
    ON DELETE CASCADE ON UPDATE RESTRICT;

-- dish_category.category_id -> category.category_id: ON DELETE CASCADE.
-- Обоснование: При удалении категории удаляются связи, но не блюда.
ALTER TABLE food_delivery.dish_category
    DROP CONSTRAINT IF EXISTS dish_category_category_id_fkey;
ALTER TABLE food_delivery.dish_category
    ADD CONSTRAINT dish_category_category_id_fkey
    FOREIGN KEY (category_id) REFERENCES food_delivery.category (category_id)
    ON DELETE CASCADE ON UPDATE RESTRICT;

-- order_item.order_id -> orders.order_id: ON DELETE CASCADE.
-- Обоснование: Позиции составляют часть заказа; сами по себе без заказа не существуют.
ALTER TABLE food_delivery.order_item
    DROP CONSTRAINT IF EXISTS order_item_order_id_fkey;
ALTER TABLE food_delivery.order_item
    ADD CONSTRAINT order_item_order_id_fkey
    FOREIGN KEY (order_id) REFERENCES food_delivery.orders (order_id)
    ON DELETE CASCADE ON UPDATE RESTRICT;

-- order_item.dish_id -> dish.dish_id: ON DELETE RESTRICT.
-- Обоснование: Блюдо, участвовавшее в заказе, нельзя бесследно удалить из меню.
ALTER TABLE food_delivery.order_item
    DROP CONSTRAINT IF EXISTS order_item_dish_id_fkey;
ALTER TABLE food_delivery.order_item
    ADD CONSTRAINT order_item_dish_id_fkey
    FOREIGN KEY (dish_id) REFERENCES food_delivery.dish (dish_id)
    ON DELETE RESTRICT ON UPDATE RESTRICT;

-- payment.order_id -> orders.order_id: ON DELETE RESTRICT.
-- Обоснование: Нельзя удалить заказ, к которому относится платёжная запись.
ALTER TABLE food_delivery.payment
    DROP CONSTRAINT IF EXISTS payment_order_id_fkey;
ALTER TABLE food_delivery.payment
    ADD CONSTRAINT payment_order_id_fkey
    FOREIGN KEY (order_id) REFERENCES food_delivery.orders (order_id)
    ON DELETE RESTRICT ON UPDATE RESTRICT;

-- delivery.order_id -> orders.order_id: ON DELETE RESTRICT.
-- Обоснование: История доставки не должна исчезать при удалении заказа.
ALTER TABLE food_delivery.delivery
    DROP CONSTRAINT IF EXISTS delivery_order_id_fkey;
ALTER TABLE food_delivery.delivery
    ADD CONSTRAINT delivery_order_id_fkey
    FOREIGN KEY (order_id) REFERENCES food_delivery.orders (order_id)
    ON DELETE RESTRICT ON UPDATE RESTRICT;

-- delivery.courier_id -> courier.courier_id: ON DELETE RESTRICT.
-- Обоснование: Курьер, имеющий историю доставок, не удаляется.
ALTER TABLE food_delivery.delivery
    DROP CONSTRAINT IF EXISTS delivery_courier_id_fkey;
ALTER TABLE food_delivery.delivery
    ADD CONSTRAINT delivery_courier_id_fkey
    FOREIGN KEY (courier_id) REFERENCES food_delivery.courier (courier_id)
    ON DELETE RESTRICT ON UPDATE RESTRICT;

-- review.order_id -> orders.order_id: ON DELETE RESTRICT.
-- Обоснование: Отзывы по заказам сохраняются, удаление заказа ограничено.
ALTER TABLE food_delivery.review
    DROP CONSTRAINT IF EXISTS review_order_id_fkey;
ALTER TABLE food_delivery.review
    ADD CONSTRAINT review_order_id_fkey
    FOREIGN KEY (order_id) REFERENCES food_delivery.orders (order_id)
    ON DELETE RESTRICT ON UPDATE RESTRICT;

-- 3. Две новые уникальности (обе составные, выше требования «одна составная»).
-- Внутри одного ресторана нельзя создать два блюда с одинаковым названием.
ALTER TABLE food_delivery.dish
    DROP CONSTRAINT IF EXISTS dish_restaurant_name_uq;
ALTER TABLE food_delivery.dish
    ADD CONSTRAINT dish_restaurant_name_uq UNIQUE (restaurant_id, name);

-- Одинаковая пара «название ресторана + адрес» не может дублироваться.
ALTER TABLE food_delivery.restaurant
    DROP CONSTRAINT IF EXISTS restaurant_name_address_uq;
ALTER TABLE food_delivery.restaurant
    ADD CONSTRAINT restaurant_name_address_uq UNIQUE (name, address);

-- 4. CHECK — проверки содержательных бизнес-правил.
-- Повторное применение возможно: одноимённые CHECK удаляются и пересоздаются.
-- restaurant_name_meaningful_ck: Название ресторана должно содержать минимум 3 непробельных символа.
ALTER TABLE food_delivery.restaurant
    DROP CONSTRAINT IF EXISTS restaurant_name_meaningful_ck;
ALTER TABLE food_delivery.restaurant
    ADD CONSTRAINT restaurant_name_meaningful_ck CHECK (char_length(btrim(name)) >= 3);

-- restaurant_address_meaningful_ck: Адрес ресторана должен быть информативным, не менее 10 символов.
ALTER TABLE food_delivery.restaurant
    DROP CONSTRAINT IF EXISTS restaurant_address_meaningful_ck;
ALTER TABLE food_delivery.restaurant
    ADD CONSTRAINT restaurant_address_meaningful_ck CHECK (char_length(btrim(address)) >= 10);

-- customer_full_name_meaningful_ck: Клиент указывает имя, а не пробел или одиночный символ.
ALTER TABLE food_delivery.customer
    DROP CONSTRAINT IF EXISTS customer_full_name_meaningful_ck;
ALTER TABLE food_delivery.customer
    ADD CONSTRAINT customer_full_name_meaningful_ck CHECK (char_length(btrim(full_name)) >= 3);

-- dish_name_meaningful_ck: Название блюда не должно быть пустым или бессмысленно коротким.
ALTER TABLE food_delivery.dish
    DROP CONSTRAINT IF EXISTS dish_name_meaningful_ck;
ALTER TABLE food_delivery.dish
    ADD CONSTRAINT dish_name_meaningful_ck CHECK (char_length(btrim(name)) >= 3);

-- dish_description_meaningful_ck: Если описание блюда заполнено, оно должно содержать не менее 10 символов.
ALTER TABLE food_delivery.dish
    DROP CONSTRAINT IF EXISTS dish_description_meaningful_ck;
ALTER TABLE food_delivery.dish
    ADD CONSTRAINT dish_description_meaningful_ck CHECK (description IS NULL OR char_length(btrim(description)) >= 10);

-- orders_total_covers_delivery_ck: Итоговая сумма заказа не может быть ниже платы за доставку.
ALTER TABLE food_delivery.orders
    DROP CONSTRAINT IF EXISTS orders_total_covers_delivery_ck;
ALTER TABLE food_delivery.orders
    ADD CONSTRAINT orders_total_covers_delivery_ck CHECK (total_amount >= delivery_fee);

-- orders_comment_meaningful_ck: Комментарий к заказу либо не указан, либо содержит содержательный текст.
ALTER TABLE food_delivery.orders
    DROP CONSTRAINT IF EXISTS orders_comment_meaningful_ck;
ALTER TABLE food_delivery.orders
    ADD CONSTRAINT orders_comment_meaningful_ck CHECK (comment IS NULL OR char_length(btrim(comment)) >= 4);

-- payment_paid_requires_timestamp_ck: Оплаченный/возвращённый платёж обязательно имеет время платежа.
ALTER TABLE food_delivery.payment
    DROP CONSTRAINT IF EXISTS payment_paid_requires_timestamp_ck;
ALTER TABLE food_delivery.payment
    ADD CONSTRAINT payment_paid_requires_timestamp_ck CHECK (payment_status NOT IN ('paid', 'refunded') OR paid_at IS NOT NULL);

-- payment_unpaid_no_timestamp_ck: Неоплаченный/неуспешный платёж не должен иметь времени успешной оплаты.
ALTER TABLE food_delivery.payment
    DROP CONSTRAINT IF EXISTS payment_unpaid_no_timestamp_ck;
ALTER TABLE food_delivery.payment
    ADD CONSTRAINT payment_unpaid_no_timestamp_ck CHECK (payment_status NOT IN ('pending', 'failed') OR paid_at IS NULL);

-- payment_timestamp_after_creation_ck: Оплата не может быть зафиксирована раньше создания платёжной записи.
ALTER TABLE food_delivery.payment
    DROP CONSTRAINT IF EXISTS payment_timestamp_after_creation_ck;
ALTER TABLE food_delivery.payment
    ADD CONSTRAINT payment_timestamp_after_creation_ck CHECK (paid_at IS NULL OR paid_at >= created_at);

-- delivery_delivered_requires_times_ck: Статус delivered допустим только при известных времени получения и вручения.
ALTER TABLE food_delivery.delivery
    DROP CONSTRAINT IF EXISTS delivery_delivered_requires_times_ck;
ALTER TABLE food_delivery.delivery
    ADD CONSTRAINT delivery_delivered_requires_times_ck CHECK (status <> 'delivered' OR (picked_up_at IS NOT NULL AND delivered_at IS NOT NULL));

-- delivery_arrival_after_pickup_ck: Время вручения заказа должно быть позже времени получения курьером.
ALTER TABLE food_delivery.delivery
    DROP CONSTRAINT IF EXISTS delivery_arrival_after_pickup_ck;
ALTER TABLE food_delivery.delivery
    ADD CONSTRAINT delivery_arrival_after_pickup_ck CHECK (delivered_at IS NULL OR (picked_up_at IS NOT NULL AND delivered_at > picked_up_at));

-- delivery_pickup_after_creation_ck: Курьер не может забрать заказ раньше создания записи доставки.
ALTER TABLE food_delivery.delivery
    DROP CONSTRAINT IF EXISTS delivery_pickup_after_creation_ck;
ALTER TABLE food_delivery.delivery
    ADD CONSTRAINT delivery_pickup_after_creation_ck CHECK (picked_up_at IS NULL OR picked_up_at >= created_at);

-- delivery_cancelled_without_arrival_ck: У отменённой доставки не должно быть времени вручения.
ALTER TABLE food_delivery.delivery
    DROP CONSTRAINT IF EXISTS delivery_cancelled_without_arrival_ck;
ALTER TABLE food_delivery.delivery
    ADD CONSTRAINT delivery_cancelled_without_arrival_ck CHECK (status <> 'cancelled' OR delivered_at IS NULL);

-- review_comment_meaningful_ck: Текст отзыва после удаления пробелов должен содержать хотя бы 5 символов.
ALTER TABLE food_delivery.review
    DROP CONSTRAINT IF EXISTS review_comment_meaningful_ck;
ALTER TABLE food_delivery.review
    ADD CONSTRAINT review_comment_meaningful_ck CHECK (char_length(btrim(comment)) >= 5);

-- Итого: 11 внешних ключей, 15 содержательных CHECK, 2 новых UNIQUE, 1 ENUM.
COMMIT;
