#!/bin/bash
wget -P /opt https://github.com/zitrax1/shvirtd-example-python/archive/refs/heads/main.zip
unzip /opt/main.zip -d /opt
sudo docker compose -f /opt/shvirtd-example-python-main/compose.yaml up -d
