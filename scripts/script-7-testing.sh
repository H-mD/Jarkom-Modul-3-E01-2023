#!/bin/bash

apt-get update 
apt-get install apache2-utils -y

ab -n 1000 -c 100 http://10.37.2.3:81/ 

ab -n 200 -c 10 http://10.37.2.3:81/

ab -n 100 -c 10 http://10.37.2.3:81/