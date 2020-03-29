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
# lastmod: 2020-03-27T15:08:04+01:00
# changelog:
#   - 2020-03-27:
#     - removed copy of config file, needs be be bind-mounted now
#     - changed header
#   - 2020-02-23: created

ARG alpine_version=3.11.3
FROM alpine:$alpine_version

LABEL maintainer="0x4242"

ARG openntpd_version=6.2_p3-r3
ARG tzdata_version=2019c-r0
RUN apk add --no-cache openntpd="${openntpd_version}" && \
    apk add --no-cache tzdata="${tzdata_version}"

# NTP server port
EXPOSE 123/udp

ENTRYPOINT ["/usr/sbin/ntpd"]
CMD ["-d", "-f", "/etc/ntpd.conf"]
