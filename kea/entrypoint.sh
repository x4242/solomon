#!/bin/sh
#
# ------------------------------------------------------------------------------
# Description
# ------------------------------------------------------------------------------
# Docker entrypoint script performing Alpine linux system upgrade on container
# start before executing CMD[] from Dockerfile.
#
# ------------------------------------------------------------------------------
# Change History
# ------------------------------------------------------------------------------
# lastmod: 2020-09-27T17:48:09+02:00
# changelog:
#   - 2020-09-27: created

set -e

printf "Running Alpine upgrade.\n"
apk update
apk upgrade
rm -rf /var/cache/apk/*
printf "Alpine upgrade done.\n"

exec "$@"
