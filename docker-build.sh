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
# lastmod: 2020-03-29T20:36:09+02:00
# changelog:
#   - 2020-03-29: removed sudo, changed header
#   - 2020-03-27: added sudo
#   - 2020-21-29: created

docker build --file ./unbound/Dockerfile ./unbound/ \
             --tag 0x4242/solomon-dns:latest

docker build --file ./kea/Dockerfile ./kea/ \
             --tag 0x4242/solomon-dhcp:latest

docker build --file ./openntpd/Dockerfile ./openntpd/ \
             --tag 0x4242/solomon-ntp:latest

docker build --file ./mosquitto/Dockerfile ./mosquitto/ \
             --tag 0x4242/solomon-mosquitto:latest

docker build --file ./node-red/Dockerfile ./node-red \
             --tag 0x4242/solomon-node-red:latest
