#!/bin/bash

apt-get update
apt-get install unzip nginx php php-fpm -y

curl -L -o "php.zip" "https://drive.google.com/uc?export=download&id=1ViSkRq7SmwZgdK64eRbr5Fm1EGCTPrU1"

unzip php.zip
rm -rf php.zip

mv ./modul-3 /var/www/modul-3

echo -e "
server {
        listen 80;

        root /var/www/modul-3;

        index index.html index.htm index.nginx-debian.html index.php;

        server_name _;
        # server_name granz.channel.e01.com www.granz.channel.e01.com;

        location / {
                try_files \$uri \$uri/ /index.php?\$query_string;
        }

        location ~ \\.php$ {
                include snippets/fastcgi-php.conf;
                fastcgi_pass unix:/run/php/php7.3-fpm.sock;
        }

        location ~ /\\.ht {
               deny all;
        }

        error_log /var/log/nginx/e01_error.log;
        access_log /var/log/nginx/e01_access.log;
}
" > /etc/nginx/sites-available/e01

ln -s /etc/nginx/sites-available/e01 /etc/nginx/sites-enabled/
unlink /etc/nginx/sites-enabled/default

service nginx restart
service php7.3-fpm start