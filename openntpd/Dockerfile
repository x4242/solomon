# ------------------------------------------------------------------------------
# Description
# ------------------------------------------------------------------------------
# Create an image with OpenNTPD
#
# OpenNTPD is configured using ntpd.conf which need to be bind-mounted to
# /etc/ntpd.conf.
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
# lastmod: 2020-06-28T21:36:57+02:00
# changelog:
#   - 2020-06-28: addes health check
#   - 2020-06-20: -s flag for faster clock sync; simplified apk add
#   - 2020-05-31: update to alpine 3.12
#   - 2020-05-21:
#     - update to alpine 3.11.6
#     - workaround for openntpd ssl issue (mkdir -m ...), see
#       https://tech.goglides.com/2020/03/09/manage-ntp-using-kubernetes/ for
#       details
#   - 2020-03-27:
#     - removed copy of config file, needs be be bind-mounted now
#     - changed header
#   - 2020-02-23: created

ARG alpine_version=3.12
FROM alpine:$alpine_version

LABEL maintainer="0x4242"

ARG openntpd_version=6.2_p3-r3
ARG tzdata_version=2020a-r0
RUN apk add --no-cache \
    openntpd="${openntpd_version}" \
    tzdata="${tzdata_version}"

RUN mkdir -m 1777 /var/empty/tmp

# TODO: remove drift file, seems to help with sync issue #1

# NTP server port
EXPOSE 123/udp

# health check: ntpctl returns 0 also when clock is unsynced
HEALTHCHECK --interval=1m --timeout=3s --retries=3 \
    CMD ntpctl -s status

ENTRYPOINT ["/usr/sbin/ntpd"]
CMD ["-d", "-s", "-f", "/etc/ntpd.conf"]
