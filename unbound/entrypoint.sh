#!/bin/sh
set -e
if [ ! -f "/etc/unbound/blacklist.conf" ]; then
  printf "'/etc/unbound/blacklist.conf' does not exists. Either wait for cron \
job or run 'generate_blacklist.py' or 'update.sh' manually.\n"
fi
exec "$@"
