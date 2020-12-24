#!/bin/sh
#
# ------------------------------------------------------------------------------
# Description
# ------------------------------------------------------------------------------
# Create service config files from templates.
#
# ------------------------------------------------------------------------------
# Change History
# ------------------------------------------------------------------------------
# lastmod: 2020-08-01T20:40:16+02:00
# changelog:
#   - 2020-08-01: renamed config.sh
#   - 2020-07-11: added TLS certificate path conf for traefik in compose file
#   - 2020-05-08: added timezone configuration
#   - 2020-05-03: added DNS blacklist generations
#   - 2020-03-27:
#     - made 'sed -i' POSIX-compliant
#     - changed to new header template
#   - 2020-02-23:
#     - configuration of DHCP listeneing interface
#     - added NTP server config for 'kea'
#   - 2020-01-29:
#     - local-zone.conf configuration for unbound
#     - renamed *-default.conf to *.conf.template
#     - removed deleting of comment line from conf templates
#   - 2020-01-26: created

# ------------------------------------------------------------------------------
# Config Parameters
# ------------------------------------------------------------------------------
# TIMEZONE: The timezone.
# DOMAIN_NAME: The internal domain name which is used for DNS and DHCP servcies.
# DHCP_INTERFACE: The interface name on which the DHCP server is listening.
# IP4_ADDR: The IPv4 address of the host on the internal network. This address
#   is used for all services.
# IP4_SUBNET: IPv4 subnet used in DHCP servcie configuration.
# IP4_DHCP_RANGE: The IPv4 DHCP adress range. Must comply with subnet
# IP4_DHCP_DNS_SERVER: The DNS server's IP as advertised by the DHCP service.
# IP4_NTP_SERVER: The NTP server's IP as advertised by the DHCPP service

TIMEZONE="Europe\Berlin"
DOMAIN_NAME="int.0x4242.net"
DHCP_INTERFACE="enp6s0"
IP4_ADDR="10.66.66.1"
IP4_SUBNET="10.66.66.0/24"
IP4_DHCP_RANGE="10.66.66.100 - 10.66.66.254"
IP4_DHCP_DNS_SERVER="10.66.66.1"
IP4_NTP_SERVER="10.66.66.1"
TRAEFIK_KEY_PATH="domain_cert.key"
TRAEFIK_CRT_PATH="domain_cert.crt"

# ------------------------------------------------------------------------------
# Create docker-compose.yml from template
# ------------------------------------------------------------------------------
cp ./docker-compose.yml.template ./docker-compose.yml
sed -i.tmp "s/<HOST_FQDN>/$(hostname).${DOMAIN_NAME}/g" ./docker-compose.yml
sed -i.tmp "s-<TIMEZONE>-${TIMEZONE}-g" ./docker-compose.yml
sed -i.tmp "s-<TRAEFIK_KEY_PATH>-${TRAEFIK_KEY_PATH}-g" ./docker-compose.yml
sed -i.tmp "s-<TRAEFIK_CRT_PATH>-${TRAEFIK_CRT_PATH}-g" ./docker-compose.yml

MQTT_PASSWD=$(head -3 /dev/urandom | tr -cd '[:alnum:]' | cut -c -32)
INFLUXDB_ADMIN_PASSWD=$(head -3 /dev/urandom | tr -cd '[:alnum:]' | cut -c -32)
sed -i.tmp "s-<INFLUXDB_ADMIN_PASSWD>-${INFLUXDB_ADMIN_PASSWD}-g" ./docker-compose.yml
INFLUXDB_USER_PASSWD=$(head -3 /dev/urandom | tr -cd '[:alnum:]' | cut -c -32)
sed -i.tmp "s-<INFLUXDB_USER_PASSWD>-${INFLUXDB_USER_PASSWD}-g" ./docker-compose.yml

printf "InfluxDB admin -> admin:%s\n" "$INFLUXDB_ADMIN_PASSWD"
printf "InfluxDB user -> user:%s\n" "$INFLUXDB_USER_PASSWD"
printf "Mosquitto MQTT client -> mqttclient:%s\n" "$MQTT_PASSWD"

rm ./docker-compose.yml.tmp

# ------------------------------------------------------------------------------
# Create 'unbound' config file from template
# ------------------------------------------------------------------------------
cp ./unbound/unbound.conf.template ./unbound/unbound.conf
sed -i.tmp "s/<IP4_ADDR>/${IP4_ADDR}/g" ./unbound/unbound.conf
# use - as sed delimeter as / in CIDR notation will cause trouble
sed -i.tmp "s-<IP4_SUBNET>-${IP4_SUBNET}-g" ./unbound/unbound.conf
rm ./unbound/unbound.conf.tmp

cp ./unbound/local-zone.conf.template ./unbound/local-zone.conf
sed -i.tmp "s/<DOMAIN_NAME>/${DOMAIN_NAME}/g" ./unbound/local-zone.conf
sed -i.tmp "s/<HOSTNAME>/$(hostname)/g" ./unbound/local-zone.conf
sed -i.tmp "s/<IP4_ADDR>/${IP4_ADDR}/g" ./unbound/local-zone.conf
rm ./unbound/local-zone.conf.tmp

# TODO: replace ./unbound/generate_blacklist.sh with Python script

# ------------------------------------------------------------------------------
# Create 'kea' config file from template
# ------------------------------------------------------------------------------
cp ./kea/dhcpv4.conf.template ./kea/dhcpv4.conf
sed -i.tmp "s-<DHCP_INTERFACE>-${DHCP_INTERFACE}-g" ./kea/dhcpv4.conf
sed -i.tmp "s-<IP4_ADDR>-${IP4_ADDR}-g" ./kea/dhcpv4.conf
sed -i.tmp "s-<IP4_SUBNET>-${IP4_SUBNET}-g" ./kea/dhcpv4.conf
sed -i.tmp "s/<IP4_DHCP_RANGE>/${IP4_DHCP_RANGE}/g" ./kea/dhcpv4.conf
sed -i.tmp "s/<IP4_DHCP_DNS_SERVER>/${IP4_DHCP_DNS_SERVER}/g" ./kea/dhcpv4.conf
sed -i.tmp "s/<IP4_NTP_SERVER>/${IP4_NTP_SERVER}/g" ./kea/dhcpv4.conf
sed -i.tmp "s/<DOMAIN_NAME>/${DOMAIN_NAME}/g" ./kea/dhcpv4.conf
rm ./kea/dhcpv4.conf.tmp
