#!/bin/sh

# ------------------------------------------------------------------------------
# Change History
# ------------------------------------------------------------------------------
# lastmod: 2021-07-11T11:23:33+02:00
# changelog:
#   - 2021-07-11: copy over permission drop from offical image
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

user="$(id -u)"
if [ "$user" = '0' ]; then
	[ -d "/mosquitto" ] && chown -R mosquitto:mosquitto /mosquitto || true
fi

exec "$@"
