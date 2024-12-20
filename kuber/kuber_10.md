# Домашнее задание к занятию «Компоненты Kubernetes»

### Цель задания

Рассчитать требования к кластеру под проект

------

### Инструменты и дополнительные материалы, которые пригодятся для выполнения задания:

- [Considerations for large clusters](https://kubernetes.io/docs/setup/best-practices/cluster-large/),
- [Architecting Kubernetes clusters — choosing a worker node size](https://learnk8s.io/kubernetes-node-size).

------

### Задание. Необходимо определить требуемые ресурсы
Известно, что проекту нужны база данных, система кеширования, а само приложение состоит из бекенда и фронтенда. Опишите, какие ресурсы нужны, если известно:

1. Необходимо упаковать приложение в чарт для деплоя в разные окружения. 
2. База данных должна быть отказоустойчивой. Потребляет 4 ГБ ОЗУ в работе, 1 ядро. 3 копии. 
3. Кеш должен быть отказоустойчивый. Потребляет 4 ГБ ОЗУ в работе, 1 ядро. 3 копии. 
4. Фронтенд обрабатывает внешние запросы быстро, отдавая статику. Потребляет не более 50 МБ ОЗУ на каждый экземпляр, 0.2 ядра. 5 копий. 
5. Бекенд потребляет 600 МБ ОЗУ и по 1 ядру на копию. 10 копий.

----

### Правила приёма работы

1. Домашняя работа оформляется в своем Git-репозитории в файле README.md. Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.
2. Сначала сделайте расчёт всех необходимых ресурсов.
3. Затем прикиньте количество рабочих нод, которые справятся с такой нагрузкой.
4. Добавьте к полученным цифрам запас, который учитывает выход из строя как минимум одной ноды. 
5. Добавьте служебные ресурсы к нодам. Помните, что для разных типов нод требовния к ресурсам разные. 
6. В результате должно быть указано количество нод и их параметры.

 Решение:
1. Ресурсы приложения
Суммарные ресурсы для всех компонентов приложения:

База данных (3 копии):
RAM: 4 ГБ × 3 = 12 ГБ
CPU: 1 ядро × 3 = 3 ядра
Кеш (3 копии):
RAM: 4 ГБ × 3 = 12 ГБ
CPU: 1 ядро × 3 = 3 ядра
Фронтенд (5 копий):
RAM: 50 МБ × 5 = 250 МБ (0.25 ГБ)
CPU: 0.2 ядра × 5 = 1 ядро
Бекенд (10 копий):
RAM: 600 МБ × 10 = 6 ГБ
CPU: 1 ядро × 10 = 10 ядер
Итого для приложения:

RAM: 12 + 12 + 0.25 + 6 = 30.25 ГБ
CPU: 3 + 3 + 1 + 10 = 17 ядер

Для отказоустойчивости добавляем запас ресурсов, чтобы кластер мог выдержать отказ одной ноды:

Если выстраивается 3-нодный кластер, необходимо обеспечить возможность переноса нагрузки с одной ноды на оставшиеся. Это добавляет запас:
RAM: ~30% от общей потребности
CPU: ~30% от общей потребности
Запас ресурсов:

RAM: 30.25 ГБ × 30% = 9.08 ГБ (округляем до 10 ГБ)
CPU: 17 ядер × 30% = 5.1 ядра (округляем до 6 ядер)
С учётом запаса:

RAM: 30.25 ГБ + 10 ГБ = 40.25 ГБ
CPU: 17 ядер + 6 ядер = 23 ядра

Количество нод
Вариант 1: Ноды с 16 ГБ RAM и 8 CPU
Необходимое количество RAM: 40.25 ГБ ÷ 16 ГБ ≈ 3 ноды
Необходимое количество CPU: 23 ядер ÷ 8 CPU ≈ 3 ноды
Результат: Требуется минимум 3 ноды по 16 ГБ RAM и 8 CPU. С учётом запаса и отказоустойчивости добавляем 1 дополнительную ноду, итого 4 ноды.

Вариант 2: Ноды с 32 ГБ RAM и 16 CPU
Необходимое количество RAM: 40.25 ГБ ÷ 32 ГБ ≈ 2 ноды
Необходимое количество CPU: 23 ядер ÷ 16 CPU ≈ 2 ноды
Результат: Требуется минимум 2 ноды по 32 ГБ RAM и 16 CPU. С учётом отказоустойчивости добавляем 1 дополнительную ноду, итого 3 ноды.