# Домашнее задание к занятию «Вычислительные мощности. Балансировщики нагрузки»  

### Подготовка к выполнению задания

1. Домашнее задание состоит из обязательной части, которую нужно выполнить на провайдере Yandex Cloud, и дополнительной части в AWS (выполняется по желанию). 
2. Все домашние задания в блоке 15 связаны друг с другом и в конце представляют пример законченной инфраструктуры.  
3. Все задания нужно выполнить с помощью Terraform. Результатом выполненного домашнего задания будет код в репозитории. 
4. Перед началом работы настройте доступ к облачным ресурсам из Terraform, используя материалы прошлых лекций и домашних заданий.

---
## Задание 1. Yandex Cloud 

**Что нужно сделать**

1. Создать бакет Object Storage и разместить в нём файл с картинкой:

 - Создать бакет в Object Storage с произвольным именем (например, _имя_студента_дата_).
 - Положить в бакет файл с картинкой.
 - Сделать файл доступным из интернета.
 
2. Создать группу ВМ в public подсети фиксированного размера с шаблоном LAMP и веб-страницей, содержащей ссылку на картинку из бакета:

 - Создать Instance Group с тремя ВМ и шаблоном LAMP. Для LAMP рекомендуется использовать `image_id = fd827b91d99psvq5fjit`.
 - Для создания стартовой веб-страницы рекомендуется использовать раздел `user_data` в [meta_data](https://cloud.yandex.ru/docs/compute/concepts/vm-metadata).
 - Разместить в стартовой веб-странице шаблонной ВМ ссылку на картинку из бакета.
 - Настроить проверку состояния ВМ.
 
3. Подключить группу к сетевому балансировщику:

 - Создать сетевой балансировщик.
 - Проверить работоспособность, удалив одну или несколько ВМ.


### Решение:

1) Задание 1 ![screenshot-1](https://github.com/zitrax1/devops-netology/blob/main/cloud_provider/img/bucket.jpg)
2) Задание 1 ![screenshot-2](https://github.com/zitrax1/devops-netology/blob/main/cloud_provider/img/group.jpg)
3) Задание 1 ![screenshot-3](https://github.com/zitrax1/devops-netology/blob/main/cloud_provider/img/load-balance.jpg)




### манифесты:
1) [locals](https://github.com/zitrax1/devops-netology/blob/main/cloud_provider/hw2/locals.tf)
2) [main](https://github.com/zitrax1/devops-netology/blob/main/cloud_provider/hw2/main.tf)
3) [variables](https://github.com/zitrax1/devops-netology/blob/main/cloud_provider/hw2/variables.tf)
4) [vms_platform](https://github.com/zitrax1/devops-netology/blob/main/cloud_provider/hw2/vms_platform.tf)
5) [output](https://github.com/zitrax1/devops-netology/blob/main/cloud_provider/hw2/output.tf)