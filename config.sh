#!/bin/sh
#
# ----------------------------------------
# Description
# ----------------------------------------
# tbd
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

# use - as sed delimeter as / in IP will cause trouble
cp ./unbound/unbound.conf.template ./unbound/unbound.conf
sed -i "s/<IP4_ADDR>/${IP4_ADDR}/g" ./unbound/unbound.conf
sed -i "s-<IP4_SUBNET>-${IP4_SUBNET}-g" ./unbound/unbound.conf
cp ./unbound/local-zone.conf.template ./unbound/local-zone.conf
sed -i "s/<DOMAIN_NAME>/${DOMAIN_NAME}/g" ./unbound/local-zone.conf
sed -i "s/<HOSTNAME>/$(hostname)/g" ./unbound/local-zone.conf
sed -i "s/<IP4_ADDR>/${IP4_ADDR}/g" ./unbound/local-zone.conf

cp ./kea/dhcpv4.conf.template ./kea/dhcpv4.conf
sed -i "s-<IP4_ADDR>-${IP4_ADDR}-g" ./kea/dhcpv4.conf
sed -i "s-<IP4_SUBNET>-${IP4_SUBNET}-g" ./kea/dhcpv4.conf
sed -i "s/<IP4_DHCP_RANGE>/${IP4_DHCP_RANGE}/g" ./kea/dhcpv4.conf
sed -i "s/<IP4_DHCP_DNS_SERVER>/${IP4_DHCP_DNS_SERVER}/g" ./kea/dhcpv4.conf
sed -i "s/<DOMAIN_NAME>/${DOMAIN_NAME}/g" ./kea/dhcpv4.conf
