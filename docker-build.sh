#!/bin/sh
#
# ------------------------------------------------------------------------------
# Description
# ------------------------------------------------------------------------------
# Builds the necessary docker images to be used in docker-compose file.
#
# ------------------------------------------------------------------------------
# Change History
# ------------------------------------------------------------------------------
# lastmod: 2020-06-28T13:37:18+02:00
# changelog:
#   - 2020-06-28: removed openvpn
#   - 2020-05-31: added openvpn; renamed dns,dhcp,ntp
#   - 2020-03-29: removed sudo, changed header
#   - 2020-03-27: added sudo
#   - 2020-21-29: created

docker build --file ./unbound/Dockerfile ./unbound/ \
             --tag 0x4242/solomon-unbound:latest

docker build --file ./kea/Dockerfile ./kea/ \
             --tag 0x4242/solomon-kea:latest

docker build --file ./openntpd/Dockerfile ./openntpd/ \
             --tag 0x4242/solomon-openntpd:latest

docker build --file ./mosquitto/Dockerfile ./mosquitto/ \
             --tag 0x4242/solomon-mosquitto:latest

docker build --file ./node-red/Dockerfile ./node-red \
             --tag 0x4242/solomon-node-red:latest
