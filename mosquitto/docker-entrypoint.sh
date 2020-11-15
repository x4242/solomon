#!/bin/sh
#
# ------------------------------------------------------------------------------
# Description
# ------------------------------------------------------------------------------
# tbd
#
# ------------------------------------------------------------------------------
# Change History
# ------------------------------------------------------------------------------
# lastmod: 2020-09-27T17:46:28+02:00
# changelog:
#   - 2020-09-27: auto system upgrade
#   - 2020-03-30: changed header
#   - 2020-02-29: created

set -e

printf "Running Alpine upgrade.\n"
apk update
apk upgrade
rm -rf /var/cache/apk/*
printf "Alpine upgrade done.\n"

if [ ! -f "/mosquitto/config/passwd" ]; then
  /usr/local/sbin/mosquitto_initial_passwd.sh
fi

exec "$@"
