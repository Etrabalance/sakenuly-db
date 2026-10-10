# СРС — Неделя 3: инструкция по добавлению файлов

Продолжение существующего проекта `food-delivery-db` .

Скопировать в корень старой папки проекта три каталога из архива: `migrations/`, `queries/`, `reports/`. При объединении папок **не удалять старые файлы**. Архив не содержит существующих `01_init.sql`, `02_seed.sql`, `02_schema.sql` и `README.md`, поэтому они сохранятся.

1. Основная база уже должна быть обновлена миграцией второй недели `02_schema.sql`.
2. Перед миграцией третьей недели сохранить резервную копию `pg_dump`.
3. Из корня проекта в CMD выполнить:

```cmd
chcp 65001
set "PGCLIENTENCODING=UTF8"
"C:\Program Files\PostgreSQL\18\bin\psql.exe" -X -U food_app -d food_delivery -v ON_ERROR_STOP=1 -f "migrations\03_constraints.sql"
echo %ERRORLEVEL%
```

Ожидается `COMMIT` и `0`. Если появилась ошибка, НЕ запускать тесты; прислать ошибку для исправления.

4. После успешной миграции запустить безопасные негативные тесты (данные не сохраняются):

```cmd
"C:\Program Files\PostgreSQL\18\bin\psql.exe" -X -U food_app -d food_delivery -v ON_ERROR_STOP=0 -f "queries\week03_negative.sql" > "reports\week03_server_output.txt" 2>&1
notepad "reports\week03_server_output.txt"
```

В логе ожидаются 5 ошибок с кодами `23503`, `23505`, `23514`, `23514`, `22P02`; других ошибок быть не должно. Вставить фактические строки из лога в раздел 5 `reports/week03.md` вместо заполнителей.

5. Перед коммитом проверить `git status`, затем добавить новые файлы:

```cmd
git add migrations/03_constraints.sql queries/week03_negative.sql reports/week03.md reports/week03_server_output.txt
git commit -m "Add SRS Week 3 integrity constraints and negative tests"
git push origin main
```

Не добавлять в Git резервные копии базы и пароли. Данные в заказах, оплатах и доставках не должны изменяться от негативных тестов, поскольку их SQL-файл заканчивается общим `ROLLBACK`.

**Важно:** команды НЕ выполнялись на вашем компьютере автоматически. Фактический вывод PostgreSQL для отчёта должен быть получен из вашей СУБД. Не добавляйте в отчёт выдуманные сообщения.
