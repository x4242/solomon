#!/bin/sh
#
# ------------------------------------------------------------------------------
# Description
# ------------------------------------------------------------------------------
# Starts 'kea-dhcp4' and 'kea-ctrl-agent'
#
# ------------------------------------------------------------------------------
# Change History
# ------------------------------------------------------------------------------
# lastmod: 2020-03-30T02:28:29+02:00
# changelog:
#   - 2020-02-29: created

/usr/sbin/kea-ctrl-agent -c /etc/kea/kea-ctrl-agent.conf &
/usr/sbin/kea-dhcp4 -c /etc/kea/dhcpv4.conf
