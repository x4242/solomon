#!/bin/sh
#
# ----------------------------------------
# Description
# ----------------------------------------
# Builds the necessary images to be used for 'docker-compose'.
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
# lastmod: 2020-03-27T15:05:26+01:00
# changelog:
#   - 2020-03-27: added sudo
#   - 2020-21-29: created

sudo docker build --tag 0x4242/solomon-dns:latest --file ./unbound/Dockerfile ./unbound/
sudo docker build --tag 0x4242/solomon-dhcp:latest --file ./kea/Dockerfile ./kea/
sudo docker build --tag 0x4242/solomon-ntp:latest --file ./openntpd/Dockerfile ./openntpd/
sudo docker build --tag 0x4242/solomon-mosquitto:latest --file ./mosquitto/Dockerfile ./mosquitto/
sudo docker build --tag 0x4242/solomon-node-red:latest --file ./node-red/Dockerfile ./node-red
