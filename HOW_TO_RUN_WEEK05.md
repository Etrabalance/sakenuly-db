# Неделя 5. Быстрый запуск на Windows (PostgreSQL 18)

**Новые таблицы и резервная копия не нужны:** файл делает только `SELECT` и `SET TIME ZONE` на время подключения.

1. Скопируй `queries/week05.sql` и `reports/week05.md` из архива в `C:\Users\dakar\food-delivery-db`, сохранив названия папок. Предыдущие файлы оставь.
2. Открой CMD и выполни:

```cmd
cd /d C:\Users\dakar\food-delivery-db
"C:\Program Files\PostgreSQL\18\bin\psql.exe" -X -U food_app -d food_delivery -v ON_ERROR_STOP=1 -f "queries\week05.sql"
echo %ERRORLEVEL%
```

3. Ожидается `ERRORLEVEL 0`. Увидишь десять разделов с результатами и дополнительную демонстрацию `NULL`. В основном запросе № 9 ожидаются 20 строк без времени вручения, в намеренно неправильной демонстрации `= NULL` — 0.
4. Пришли полный результат запуска, чтобы подтвердить показатели в отчёте. **В GitHub пока не загружай, сначала убедимся, что запросы выполняются на твоём PostgreSQL.**

После проверки, из папки проекта:

```cmd
git add queries/week05.sql reports/week05.md
git status
git commit -m "Add SRS Week 5 SELECT queries and report"
git push origin main
```

Ни `week05.sql`, ни `week05.md` не изменяют содержимое таблиц; объяснение неправильного сравнения с `NULL` касается только дополнительного примера, а не основных запросов.
