# Домашнее задание к занятию «Введение в Terraform»

### Цели задания

1. Установить и настроить Terrafrom.
2. Научиться использовать готовый код.

### Задание 1

1. Перейдите в каталог [**src**](https://github.com/netology-code/ter-homeworks/tree/main/01/src). Скачайте все необходимые зависимости, использованные в проекте. 
2. Изучите файл **.gitignore**. В каком terraform-файле, согласно этому .gitignore, допустимо сохранить личную, секретную информацию? - в файле personal.auto.tfvars
3. Выполните код проекта. Найдите  в state-файле секретное содержимое созданного ресурса **random_password**, пришлите в качестве ответа конкретный ключ и его значение.
![screenshot-1](https://github.com/zitrax1/devops-netology/blob/main/terraform/img/hw_1.1.jpg)

4. Раскомментируйте блок кода, примерно расположенный на строчках 29–42 файла **main.tf**.
Выполните команду ```terraform validate```. Объясните, в чём заключаются намеренно допущенные ошибки. Исправьте их. - небыло имени в блоке docker_image, неправильное имя у docker_container?, лишнее слово "_FAKE", а так же большая буква T
5. Выполните код. В качестве ответа приложите: исправленный фрагмент кода и вывод команды ```docker ps```. 
![screenshot-1](https://github.com/zitrax1/devops-netology/blob/main/terraform/img/hw_1.2.jpg)
![screenshot-1](https://github.com/zitrax1/devops-netology/blob/main/terraform/img/hw_1.3.jpg)

6. Замените имя docker-контейнера в блоке кода на ```hello_world```. Не перепутайте имя контейнера и имя образа. Мы всё ещё продолжаем использовать name = "nginx:latest". Выполните команду ```terraform apply -auto-approve```.
Объясните своими словами, в чём может быть опасность применения ключа  ```-auto-approve```. Догадайтесь или нагуглите зачем может пригодиться данный ключ? В качестве ответа дополнительно приложите вывод команды ```docker ps```.
```-auto-approve``` - авто принятиевсех изменений, опасно что изменения будут применены без потдверждения, удобно тем что изменения будут сразу применены без подтверждения
![screenshot-1](https://github.com/zitrax1/devops-netology/blob/main/terraform/img/hw_1.4.jpg)

8. Уничтожьте созданные ресурсы с помощью **terraform**. Убедитесь, что все ресурсы удалены. Приложите содержимое файла **terraform.tfstate**. 
![screenshot-1](https://github.com/zitrax1/devops-netology/blob/main/terraform/img/hw_1.5.jpg)

9. Объясните, почему при этом не был удалён docker-образ **nginx:latest**. Ответ **ОБЯЗАТЕЛЬНО НАЙДИТЕ В ПРЕДОСТАВЛЕННОМ КОДЕ**, а затем **ОБЯЗАТЕЛЬНО ПОДКРЕПИТЕ** строчкой из документации [**terraform провайдера docker**](https://docs.comcloud.xyz/providers/kreuzwerker/docker/latest/docs).  (ищите в классификаторе resource docker_image )
не удален так как есть строка keep_locally = true
![screenshot-1](https://github.com/zitrax1/devops-netology/blob/main/terraform/img/hw_1.6.jpg)