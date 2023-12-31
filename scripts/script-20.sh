#!/bin/bash

echo -e "
upstream backendphp  {
        server granz.channel.e01.com;
        server 10.37.3.3;
        server 10.37.3.4;
}

server {
        listen 81;
        server_name _;

        location / {
                proxy_pass http://backendphp;
                proxy_set_header    X-Real-IP \$remote_addr;
                proxy_set_header    X-Forwarded-For \$proxy_add_x_forwarded_for;
                proxy_set_header    Host \$http_host;

                auth_basic \"Administrator's Area\";
                auth_basic_user_file /etc/nginx/rahasisakita/.htpasswd;

                allow 10.37.3.69;
                allow 10.37.3.70;
                allow 10.37.4.167;
                allow 10.37.4.168;
                deny all;
        }

        location /its {
            proxy_pass https://www.its.ac.id;
        }

        location ~ /\\.ht {
            deny all;
        }

        error_log /var/log/nginx/lb_error.log;
        access_log /var/log/nginx/lb_access.log;
}


upstream backendlaravel  {
        least_conn;
        server riegel.canyon.e01.com;
        server 10.37.4.3;
        server 10.37.4.4;
}

server {
        listen 82;
        server_name _;

        location / {
                proxy_pass http://backendlaravel;
                proxy_set_header    X-Real-IP \$remote_addr;
                proxy_set_header    X-Forwarded-For \$proxy_add_x_forwarded_for;
                proxy_set_header    Host \$http_host;
        }

        location /worker1/ {
                proxy_bind 10.37.2.3;
                proxy_pass http://riegel.canyon.e01.com;
        }

        location /worker2/ {
                proxy_bind 10.37.2.3;
                proxy_pass http://10.37.4.3;
        }

        location /worker3/ {
                proxy_bind 10.37.2.3;
                proxy_pass http://10.37.4.4;
        }

        error_log /var/log/nginx/lb_error.log;
        access_log /var/log/nginx/lb_access.log;
}
" > /etc/nginx/sites-available/e01

service nginx restart