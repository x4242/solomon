# ------------------------------------------------------------------------------
# Description
# ------------------------------------------------------------------------------
# Creates an image with 'unbound' DNS server based on Alpine Linux base image.
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
# lastmod: 2020-03-27T15:02:36+01:00
# changelog:
#   - 2020-03-27:
#     - removed copying of config files, they now need to be bind mounted
#     - modifed header
#   - 2020-02-23: added tzdata to set timezone
#   - 2020-01-29: COPY local-zone.conf
#   - 2020-01-23: initial working version

ARG alpine_version=3.11.3
FROM alpine:$alpine_version

LABEL maintainer="0x4242"

ARG unbound_version=1.9.6-r0
ARG tzdata_version=2019c-r0
RUN apk add --no-cache unbound="${unbound_version}" && \
    apk add --no-cache tzdata="${tzdata_version}" && \
    wget https://www.internic.net/domain/named.root -O /etc/unbound/root.hints

#COPY update.sh /var/lib/unbound/
#RUN chmod +x /var/lib/unbound/update.sh && \
#    chown unbound:unbound /var/lib/unbound/update.sh

# update root trust anchor, and create lo file
RUN unbound-anchor -v || true && \
    touch /var/log/unbound.log

# expose DNS port
EXPOSE 53
EXPOSE 53/udp

ENTRYPOINT ["/usr/sbin/unbound"]
CMD ["-d"]
