#!/usr/bin/env bash

# Description:
# ------------
# tbd
#
# lastmod: 2020-01-12T13:53:27+01:00
# Change History:
# ---------------
#   - 2020-01-12: created

wget https://www.internic.net/domain/named.root -O /var/lib/unbound/root.hints
