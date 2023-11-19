#!/bin/bash

echo "nameserver 192.168.122.1" > /etc/resolv.conf

apt-get update
apt-get install mariadb-server -y

service mysql start

echo -e "
CREATE USER 'kelompoke01'@'10.37.4.1' IDENTIFIED BY 'passworde01';
CREATE USER 'kelompoke01'@'10.37.4.3' IDENTIFIED BY 'passworde01';
CREATE USER 'kelompoke01'@'10.37.4.4' IDENTIFIED BY 'passworde01';
CREATE USER 'kelompoke01'@'localhost' IDENTIFIED BY 'passworde01';
CREATE DATABASE dbkelompoke01;
GRANT ALL PRIVILEGES ON *.* TO 'kelompoke01'@'10.37.4.1';
GRANT ALL PRIVILEGES ON *.* TO 'kelompoke01'@'10.37.4.3';
GRANT ALL PRIVILEGES ON *.* TO 'kelompoke01'@'10.37.4.4';
GRANT ALL PRIVILEGES ON *.* TO 'kelompoke01'@'localhost';
FLUSH PRIVILEGES;
" > init.sql

mysql -u root < init.sql

rm -rf init.sql

echo -e "
[mysqld]
skip-networking=0
skip-bind-address
" >> /etc/mysql/my.cnf

service mysql restart