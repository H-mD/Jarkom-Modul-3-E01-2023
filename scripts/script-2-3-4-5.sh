#!/bin/bash

echo "nameserver 192.168.122.1" > /etc/resolv.conf

apt-get update
apt-get install isc-dhcp-server -y

echo -e "
INTERFACESv4=\"eth0\"
INTERFACESv6=\"\"
" > /etc/default/isc-dhcp-server

echo -e "
subnet 10.37.1.0 netmask 255.255.255.0 {
}

subnet 10.37.2.0 netmask 255.255.255.0 {
}

subnet 10.37.3.0 netmask 255.255.255.0 {
    range 10.37.3.16 10.37.3.32;
    range 10.37.3.64 10.37.3.80;
    option routers 10.37.3.2;
    option broadcast-address 10.37.3.255;
    option domain-name-servers 10.37.1.3;
    default-lease-time 180;
    max-lease-time 5760;
}

host Lawine {
    hardware ethernet c6:2b:76:e6:73:3b;
    fixed-address 10.37.3.1;
}

host Linie {
    hardware ethernet 16:88:9f:6a:81:1e;
    fixed-address 10.37.3.3;
}

host Lugner {
    hardware ethernet e6:34:06:30:c5:3d;
    fixed-address 10.37.3.4;
}

subnet 10.37.4.0 netmask 255.255.255.0 {
    range 10.37.4.12 10.37.4.20;
    range 10.37.4.160 10.37.4.168;
    option routers 10.37.4.2;
    option broadcast-address 10.37.4.255;
    option domain-name-servers 10.37.1.3;
    default-lease-time 720;
    max-lease-time 5760;
}

host Frieren {
    hardware ethernet 3a:d2:4e:43:3e:e9;
    fixed-address 10.37.4.1;
}

host Flamme {
    hardware ethernet ea:69:d5:89:14:be;
    fixed-address 10.37.4.3;
}

host Fern {
    hardware ethernet 32:11:a8:d8:c6:bf;
    fixed-address 10.37.4.4;
}
" >> /etc/dhcp/dhcpd.conf

service isc-dhcp-server restart