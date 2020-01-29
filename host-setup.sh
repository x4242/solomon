#!/usr/bin/env bash
#
# ----------------------------------------
# Description
# ----------------------------------------
# tbd
#
# ----------------------------------------
# Change History
# ----------------------------------------
# lastmod: 2020-01-29T21:31:47+01:00
# changelog:
#   - 2020-01-29: static IP configuration on intern NIC
#   - 2020-01-23: created

INT_IF="enp3s0"
INT_IP4="10.66.66.1/24"

# Update the apt package index:
apt-get update

# Install the latest version of Docker Engine Community Edition and containerd
apt-get install docker-ce docker-ce-cli containerd.io docker-compose
systemctl enable docker.service

# configure static IP on internal NIC
echo "auto $INT_IF" >> /etc/network/interfaces
echo "allow-hotplug $INT_IF" >> /etc/network/interfaces
echo "iface $INT_IF inet static" >> /etc/network/interfaces
echo -e "\taddress $INT_IP4" >> /etc/network/interfaces

# enable packet forwarding IPv4
sed -i "s/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g" /etc/sysctl.conf
# enable packet forwarding IPv6
#sed -i "s/#net.ipv6.conf.all.forwarding=1/net.ipv6.conf.all.forwarding=1/g" /etc/sysctl.conf
