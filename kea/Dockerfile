# ------------------------------------------------------------------------------
# Description
# ------------------------------------------------------------------------------
# Creates an image with 'kea' DHCP server based on Alpine Linux base image.
#
# Configuration file for DHCPv4 needs to be bind-mounted to /etc/kea/dhcpv4.conf.
#
# ------------------------------------------------------------------------------
# Social
# ------------------------------------------------------------------------------
#              __           __ __       ___    __ __       ___
#            /'__`\        /\ \\ \    /'___`\ /\ \\ \    /'___`\
#           /\ \/\ \  __  _\ \ \\ \  /\_\ /\ \\ \ \\ \  /\_\ /\ \
#           \ \ \ \ \/\ \/'\\ \ \\ \_\/_/// /__\ \ \\ \_\/_/// /__
#            \ \ \_\ \/>  </ \ \__ ,__\ // /_\ \\ \__ ,__\ // /_\ \
#             \ \____//\_/\_\ \/_/\_\_//\______/ \/_/\_\_//\______/
#              \/___/ \//\/_/    \/_/  \/_____/     \/_/  \/_____/
#
#     Web: http://0x4242.net | Twitter: @0x4242 <https://twitter.com/0x4242>
#                 GitHub: x4242 <https://github.com/x4242>
#
# ------------------------------------------------------------------------------
# Change History
# ------------------------------------------------------------------------------
# lastmod: 2020-11-16T19:44:48+01:00
# changelog:
#   - 2020-11-16: update script
#   - 2020-09-27: changed entrypoint to custom script
#   - 2020-06-20: simplified apk add
#   - 2020-05-21: update to aplpine 3.12
#   - 2020-05-21: update to alpine 3.11.6
#   - 2020-03-30: Switch to supervisord to run kea-dhcp4 and kea-ctrl-agent in
#     parllel. Entrypoint script didn't work.
#   - 2020-03-29:
#     - added socat & curl for interacting with kea control socket
#     - added kea-hook-lease-cmds, kea-ctrl-agent
#     - changed docker entrypoint to run script to start kea & kea-ctrl-agent
#   - 2020-03-27:
#     - removed copying ot config file, needs to be bind-mounted now
#     - changed header
#   - 2020-02-23: added tzdata to set timezone
#   - 2020-01-29: fix kea version
#   - 2020-01-23: initial working version

ARG alpine_version=3.12
FROM alpine:$alpine_version

LABEL maintainer="0x4242"

RUN apk add --no-cache \
    kea \
    kea-ctrl-agent \
    kea-hook-lease-cmds \
    tzdata \
    supervisor && \
    mkdir /run/kea

# entrypoint and update script
COPY entrypoint.sh /
COPY update.sh /etc/periodic/15min

# DHCPv4 server port
EXPOSE 67/udp

# DHCPv6 server port
EXPOSE 547/udp

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
