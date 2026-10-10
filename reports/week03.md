# СРС — Неделя 3. Ограничения целостности

**Тема проекта:** Доставка еды (`food_delivery`)  
**Выполнил:** Сакенулы Данияр  
**Группа:** 24.249 РО  
**СУБД:** PostgreSQL 18

## 1. Цель работы

На третьей неделе я продолжил свой проект базы доставки еды. Задача — перенести важные бизнес-правила непосредственно в PostgreSQL: чтобы нельзя было создать заказ несуществующего клиента, задать противоречивое время доставки, дублировать блюдо в одном ресторане или записать неизвестный статус заказа.

Работа продолжает таблицы из недель 1–2. В действующей модели 11 таблиц. Миграция `migrations/03_constraints.sql` **не создаёт заново данные и не удаляет существующие записи**. Она выполняет изменения структуры одной транзакцией `BEGIN ... COMMIT`.

## 2. Внешние ключи и выбор ON DELETE

В схеме уже были внешние ключи, созданные ранее. Я заменил их одноимёнными ключами, у которых явно задано поведение при удалении родительских строк.

| Связь (дочерняя → родительская) | ON DELETE | Почему |
|---|---|---|
| `dish.restaurant_id` → `restaurant` | `RESTRICT` | Блюдо нельзя оставить без ресторана; удаление ресторана с меню запрещено. |
| `orders.customer_id` → `customer` | `RESTRICT` | История заказов должна сохранять ссылку на клиента. |
| `orders.restaurant_id` → `restaurant` | `RESTRICT` | Ресторан с заказами не удаляется из истории продаж. |
| `dish_category.dish_id` → `dish` | `CASCADE` | При удалении блюда удаляются лишь строки присвоения ему категорий. |
| `dish_category.category_id` → `category` | `CASCADE` | При удалении категории удаляются связи, но не блюда. |
| `order_item.order_id` → `orders` | `CASCADE` | Позиции составляют часть заказа; сами по себе без заказа не существуют. |
| `order_item.dish_id` → `dish` | `RESTRICT` | Блюдо, участвовавшее в заказе, нельзя бесследно удалить из меню. |
| `payment.order_id` → `orders` | `RESTRICT` | Нельзя удалить заказ, к которому относится платёжная запись. |
| `delivery.order_id` → `orders` | `RESTRICT` | История доставки не должна исчезать при удалении заказа. |
| `delivery.courier_id` → `courier` | `RESTRICT` | Курьер, имеющий историю доставок, не удаляется. |
| `review.order_id` → `orders` | `RESTRICT` | Отзывы по заказам сохраняются, удаление заказа ограничено. |

**Три основных обоснования для защиты:**

1. `orders.customer_id → customer.customer_id`: **RESTRICT**. Нельзя удалить клиента с заказами, иначе потеряется связь с историей покупок.
2. `dish_category.dish_id → dish.dish_id`: **CASCADE**. Связь блюда с категорией — вспомогательная запись; при удалении самого блюда она больше не имеет смысла.
3. `payment.order_id → orders.order_id`: **RESTRICT**. Удаление заказа не должно автоматически уничтожать сведения об оплате.

Для всех связей дополнительно указано `ON UPDATE RESTRICT`: числовые первичные ключи (`..._id`) не следует изменять при существующих зависимых строках.

## 3. Содержательные CHECK-ограничения

Требовалось минимум шесть правил предметной области, не сводящихся к простой проверке `> 0`. Я добавил **15** проверок.

