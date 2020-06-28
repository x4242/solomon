# ------------------------------------------------------------------------------
# Description
# ------------------------------------------------------------------------------
# tbd
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
# lastmod: 2020-06-28T12:19:22+02:00
# changelog:
#   - 2020-06-28: created

ARG alpine_version=3.12
FROM alpine:$alpine_version

LABEL maintainer="0x4242"

ARG wireguard_version=1.10.1-r0
ARG tzdata_version=2020a-r0

RUN apk add --no-cache \
    unbound="${unbound_version}" \
    tzdata="${tzdata_version}" && \
    wget https://www.internic.net/domain/named.root -O /etc/unbound/root.hints

# TODO: add DNS blacklist update script + cronjob
#COPY update.sh /var/lib/unbound/
#RUN chmod +x /var/lib/unbound/update.sh && \
#    chown unbound:unbound /var/lib/unbound/update.sh

# TODO: add initial generation of DNS blacklist; should be stored on volume?

# update root trust anchor, and create lo file
RUN unbound-anchor -v || true && \
    touch /var/log/unbound.log

# expose DNS port
EXPOSE 53
EXPOSE 53/udp

ENTRYPOINT ["/usr/sbin/unbound"]
CMD ["-d"]
