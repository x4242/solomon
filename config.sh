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
# lastmod: 2020-01-26T13:44:39+01:00
# changelog:
#   - 2020-01-26: created

IP4_ADDR="10.66.66.1"
IP4_SUBNET="10.66.66.0/24"
IP4_DHCP_RANGE="10.66.66.100 - 10.66.66.254"
IP4_DHCP_DNS_SERVER="10.66.66.1"
IP4_DHCP_DOMAIN_NAME="int.x4242.net"

IP6_SUBNET="tbd"
IP6_DHCP_PREFIX="tbd"
IP6_DHCP_DNS_SERVER="tbd"

# use - as sed delimeter as / in IP will cause trouble
grep -o '^[^#]*' ./unbound/unbound-default.conf > ./unbound/unbound.conf
sed -i "s/<IP4_ADDR>/${IP4_ADDR}/g" ./unbound/unbound.conf
sed -i "s-<IP4_SUBNET>-${IP4_SUBNET}-g" ./unbound/unbound.conf

grep -o '^[^//]*' ./kea/dhcpv4-default.conf > ./kea/dhcpv4.conf
sed -i "s-<IP4_SUBNET>-${IP4_SUBNET}-g" ./kea/dhcpv4.conf
sed -i "s/<IP4_DHCP_RANGE>/${IP4_DHCP_RANGE}/g" ./kea/dhcpv4.conf
sed -i "s/<IP4_DHCP_DNS_SERVER>/${IP4_DHCP_DNS_SERVER}/g" ./kea/dhcpv4.conf
sed -i "s/<IP4_DHCP_DOMAIN_NAME>/${IP4_DHCP_DOMAIN_NAME}/g" ./kea/dhcpv4.conf
