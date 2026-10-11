# Как выполнить СРС №4 — Доставка еды

Работай в Windows CMD из папки `C:\Users\dakar\food-delivery-db`. Перед копированием файлов сделай резервную копию базы; не запускай повторно скрипты миграций №1–3.

## 0. Резервная копия

```cmd
cd /d C:\Users\dakar\food-delivery-db
"C:\Program Files\PostgreSQL\18\bin\pg_dump.exe" -U food_app -d food_delivery -n food_delivery -f "%USERPROFILE%\food_delivery_before_week04.sql"
echo %ERRORLEVEL%
```

Ожидаем `0`. Убедись, что файл резервной копии появился в домашней папке.

## 1. Копирование файлов

Из архива добавь папку `seed` и файл `reports/week04.md` в существующий проект. Не удаляй старые `migrations`, `queries`, `reports`, `diagrams` или `README.md`.

## 2. Безопасная проба на отдельной базе (рекомендуется)

```cmd
"C:\Program Files\PostgreSQL\18\bin\psql.exe" -U postgres -d postgres -c "CREATE DATABASE food_delivery_test4 OWNER food_app;"
"C:\Program Files\PostgreSQL\18\bin\psql.exe" -X -U food_app -d food_delivery_test4 -v ON_ERROR_STOP=1 -f "%USERPROFILE%\food_delivery_before_week04.sql"
```

Если база уже есть, сначала проверь, что это именно твоя временная тестовая база, а не рабочая.

Затем выполнять **строго в таком порядке**. Команды ниже указаны для `food_delivery_test4`:

```cmd
"C:\Program Files\PostgreSQL\18\bin\psql.exe" -X -U food_app -d food_delivery_test4 -v ON_ERROR_STOP=1 -f "seed\04_dimensions.sql"
"C:\Program Files\PostgreSQL\18\bin\psql.exe" -X -U food_app -d food_delivery_test4 -v ON_ERROR_STOP=1 -f "seed\04_fact.sql"
"C:\Program Files\PostgreSQL\18\bin\psql.exe" -X -U food_app -d food_delivery_test4 -v ON_ERROR_STOP=1 -f "seed\04_dml.sql"
"C:\Program Files\PostgreSQL\18\bin\psql.exe" -X -U food_app -d food_delivery_test4 -v ON_ERROR_STOP=1 -f "seed\04_verify.sql"
```

**Ожидаем:** 300000 строк в `dish_view`, минимум 50 строк в справочниках, отсутствие `ERROR` или `ОШИБКА`. Замерь время после `INSERT 0 300000` в выводе `04_fact.sql` и перепиши его в `reports/week04.md`. Замеры на тестовой базе могут отличаться от основной базы.

Чтобы проверить повторяемость, запиши `first_1000_md5` из последней команды, снова выполни `seed\04_fact.sql`, затем `seed\04_verify.sql` и сравни значения.

## 3. Основная база — только после удачной проверки тестовой

Повтори те же четыре команды, **заменив** в каждой `-d food_delivery_test4` на `-d food_delivery`. Сохрани реальные результаты размера базы, времени и распределений в `reports/week04.md`.

## 4. GitHub

Когда всё протестировано и отчёт дополнен **реальными** числами:

```cmd
git add seed/04_dimensions.sql seed/04_fact.sql seed/04_dml.sql seed/04_verify.sql seed/week04_category_updates.csv seed/week04_categories_export.csv reports/week04.md HOW_TO_RUN_WEEK04.md
git status
git commit -m "Add SRS Week 4 data generation and DML"
git push origin main
```

Если `seed/week04_categories_export.csv` не создан, проверь выполнение `seed/04_dml.sql` перед `git add`.

Не загружай ZIP-архивы и резервные копии базы в Git.

## Важно

- `04_fact.sql` при повторном запуске очищает **только новую** таблицу `food_delivery.dish_view`, после чего создаёт заново 300000 синтетических строк.
- Синтетические события относятся к 2027 году; это модель нагрузки, не настоящие данные клиентов.
- `\copy` читает и пишет CSV относительно **текущей папки CMD**, поэтому запускай команды из корня репозитория.
- `\timing on` включает фактические измерения PostgreSQL; не вписывай вымышленные числа в отчёт.
- Если возникает ошибка, остановись и пришли её сообщение, прежде чем запускать файлы на основной базе.
