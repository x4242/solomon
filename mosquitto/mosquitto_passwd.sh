#!/bin/sh
#
# ----------------------------------------
# Description
# ----------------------------------------
# Wrapper script to configure mosquitto MQTT broker username/passwords.
#
# First checks if password file already exists. If so and append/change is
# confirmed, '-b' will be passed to 'mosquitto_passwd' thus either adding a new
# user or if user already exists will set a new password for that user.
# If password file does not exists or is to be overwritten a plain text file
# in the format <USERNAME>:<PASSWORD> is created. '-U' is then passed to
# 'mosquitto_passwd' encrypting the plain text password in the file.
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
# Twitter: @0x4242 (https://twitter.com/0x4242)
# Github: x4242 (https://github.com/x4242)
#
# ----------------------------------------
# Change History
# ----------------------------------------
# lastmod: 2020-02-21T19:58:59+01:00
# changelog:
#   - 2020-02-21: created

MOSQUITTO_PASSWD_FILE="/mosquitto/config/passwd"
MOSQUITTO_PASSWD_ARG="-U"

# check if password file already exists; ask to overwrite or change/append
if [ -f $MOSQUITTO_PASSWD_FILE ]; then
  printf "Mosquitto password file '%s' already exists.\n" "${MOSQUITTO_PASSWD_FILE}"
  printf "Append/change (if no, file will be overwritten)? (y/n) "
  read -r yes_no
  case $yes_no in
    [Yy]* )
      MOSQUITTO_PASSWD_ARG="-b"
      ;;
  esac
fi

# enter username
printf "Enter username for MQTT authentication: "
read -r MQTT_USER

# enter password; stty -echo/echo to be POSIX compliant
printf "Enter password for '%s': " "${MQTT_USER}"
stty -echo
read -r MQTT_PASSWD
stty echo

# reenter password
printf "\nRenter password for '%s': " "${MQTT_USER}"
stty -echo
read -r MQTT_PASSWD2
stty echo

# check is password match
if [ $MQTT_PASSWD != $MQTT_PASSWD2 ]; then
  printf "\nPasswords do not match -> aborting\n"
  exit 1
fi


printf "\nWriting to '%s'\n" "${MOSQUITTO_PASSWD_FILE}"

# write to plain text file and then encrypt or append/change with
# 'mosquitto_passwd'
if [ $MOSQUITTO_PASSWD_ARG = "-U" ]; then
  echo "${MQTT_USER}:${MQTT_PASSWD}" > $MOSQUITTO_PASSWD_FILE
  mosquitto_passwd $MOSQUITTO_PASSWD_ARG $MOSQUITTO_PASSWD_FILE
else
  mosquitto_passwd $MOSQUITTO_PASSWD_ARG $MOSQUITTO_PASSWD_FILE $MQTT_USER $MQTT_PASSWD
fi
