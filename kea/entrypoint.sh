#!/bin/sh

set -e

apk update
apk upgrade
rm -rf /var/cache/apk/*

exec "$@"
