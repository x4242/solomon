#!/bin/sh
#
# ------------------------------------------
# Description
# ------------------------------------------
# tbd
#
# ------------------------------------------
# Change History
# ------------------------------------------
# lastmod: 2020-01-25T18:28:06+01:00
# changelog:
#   - 2020-01-25: changed to #!/bin/sh for compatibility
#   - 2020-01-12: created

wget https://www.internic.net/domain/named.root -O /var/lib/unbound/root.hints
