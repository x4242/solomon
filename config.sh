#!/bin/sh
#
# ----------------------------------------
# Description
# ----------------------------------------
# Create service config files from templates.
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
# lastmod: 2020-01-29T23:55:58+01:00
# changelog:
#   - 2020-01-29:
#     - local-zone.conf configuration for unbound
#     - renamed *-default.conf to *.conf.template
#     - removed deleting of comment line from conf templates
#   - 2020-01-26: created

DOMAIN_NAME="int.x4242.net"

IP4_ADDR="10.66.66.1"
IP4_SUBNET="10.66.66.0/24"
IP4_DHCP_RANGE="10.66.66.100 - 10.66.66.254"
IP4_DHCP_DNS_SERVER="10.66.66.1"

IP6_SUBNET="tbd"
IP6_DHCP_PREFIX="tbd"
IP6_DHCP_DNS_SERVER="tbd"


##########################################
# Create 'unbound' config file
# ----------------------------------------
# Copy the templates and replace contents with given configuration (see above).
##########################################
cp ./unbound/unbound.conf.template ./unbound/unbound.conf
sed -i "s/<IP4_ADDR>/${IP4_ADDR}/g" ./unbound/unbound.conf
# use - as sed delimeter as / in CIDR notation will cause trouble
sed -i "s-<IP4_SUBNET>-${IP4_SUBNET}-g" ./unbound/unbound.conf
cp ./unbound/local-zone.conf.template ./unbound/local-zone.conf
sed -i "s/<DOMAIN_NAME>/${DOMAIN_NAME}/g" ./unbound/local-zone.conf
sed -i "s/<HOSTNAME>/$(hostname)/g" ./unbound/local-zone.conf
sed -i "s/<IP4_ADDR>/${IP4_ADDR}/g" ./unbound/local-zone.conf

##########################################
# Create 'kea' config file
# ----------------------------------------
# Copy the templates and replace contents with given configuration (see above).
##########################################
cp ./kea/dhcpv4.conf.template ./kea/dhcpv4.conf
sed -i "s-<IP4_ADDR>-${IP4_ADDR}-g" ./kea/dhcpv4.conf
sed -i "s-<IP4_SUBNET>-${IP4_SUBNET}-g" ./kea/dhcpv4.conf
sed -i "s/<IP4_DHCP_RANGE>/${IP4_DHCP_RANGE}/g" ./kea/dhcpv4.conf
sed -i "s/<IP4_DHCP_DNS_SERVER>/${IP4_DHCP_DNS_SERVER}/g" ./kea/dhcpv4.conf
sed -i "s/<DOMAIN_NAME>/${DOMAIN_NAME}/g" ./kea/dhcpv4.conf
