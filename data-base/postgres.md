# Домашнее задание к занятию 4. «PostgreSQL»

## Задача 1

Используя Docker, поднимите инстанс PostgreSQL (версию 13). Данные БД сохраните в volume.

Подключитесь к БД PostgreSQL, используя `psql`.

Воспользуйтесь командой `\?` для вывода подсказки по имеющимся в `psql` управляющим командам.

**Найдите и приведите** управляющие команды для:

- вывода списка БД - \l
- подключения к БД - \с
- вывода списка таблиц - \dt
- вывода описания содержимого таблиц - \dT
- выхода из psql - \q

## Задача 2

Используя `psql`, создайте БД `test_database`.

Изучите [бэкап БД](https://github.com/netology-code/virt-homeworks/tree/virt-11/06-db-04-postgresql/test_data).

Восстановите бэкап БД в `test_database`.

Перейдите в управляющую консоль `psql` внутри контейнера.

Подключитесь к восстановленной БД и проведите операцию ANALYZE для сбора статистики по таблице.

Используя таблицу [pg_stats](https://postgrespro.ru/docs/postgresql/12/view-pg-stats), найдите столбец таблицы `orders` 
с наибольшим средним значением размера элементов в байтах.

**Приведите в ответе** команду, которую вы использовали для вычисления, и полученный результат.

```
select ps.tablename, ps.attname , ps.avg_width from pg_stats as ps where ps.tablename='orders'
order by avg_width  desc 
limit 1
;
```

## Задача 3

Архитектор и администратор БД выяснили, что ваша таблица orders разрослась до невиданных размеров и
поиск по ней занимает долгое время. Вам как успешному выпускнику курсов DevOps в Нетологии предложили
провести разбиение таблицы на 2: шардировать на orders_1 - price>499 и orders_2 - price<=499.

Предложите SQL-транзакцию для проведения этой операции.

```
begin transaction

-- создание orders_1
create table orders_1 (check (price > 499)) inherits (orders);

--аполнеение orders_1
insert into orders_1 (id, title, price) 
select id, title, price from orders where price > 499;

-- создание orders_2
create table orders_2 (check (price <= 499)) inherits (orders);

--заполнеение orders_2
insert into orders_2 (id, title, price)
select id, title, price from orders where price <= 499;

commit transaction
```

Можно ли было изначально исключить ручное разбиение при проектировании таблицы orders? - да, можно было сразу создать такие таблицы и создать правила для распределения данных по условиям

## Задача 4

Используя утилиту `pg_dump`, создайте бекап БД `test_database`.

Как бы вы доработали бэкап-файл, чтобы добавить уникальность значения столбца `title` для таблиц `test_database`?

```
ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id)
	ADD CONSTRAINT orders_unique UNIQUE (title);
```	

---

### Как cдавать задание

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---

