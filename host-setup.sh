#!/bin/sh
#
# ----------------------------------------
# Description
# ----------------------------------------
# Performs the necessary base setup and configuration of the host OS.
#
# This includes:
#   - install and configure Docker
#   - configure NICs
#   - enable packet forwarding
#   - set firewall rules
#
# ----------------------------------------
# License
# ----------------------------------------
# Copyright (C) 2020 0x4242
#
# This program is free software: you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free Software
# Foundation, either version 3 of the License, or (at your option) any later
# version.
#
# This program is distributed in the hope that it will be useful,but WITHOUT ANY
# WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
# A PARTICULAR PURPOSE. See the GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along with
# this program.  If not, see <https://www.gnu.org/licenses/>.
#
# ----------------------------------------
# Social
# ----------------------------------------
# Web: http://0x4242.net
# Twitter: @0x4242 <https://twitter.com/0x4242>
# GitHub: x4242 <https://github.com/x4242>
#
# ----------------------------------------
# Change History
# ----------------------------------------
# lastmod: 2020-02-21T20:08:34+01:00
# changelog:
#   - 2020-01-29: static IP configuration on internal NIC
#   - 2020-01-23: created

INT_IF="enp3s0"
INT_IP4="10.66.66.1/24"

EXT_IF="tbd"

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
