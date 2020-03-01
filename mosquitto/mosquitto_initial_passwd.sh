#!/bin/sh
#
# ----------------------------------------
# Description
# ----------------------------------------
# Generate random initial user credentials for mosquitto MQTT broker.
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
# lastmod: 2020-02-29T15:35:16+01:00
# changelog:
#   - 2020-02-29: created

PASSWD_FILE="/mosquitto/config/passwd"
INITAL_USER="mqttclient"
INITAL_PASSWD=$(head -3 /dev/urandom | tr -cd '[:alnum:]' | cut -c -32)

echo "Initial MQTT client credentials:"
echo "--------------------------------"
echo "username: ${INITAL_USER}"
echo "password: ${INITAL_PASSWD}"
echo ""
echo "Encrypted credentials are stored in ${PASSWD_FILE}. Use 'mosquitto_passwd' or \
'mosquitto_passwd.sh' to change."

echo "${INITAL_USER}:${INITAL_PASSWD}" > $PASSWD_FILE
mosquitto_passwd -U ${PASSWD_FILE}
