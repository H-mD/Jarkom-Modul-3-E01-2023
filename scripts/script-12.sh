#!/bin/bash

echo -e "
upstream backend  {
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
" > /etc/nginx/sites-available/e01

service nginx restart

# hwaddress ether 9a:4c:30:fe:f9:99
# host Richter {
#     hardware ethernet 9a:4c:30:fe:f9:99;
#     fixed-address 10.37.3.69;
# }

# hwaddress ether 16:bc:5a:92:21:48
# host Stark {
#     hardware ethernet 16:bc:5a:92:21:48;
#     fixed-address 10.37.4.168;
# }