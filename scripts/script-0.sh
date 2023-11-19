#!/bin/bash

echo "nameserver 192.168.122.1" > /etc/resolv.conf

apt-get update
apt-get install bind9 -y

mkdir /etc/bind/e01

echo -e "
zone \"riegel.canyon.e01.com\" {
	type master;
	file \"/etc/bind/e01/riegel.canyon.e01.com\";
};

zone \"granz.channel.e01.com\" {
	type master;
	file \"/etc/bind/e01/granz.channel.e01.com\";
};
" >> /etc/bind/named.conf.local

echo -e "
;
; BIND data file for local loopback interface
;
\$TTL    604800
@       IN      SOA     riegel.canyon.e01.com. root.riegel.canyon.e01.com. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      riegel.canyon.e01.com.
@       IN      A       10.37.4.1
www     IN      A       riegel.canyon.e01.com.
" > /etc/bind/e01/riegel.canyon.e01.com

echo -e "
;
; BIND data file for local loopback interface
;
\$TTL    604800
@       IN      SOA     granz.channel.e01.com. root.granz.channel.e01.com. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      granz.channel.e01.com.
@       IN      A       10.37.3.1
www     IN      A       granz.channel.e01.com.
" > /etc/bind/e01/granz.channel.e01.com

echo -e "
options {
        directory \"/var/cache/bind\";

        forwarders {
            192.168.122.1;
        };

        //dnssec-validation auto;
        allow-query{ any; };
        listen-on-v6 { any; };
};
" > /etc/bind/named.conf.options

service bind9 restart