# ----------------------------------------
# Description
# ----------------------------------------
# Creates an image with 'kea' DHCP server based on Alpine Linux base image.
#
# ----------------------------------------
# Social
# ----------------------------------------
# Web: http://0x4242.net
# Twitter: @0x4242 <https://twitter.com/0x4242>
# GitHub: x4242 <https://github.com/x4242>
#
# ----------------------------------------
# Change History
# ----------------------------------------
# lastmod: 2020-02-21T20:03:21+01:00
# changelog:
#   - 2020-01-29: fix kea version
#   - 2020-01-23: initial working version

ARG alpine_version=3.11.3
FROM alpine:$alpine_version

LABEL maintainer="0x4242"

ARG kea_version=1.7.3-r3
RUN apk add --no-cache kea="${kea_version}" && \
    mkdir /run/kea

COPY dhcpv4.conf /etc/kea/dhcpv4.conf

# DHCPv4 server port
EXPOSE 67/udp

# DHCPv6 server port
EXPOSE 547/udp

ENTRYPOINT ["/usr/sbin/kea-dhcp4"]
CMD ["-c", "/etc/kea/dhcpv4.conf"]