| № | Таблица | Имя CHECK | Правило |
|---:|---|---|---|
| 1 | `restaurant` | `restaurant_name_meaningful_ck` | Название ресторана должно содержать минимум 3 непробельных символа. |
| 2 | `restaurant` | `restaurant_address_meaningful_ck` | Адрес ресторана должен быть информативным, не менее 10 символов. |
| 3 | `customer` | `customer_full_name_meaningful_ck` | Клиент указывает имя, а не пробел или одиночный символ. |
| 4 | `dish` | `dish_name_meaningful_ck` | Название блюда не должно быть пустым или бессмысленно коротким. |
| 5 | `dish` | `dish_description_meaningful_ck` | Если описание блюда заполнено, оно должно содержать не менее 10 символов. |
| 6 | `orders` | `orders_total_covers_delivery_ck` | Итоговая сумма заказа не может быть ниже платы за доставку. |
| 7 | `orders` | `orders_comment_meaningful_ck` | Комментарий к заказу либо не указан, либо содержит содержательный текст. |
| 8 | `payment` | `payment_paid_requires_timestamp_ck` | Оплаченный/возвращённый платёж обязательно имеет время платежа. |
| 9 | `payment` | `payment_unpaid_no_timestamp_ck` | Неоплаченный/неуспешный платёж не должен иметь времени успешной оплаты. |
| 10 | `payment` | `payment_timestamp_after_creation_ck` | Оплата не может быть зафиксирована раньше создания платёжной записи. |
| 11 | `delivery` | `delivery_delivered_requires_times_ck` | Статус delivered допустим только при известных времени получения и вручения. |
| 12 | `delivery` | `delivery_arrival_after_pickup_ck` | Время вручения заказа должно быть позже времени получения курьером. |
| 13 | `delivery` | `delivery_pickup_after_creation_ck` | Курьер не может забрать заказ раньше создания записи доставки. |
| 14 | `delivery` | `delivery_cancelled_without_arrival_ck` | У отменённой доставки не должно быть времени вручения. |
| 15 | `review` | `review_comment_meaningful_ck` | Текст отзыва после удаления пробелов должен содержать хотя бы 5 символов. |

Например, ограничение `delivery_arrival_after_pickup_ck` запрещает время вручения, которое меньше либо равно времени получения заказа курьером. А `payment_paid_requires_timestamp_ck` не позволяет указать статус `paid`, забыв время платежа. Эти ограничения ловят логические ошибки данных даже тогда, когда SQL-запрос синтаксически корректен.

## 4. UNIQUE и перечислимый тип ENUM

**Два новых составных UNIQUE:**

- `dish_restaurant_name_uq` на `(restaurant_id, name)` — в одном ресторане не должно быть двух разных карточек блюда с одним названием.
- `restaurant_name_address_uq` на `(name, address)` — не допускается повторная запись одного и того же ресторана по названию и адресу.

В дополнение к этим новым ограничениям прежние `PRIMARY KEY` и `UNIQUE` сохраняются.

**ENUM:** `food_delivery.order_status` со значениями `new`, `preparing`, `on_the_way`, `delivered`, `cancelled`. Поле `orders.status` теперь имеет тип `food_delivery.order_status`, а не просто `TEXT`. Поэтому неизвестный статус база отвергнет на уровне типа.

**ENUM или таблица-справочник?** ENUM удобен для небольшого, редко изменяемого списка состояний. Но для добавления значения нужно менять тип командой `ALTER TYPE ... ADD VALUE`, а удаление или переупорядочивание значений сложнее. Справочник удобнее, если список часто пополняется, имеет дополнительные поля (например, название на разных языках) или должен изменяться через обычные `INSERT` и `UPDATE`.

## 5. Пять негативных тестов

Тесты находятся в `queries/week03_negative.sql`. Каждый тест специально нарушает правило. После каждого ожидаемого сбоя стоит `ROLLBACK TO SAVEPOINT`, а в конце — общий `ROLLBACK`, чтобы не изменять реальную базу.

| № | Действие | Ожидаемый SQLSTATE | Какое ограничение нарушено |
|---:|---|---|---|
| 1 | Поставить заказу 1 несуществующего клиента `-999` | `23503` | `orders_customer_id_fkey` (FK) |
| 2 | Переименовать блюдо 2 в `Pepperoni` в том же ресторане | `23505` | `dish_restaurant_name_uq` (UNIQUE) |
| 3 | Установить вручение до получения в доставке 1 | `23514` | `delivery_arrival_after_pickup_ck` (CHECK) |
| 4 | Заменить комментарий отзыва 1 пробелами | `23514` | `review_comment_meaningful_ck` (CHECK) |
| 5 | Поставить заказу 1 статус `flying` | `22P02` | ENUM `food_delivery.order_status` |

