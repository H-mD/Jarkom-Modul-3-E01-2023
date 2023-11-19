#!/bin/bash

echo -e "
upstream backend  {
        least_conn;
        server granz.channel.e01.com;
        server 10.37.3.3;
        server 10.37.3.4;
}

server {
        listen 81;
        server_name _;

        location / {
                proxy_pass http://backend;
                proxy_set_header    X-Real-IP \$remote_addr;
                proxy_set_header    X-Forwarded-For \$proxy_add_x_forwarded_for;
                proxy_set_header    Host \$http_host;
        }

        error_log /var/log/nginx/lb_error.log;
        access_log /var/log/nginx/lb_access.log;
}
" > /etc/nginx/sites-available/e01

service nginx restart