#!/bin/sh

set -e
./etc/periodic/weekly/update.sh
exec "$@"
