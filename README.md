# ЗАПУСК

### Команды bash

1) Скопировать конфиги - ``cp .env.example .env; cp backend/.env.example backend/.env; cp frontend/.env.example frontend/.env``
2) Установить зависимости бэкенда - ``make install``
3) Поднять докер - ``make dev``
4) Запустить миграции -  ``make migrate``
5) Запустить сидэр -  ``make seed``
6) Открыть http://localhost:3000/

### Комментарий

- Так как основной стек nextjs/vue, реализовывал по документации. 
- Старался максимально соответствовать best practices laravel.
- На фронт next осталось меньше времени по этому реализовал проще.
- Буду рад обратной связи.


[Все допущения проекта и доп комментарии → ASSUMPTIONS.md](ASSUMPTIONS.md)

