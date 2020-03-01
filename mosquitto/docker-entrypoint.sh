#!/bin/sh
set -e

if [ ! -f "/mosquitto/config/passwd" ]; then
  /usr/local/sbin/mosquitto_initial_passwd.sh
fi

exec "$@"
