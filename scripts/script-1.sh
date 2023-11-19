#!/bin/bash

apt-get update
DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends isc-dhcp-relay
service isc-dhcp-relay start

echo -e "
SERVERS=\"10.37.1.2\"
INTERFACES=\"eth1 eth2 eth3 eth4\"
OPTIONS=
" > /etc/default/isc-dhcp-relay

echo -e "
net.ipv4.ip_forward=1
" >> /etc/sysctl.conf

service isc-dhcp-relay restart