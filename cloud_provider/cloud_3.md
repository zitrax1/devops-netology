# Домашнее задание к занятию «Безопасность в облачных провайдерах»

## Задание 1. Yandex Cloud   

1. С помощью ключа в KMS необходимо зашифровать содержимое бакета:

 - создать ключ в KMS;
 - с помощью ключа зашифровать содержимое бакета, созданного ранее.
2. (Выполняется не в Terraform)* Создать статический сайт в Object Storage c собственным публичным адресом и сделать доступным по HTTPS:

 - создать сертификат;
 - создать статическую страницу в Object Storage и применить сертификат HTTPS;
 - в качестве результата предоставить скриншот на страницу с сертификатом в заголовке (замочек).


### Решение:

1) Задание 1 ![screenshot-1](https://github.com/zitrax1/devops-netology/blob/main/cloud_provider/img/https.jpg)
2) Задание 1 ![screenshot-2](https://github.com/zitrax1/devops-netology/blob/main/cloud_provider/img/crt.jpg)





### манифесты:
1) [main](https://github.com/zitrax1/devops-netology/blob/main/cloud_provider/hw3/main.tf)