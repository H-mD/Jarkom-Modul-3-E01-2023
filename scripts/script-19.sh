#!/bin/bash

echo -e "
[e01_site]
user = e01_user
group = e01_user
listen = /var/run/php/php8.0-fpm-e01-site.sock
listen.owner = www-data
listen.group = www-data
php_admin_value[disable_functions] = exec,passthru,shell_exec,system
php_admin_flag[allow_url_fopen] = off

; Choose how the process manager will control the number of child processes.

pm = dynamic
pm.max_children = 75
pm.start_servers = 10
pm.min_spare_servers = 5
pm.max_spare_servers = 20
pm.process_idle_timeout = 10s

;contoh diatas konfigurasi untuk mengatur jumalh proses PHP-FPM yang berjalan
" > /etc/php/8.0/fpm/pool.d/e01.conf

groupadd e01_user
useradd -g e01_user e01_user

/etc/init.d/php8.0-fpm restart

echo -e "
server {
        listen 80;

        root /var/www/laravel-praktikum-jarkom/public;

        index index.html index.htm index.nginx-debian.html index.php;

        server_name _;
        #server_name riegel.canyon.e01.com www.riegel.canyon.e01.com;

        location / {
                try_files \$uri \$uri/ /index.php?\$query_string;
        }

        location ~ \\.php\$ {
                include snippets/fastcgi-php.conf;
                fastcgi_pass unix:/var/run/php/php8.0-fpm-e01-site.sock;
        }

        location ~ /\\.ht {
               deny all;
        }

        error_log /var/log/nginx/e01_error.log;
        access_log /var/log/nginx/e01_access.log;

}
" > /etc/nginx/sites-available/e01

service nginx restart