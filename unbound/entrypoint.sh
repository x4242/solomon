#!/bin/sh
set -e
crond -L /dev/stdout
exec "$@"
