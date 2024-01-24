# Домашнее задание к занятию 2. «SQL»


## Задача 1

Используя Docker, поднимите инстанс PostgreSQL (версию 12) c 2 volume, 
в который будут складываться данные БД и бэкапы.

Приведите получившуюся команду или docker-compose-манифест.
1. [docker-compose](https://github.com/zitrax1/devops-netology/blob/main/data-base/docker-compose.yml)
## Задача 2

В БД из задачи 1: 

- создайте пользователя test-admin-user и БД test_db;
- в БД test_db создайте таблицу orders и clients (спeцификация таблиц ниже);
- предоставьте привилегии на все операции пользователю test-admin-user на таблицы БД test_db;
- создайте пользователя test-simple-user;
- предоставьте пользователю test-simple-user права на SELECT/INSERT/UPDATE/DELETE этих таблиц БД test_db.

Таблица orders:

- id (serial primary key);
- наименование (string);
- цена (integer).

Таблица clients:

- id (serial primary key);
- фамилия (string);
- страна проживания (string, index);
- заказ (foreign key orders).

Приведите:

- итоговый список БД после выполнения пунктов выше;
- описание таблиц (describe);
- SQL-запрос для выдачи списка пользователей с правами над таблицами test_db;
- список пользователей с правами над таблицами test_db.

1. [SQL-запрос](https://github.com/zitrax1/devops-netology/blob/main/data-base/img/sql_1.jpg)

## Задача 3

Используя SQL-синтаксис, наполните таблицы следующими тестовыми данными:

Таблица orders

|Наименование|цена|
|------------|----|
|Шоколад| 10 |
|Принтер| 3000 |
|Книга| 500 |
|Монитор| 7000|
|Гитара| 4000|

Таблица clients

|ФИО|Страна проживания|
|------------|----|
|Иванов Иван Иванович| USA |
|Петров Петр Петрович| Canada |
|Иоганн Себастьян Бах| Japan |
|Ронни Джеймс Дио| Russia|
|Ritchie Blackmore| Russia|

Используя SQL-синтаксис:
- вычислите количество записей для каждой таблицы.

Приведите в ответе:

    - запросы
	1. Добавление: 
	INSERT INTO public.orders ("наименование", "цена") 
	values ('шоколад', 10),
	('Принтер', 3000),
	('Книга', 500),
	('Монитор', 7000),
	('Гитара', 4000);

	INSERT INTO public.clients ("фамилия", "страна проживания") 
	values ('Иванов Иван Иванович', 'USA'),
	('Петров Петр Петрович', 'Canada'),
	('Иоганн Себастьян Бах', 'Japan'),
	('Ронни Джеймс Дио', 'Russia'),
	('Ritchie Blackmore', 'Russia');
	
	2. Подсчет:
		2.1 select count (id)
			from orders;
	
		2.2 select count (id)
			from clients;
    
	
	- результаты их выполнения
	1. [Добавление](https://github.com/zitrax1/devops-netology/blob/main/data-base/img/sql-inser.jpg)
	2. [Подсчет](https://github.com/zitrax1/devops-netology/blob/main/data-base/img/sql-count1.jpg)
	3. [Подсчет](https://github.com/zitrax1/devops-netology/blob/main/data-base/img/sql-count2.jpg)

## Задача 4

Часть пользователей из таблицы clients решили оформить заказы из таблицы orders.

Используя foreign keys, свяжите записи из таблиц, согласно таблице:

|ФИО|Заказ|
|------------|----|
|Иванов Иван Иванович| Книга |
|Петров Петр Петрович| Монитор |
|Иоганн Себастьян Бах| Гитара |

Приведите SQL-запросы для выполнения этих операций.
1. ALTER TABLE public.orders RENAME COLUMN наименование TO "Заказ";
2. ALTER TABLE public.clients RENAME COLUMN фамилия TO "ФИО";
3. UPDATE clients SET ФИО=3 WHERE id=1;

Приведите SQL-запрос для выдачи всех пользователей, которые совершили заказ, а также вывод этого запроса.
1. select ФИО FROM clients, orders where clients.заказ = orders.id;


## Задача 5

Получите полную информацию по выполнению запроса выдачи всех пользователей из задачи 4 
(используя директиву EXPLAIN).

Приведите получившийся результат и объясните, что значат полученные значения.
1. [explain](https://github.com/zitrax1/devops-netology/blob/main/data-base/img/sql-explain.jpg)
по большому счет показывает: ход действия запроса, затраченное время (cost) и какие значения были использованы, и с какими таблицами и строками.

## Задача 6

Создайте бэкап БД test_db и поместите его в volume, предназначенный для бэкапов (см. задачу 1).

Остановите контейнер с PostgreSQL, но не удаляйте volumes.

Поднимите новый пустой контейнер с PostgreSQL.

Восстановите БД test_db в новом контейнере.

Приведите список операций, который вы применяли для бэкапа данных и восстановления. 
1. подключение к контейнеру  sudo docker exec -it test-db /bin/bash
2. делаем backup базы  pg_dumpall -U postgres > /var/lib/postgresql/data/pgbackup/pg_backup
3. подключаемся к новой машине psql -h 172.22.0.3 --username=postgres
4. делаем восстановление  psql -U postgres -f /var/lib/postgresql/data/pgbackup/pg_backup postgres

---

