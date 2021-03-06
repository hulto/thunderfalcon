#!/bin/bash


sudo ufw --force reset

sudo ufw allow from 10.3.1.0/24 to any port 80
sudo ufw allow from 10.3.1.0/24 to any port 443
sudo ufw allow from 172.16.0.0/16 to any port 80
sudo ufw allow from 172.16.0.0/16 to any port 443
sudo ufw allow from 172.16.248.0/22
sudo ufw deny 10.0.1.0/8

