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
# lastmod: 2020-03-30T02:30:46+02:00
# changelog:
#   - 2020-03-30: changed header
#   - 2020-02-29: created

set -e

if [ ! -f "/mosquitto/config/passwd" ]; then
  /usr/local/sbin/mosquitto_initial_passwd.sh
fi

exec "$@"
