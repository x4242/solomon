#!/bin/sh

set -e

printf "Running Alpine upgrade.\n"
apk update
apk upgrade
rm -rf /var/cache/apk/*
printf "Alpine upgrade done.\n"

crond

exec "$@"