**Коды ошибок:** `23503` — нарушение внешнего ключа; `23505` — нарушение уникальности; `23514` — нарушение CHECK; `22P02` — неверное текстовое представление значения ENUM.

### Фактический вывод сервера PostgreSQL

**Проверено фактическим запуском PostgreSQL 18.6 на тестовой базе `food_delivery_test3` (10.10.2026).** Все пять намеренно некорректных операций были отклонены. Ниже приведены точные SQLSTATE, имена ограничений и номера строк из полученного вывода `psql` (русский текст в консоли отображался с ошибочной кодировкой):

```text
[1/5] Expected 23503 orders_customer_id_fkey
psql:queries/week03_negative.sql:14: ... 23503: ... "orders_customer_id_fkey"
SCHEMA NAME:  food_delivery
TABLE NAME:  orders
CONSTRAINT NAME:  orders_customer_id_fkey

[2/5] Expected 23505 dish_restaurant_name_uq
psql:queries/week03_negative.sql:21: ... 23505: ... "dish_restaurant_name_uq"
DETAIL:  ... (restaurant_id, name)=(1, Pepperoni) ...
SCHEMA NAME:  food_delivery
TABLE NAME:  dish
CONSTRAINT NAME:  dish_restaurant_name_uq

[3/5] Expected 23514 delivery_arrival_after_pickup_ck
psql:queries/week03_negative.sql:30: ... 23514: ... "delivery_arrival_after_pickup_ck"
SCHEMA NAME:  food_delivery
TABLE NAME:  delivery
CONSTRAINT NAME:  delivery_arrival_after_pickup_ck

[4/5] Expected 23514 review_comment_meaningful_ck
psql:queries/week03_negative.sql:37: ... 23514: ... "review_comment_meaningful_ck"
SCHEMA NAME:  food_delivery
TABLE NAME:  review
CONSTRAINT NAME:  review_comment_meaningful_ck

[5/5] Expected 22P02 food_delivery.order_status
psql:queries/week03_negative.sql:44: ... 22P02: ... food_delivery.order_status: "flying"
LOCATION:  enum_in, enum.c:133

ROLLBACK
===== END NEGATIVE TESTS =====
```

Обозначение `...` заменяет только нечитаемую кириллицу в фактическом выводе CMD; коды SQLSTATE, номера строк, названия ограничений и идентификаторы взяты из реального запуска. Все пять результатов совпали с ожиданиями. После каждого сбоя выполнен `ROLLBACK TO SAVEPOINT`, а в конце — общий `ROLLBACK`. Поэтому негативные тесты не сохранили изменений в базе.

Полный вывод запуска можно сохранить отдельно в `reports/week03_server_output.txt` для приложений к отчёту.

## 6. Проверка после запуска

После применения миграции можно проверить тип `orders.status`, имена новых ограничений и количество строк:

```sql
\d food_delivery.orders
\d food_delivery.delivery
\d food_delivery.dish
SELECT count(*) FROM food_delivery.orders;
SELECT count(*) FROM food_delivery.order_item;
```

Для исходного учебного набора ожидаются **100 заказов и 200 позиций заказов**; в экспортированном наборе было **750 строк во всех 11 таблицах**. Это числа исходных данных, а не автоматически подтверждённый результат новой миграции.

## 7. Вывод

Я подготовил обновление ограничений целостности: **11 внешних ключей** с выбранным `ON DELETE`, **15 новых содержательных CHECK**, **два новых составных UNIQUE** и **один ENUM для состояния заказа**. Отдельный файл содержит **пять негативных тестов**, которые позволяют убедиться, что PostgreSQL действительно отклоняет некорректные операции.

**Файлы СРС:** `migrations/03_constraints.sql`, `queries/week03_negative.sql`, `reports/week03.md`. Пять негативных тестов выполнены на тестовой базе, фактические коды ошибок и ограничения внесены в отчёт. Основная база требует отдельного применения миграции третьей недели.
