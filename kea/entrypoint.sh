#!/bin/sh

set -e
./etc/periodic/15min/update.sh
exec "$@"
