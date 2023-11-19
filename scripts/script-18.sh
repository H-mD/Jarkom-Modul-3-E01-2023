#!/bin/bash

echo -e "
upstream backendlaravel  {
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
" >> /etc/nginx/sites-available/e01

service nginx restart