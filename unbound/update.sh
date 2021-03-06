#!/bin/sh

printf "Running Alpine upgrade.\n"
apk update
apk upgrade
rm -rf /var/cache/apk/*
printf "Alpine upgrade done.\n"

wget https://www.internic.net/domain/named.root -O /etc/unbound/root.hints
unbound-anchor -v

generate_blacklist.py
unbound-checkconf /tmp/blacklist.conf.tmp
if [ $? -eq 0 ]; then
  cat /tmp/blacklist.conf.tmp > /etc/unbound/blacklist.conf
  unbound-control reload
fi
rm /tmp/blacklist.conf.tmp
