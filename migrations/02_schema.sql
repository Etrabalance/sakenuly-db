-- SRS, Week 02: Food delivery ER-model and 3NF.
-- Compatible with existing Week 01 schema: it does NOT delete tables or rows.
-- Existing project: run AFTER migrations/01_init.sql and migrations/02_seed.sql.
-- Clean database: this file can create all 11 tables from scratch (without test data).
-- Do not run the Week 01 seed after applying this file: the seed contains
-- legacy review.customer_id and review.restaurant_id columns.

BEGIN;
CREATE SCHEMA IF NOT EXISTS food_delivery;

-- Independent entities
CREATE TABLE IF NOT EXISTS food_delivery.restaurant (
    restaurant_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name TEXT NOT NULL,
    address TEXT NOT NULL,
    phone TEXT,
    rating NUMERIC(2,1) CHECK (rating BETWEEN 0 AND 5),
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS food_delivery.customer (
    customer_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    full_name TEXT NOT NULL,
    phone TEXT NOT NULL UNIQUE,
    email TEXT UNIQUE,
    address TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS food_delivery.courier (
    courier_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    full_name TEXT NOT NULL,
    phone TEXT NOT NULL UNIQUE,
    transport_type TEXT NOT NULL CHECK (transport_type IN ('car', 'motorcycle', 'bicycle', 'scooter', 'walking')),
    rating NUMERIC(2,1) CHECK (rating BETWEEN 0 AND 5),
    hire_date DATE NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS food_delivery.category (
    category_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name TEXT NOT NULL UNIQUE,
    description TEXT
);

-- Main business entities
CREATE TABLE IF NOT EXISTS food_delivery.dish (
    dish_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    restaurant_id BIGINT NOT NULL REFERENCES food_delivery.restaurant(restaurant_id),
    name TEXT NOT NULL,
    description TEXT,
    price NUMERIC(10,2) NOT NULL CHECK (price > 0),
    is_available BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS food_delivery.orders (
    order_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    customer_id BIGINT NOT NULL REFERENCES food_delivery.customer(customer_id),
    restaurant_id BIGINT NOT NULL REFERENCES food_delivery.restaurant(restaurant_id),
    status TEXT NOT NULL CHECK (status IN ('new', 'preparing', 'on_the_way', 'delivered', 'cancelled')),
    delivery_fee NUMERIC(8,2) NOT NULL DEFAULT 500 CHECK (delivery_fee >= 0),
    total_amount NUMERIC(10,2) NOT NULL DEFAULT 0 CHECK (total_amount >= 0),
    comment TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- M:N relation 1: dish <-> category, with an attribute of the association.
CREATE TABLE IF NOT EXISTS food_delivery.dish_category (
    dish_id BIGINT NOT NULL REFERENCES food_delivery.dish(dish_id) ON DELETE CASCADE,
    category_id BIGINT NOT NULL REFERENCES food_delivery.category(category_id) ON DELETE CASCADE,
    is_primary BOOLEAN NOT NULL DEFAULT FALSE,
    PRIMARY KEY (dish_id, category_id)
);

-- M:N relation 2 and future fact table (300,000 rows at Week 04).
CREATE TABLE IF NOT EXISTS food_delivery.order_item (
    order_item_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    order_id BIGINT NOT NULL REFERENCES food_delivery.orders(order_id) ON DELETE CASCADE,
    dish_id BIGINT NOT NULL REFERENCES food_delivery.dish(dish_id),
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    unit_price NUMERIC(10,2) NOT NULL CHECK (unit_price > 0),
    CONSTRAINT order_item_order_id_dish_id_key UNIQUE (order_id, dish_id)
);

CREATE TABLE IF NOT EXISTS food_delivery.payment (
    payment_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    order_id BIGINT NOT NULL UNIQUE REFERENCES food_delivery.orders(order_id),
    payment_method TEXT NOT NULL CHECK (payment_method IN ('cash', 'card', 'kaspi')),
    payment_status TEXT NOT NULL CHECK (payment_status IN ('pending', 'paid', 'refunded', 'failed')),
    amount NUMERIC(10,2) NOT NULL CHECK (amount >= 0),
    paid_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS food_delivery.delivery (
    delivery_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    order_id BIGINT NOT NULL UNIQUE REFERENCES food_delivery.orders(order_id),
    courier_id BIGINT NOT NULL REFERENCES food_delivery.courier(courier_id),
    delivery_address TEXT NOT NULL,
    status TEXT NOT NULL CHECK (status IN ('waiting', 'on_the_way', 'delivered', 'cancelled')),
    picked_up_at TIMESTAMPTZ,
    delivered_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS food_delivery.review (
    review_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    order_id BIGINT NOT NULL UNIQUE REFERENCES food_delivery.orders(order_id),
    rating SMALLINT NOT NULL CHECK (rating BETWEEN 1 AND 5),
    comment TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Upgrade the existing Week 01 schema safely.
-- Previous dish_category contained only foreign keys.
ALTER TABLE food_delivery.dish_category
    ADD COLUMN IF NOT EXISTS is_primary BOOLEAN NOT NULL DEFAULT FALSE;

-- Old review repeated customer_id and restaurant_id, although both already
-- follow from orders.order_id. Verify copies BEFORE removing them.
DO $migration_check$
BEGIN
    IF EXISTS (
        SELECT 1 FROM information_schema.columns
        WHERE table_schema = 'food_delivery' AND table_name = 'review'
          AND column_name = 'customer_id'
    ) AND EXISTS (
        SELECT 1 FROM information_schema.columns
        WHERE table_schema = 'food_delivery' AND table_name = 'review'
          AND column_name = 'restaurant_id'
    ) THEN
        IF EXISTS (
            SELECT 1 FROM food_delivery.review AS r
            JOIN food_delivery.orders AS o ON o.order_id = r.order_id
            WHERE r.customer_id IS DISTINCT FROM o.customer_id
               OR r.restaurant_id IS DISTINCT FROM o.restaurant_id
        ) THEN
            RAISE EXCEPTION 'Review duplicates differ from orders. No changes made.';
        END IF;
    END IF;
END
$migration_check$;

-- Drops redundant columns, not reviews; previous keys remain reachable via orders.
ALTER TABLE food_delivery.review
    DROP COLUMN IF EXISTS customer_id,
    DROP COLUMN IF EXISTS restaurant_id;

-- Every table and every column is documented inside PostgreSQL.
COMMENT ON SCHEMA food_delivery IS 'Учебная база данных сервиса доставки еды, неделя 2';
COMMENT ON TABLE food_delivery.restaurant IS 'Рестораны, принимающие заказы';
COMMENT ON COLUMN food_delivery.restaurant.restaurant_id IS 'Уникальный ID ресторана, первичный ключ';
COMMENT ON COLUMN food_delivery.restaurant.name IS 'Название ресторана';
COMMENT ON COLUMN food_delivery.restaurant.address IS 'Физический адрес ресторана';
COMMENT ON COLUMN food_delivery.restaurant.phone IS 'Контактный телефон ресторана';
COMMENT ON COLUMN food_delivery.restaurant.rating IS 'Рейтинг ресторана по шкале от 0 до 5';
COMMENT ON COLUMN food_delivery.restaurant.created_at IS 'Дата и время создания записи';

COMMENT ON TABLE food_delivery.customer IS 'Клиенты сервиса доставки';
COMMENT ON COLUMN food_delivery.customer.customer_id IS 'Уникальный ID клиента, первичный ключ';
COMMENT ON COLUMN food_delivery.customer.full_name IS 'Имя клиента';
COMMENT ON COLUMN food_delivery.customer.phone IS 'Уникальный телефон клиента';
COMMENT ON COLUMN food_delivery.customer.email IS 'Электронная почта клиента, если указана';
COMMENT ON COLUMN food_delivery.customer.address IS 'Основной адрес клиента, может меняться';
COMMENT ON COLUMN food_delivery.customer.created_at IS 'Дата регистрации клиента';

COMMENT ON TABLE food_delivery.courier IS 'Курьеры и используемый ими транспорт';
COMMENT ON COLUMN food_delivery.courier.courier_id IS 'Уникальный ID курьера, первичный ключ';
COMMENT ON COLUMN food_delivery.courier.full_name IS 'ФИО курьера';
COMMENT ON COLUMN food_delivery.courier.phone IS 'Уникальный номер телефона курьера';
COMMENT ON COLUMN food_delivery.courier.transport_type IS 'Тип транспорта: автомобиль, мотоцикл, велосипед, самокат, пешком';
COMMENT ON COLUMN food_delivery.courier.rating IS 'Рейтинг курьера от 0 до 5';
COMMENT ON COLUMN food_delivery.courier.hire_date IS 'Дата начала работы';
COMMENT ON COLUMN food_delivery.courier.created_at IS 'Дата добавления записи';

COMMENT ON TABLE food_delivery.category IS 'Справочник категорий блюд';
COMMENT ON COLUMN food_delivery.category.category_id IS 'ID категории, первичный ключ';
COMMENT ON COLUMN food_delivery.category.name IS 'Уникальное название категории';
COMMENT ON COLUMN food_delivery.category.description IS 'Описание категории';

COMMENT ON TABLE food_delivery.dish IS 'Блюда из меню ресторанов';
COMMENT ON COLUMN food_delivery.dish.dish_id IS 'ID блюда, первичный ключ';
COMMENT ON COLUMN food_delivery.dish.restaurant_id IS 'Ресторан, предлагающий блюдо; внешний ключ';
COMMENT ON COLUMN food_delivery.dish.name IS 'Название блюда';
COMMENT ON COLUMN food_delivery.dish.description IS 'Состав или описание блюда';
COMMENT ON COLUMN food_delivery.dish.price IS 'Текущая цена блюда; историческая цена сохраняется в order_item';
COMMENT ON COLUMN food_delivery.dish.is_available IS 'Доступно ли блюдо для заказа';
COMMENT ON COLUMN food_delivery.dish.created_at IS 'Дата добавления блюда в меню';

COMMENT ON TABLE food_delivery.orders IS 'Заказы клиентов у ресторанов';
COMMENT ON COLUMN food_delivery.orders.order_id IS 'ID заказа, первичный ключ';
COMMENT ON COLUMN food_delivery.orders.customer_id IS 'Клиент, оформивший заказ; внешний ключ';
COMMENT ON COLUMN food_delivery.orders.restaurant_id IS 'Ресторан, выполняющий заказ; внешний ключ';
COMMENT ON COLUMN food_delivery.orders.status IS 'Состояние заказа';
COMMENT ON COLUMN food_delivery.orders.delivery_fee IS 'Стоимость доставки в тенге';
COMMENT ON COLUMN food_delivery.orders.total_amount IS 'Сохранённая итоговая сумма; должна пересчитываться при изменении состава заказа';
COMMENT ON COLUMN food_delivery.orders.comment IS 'Комментарий покупателя к заказу';
COMMENT ON COLUMN food_delivery.orders.created_at IS 'Время оформления заказа';

COMMENT ON TABLE food_delivery.dish_category IS 'Связь многие-ко-многим между блюдами и категориями';
COMMENT ON COLUMN food_delivery.dish_category.dish_id IS 'Блюдо в паре, часть составного первичного ключа';
COMMENT ON COLUMN food_delivery.dish_category.category_id IS 'Категория в паре, часть составного первичного ключа';
COMMENT ON COLUMN food_delivery.dish_category.is_primary IS 'Собственный атрибут связи: основная ли это категория для данного блюда';

COMMENT ON TABLE food_delivery.order_item IS 'ФАКТ: позиции заказов; к неделе 4 планируется 300000 строк';
COMMENT ON COLUMN food_delivery.order_item.order_item_id IS 'ID позиции заказа, первичный ключ';
COMMENT ON COLUMN food_delivery.order_item.order_id IS 'Заказ, к которому относится позиция; внешний ключ';
COMMENT ON COLUMN food_delivery.order_item.dish_id IS 'Заказанное блюдо; внешний ключ';
COMMENT ON COLUMN food_delivery.order_item.quantity IS 'Количество единиц конкретного блюда в заказе';
COMMENT ON COLUMN food_delivery.order_item.unit_price IS 'Цена одной единицы на момент заказа, не текущая цена меню';

COMMENT ON TABLE food_delivery.payment IS 'Сведения об оплате заказа (до одной записи на заказ)';
COMMENT ON COLUMN food_delivery.payment.payment_id IS 'ID оплаты, первичный ключ';
COMMENT ON COLUMN food_delivery.payment.order_id IS 'Уникальная ссылка на заказ; внешний ключ';
COMMENT ON COLUMN food_delivery.payment.payment_method IS 'Способ оплаты: наличные, карта или Kaspi';
COMMENT ON COLUMN food_delivery.payment.payment_status IS 'Текущий статус платежа';
COMMENT ON COLUMN food_delivery.payment.amount IS 'Сумма проведённой или ожидаемой оплаты';
COMMENT ON COLUMN food_delivery.payment.paid_at IS 'Фактическое время оплаты, если оплачено';
COMMENT ON COLUMN food_delivery.payment.created_at IS 'Дата создания платежной записи';

COMMENT ON TABLE food_delivery.delivery IS 'Доставки заказов (до одной на заказ)';
COMMENT ON COLUMN food_delivery.delivery.delivery_id IS 'ID доставки, первичный ключ';
COMMENT ON COLUMN food_delivery.delivery.order_id IS 'Уникальная ссылка на заказ; внешний ключ';
COMMENT ON COLUMN food_delivery.delivery.courier_id IS 'Назначенный курьер; внешний ключ';
COMMENT ON COLUMN food_delivery.delivery.delivery_address IS 'Адрес доставки на момент оформления, сохраняется независимо от адреса в профиле';
COMMENT ON COLUMN food_delivery.delivery.status IS 'Состояние доставки';
COMMENT ON COLUMN food_delivery.delivery.picked_up_at IS 'Время передачи заказа курьеру';
COMMENT ON COLUMN food_delivery.delivery.delivered_at IS 'Время получения заказа клиентом';
COMMENT ON COLUMN food_delivery.delivery.created_at IS 'Дата создания записи доставки';

COMMENT ON TABLE food_delivery.review IS 'Отзывы к заказам; клиент и ресторан определяются через orders';
COMMENT ON COLUMN food_delivery.review.review_id IS 'ID отзыва, первичный ключ';
COMMENT ON COLUMN food_delivery.review.order_id IS 'Заказ, к которому оставлен отзыв; уникальный внешний ключ';
COMMENT ON COLUMN food_delivery.review.rating IS 'Оценка от 1 до 5';
COMMENT ON COLUMN food_delivery.review.comment IS 'Текст отзыва';
COMMENT ON COLUMN food_delivery.review.created_at IS 'Время публикации отзыва';

COMMIT;
