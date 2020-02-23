# ----------------------------------------
# Description
# ----------------------------------------
# Create an image with OpenNTPD
#
# OpenNTPD is configured using ntpd.conf.
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
# lastmod: 2020-02-23T16:58:15+01:00
# changelog:
#   - 2020-02-23: created

ARG alpine_version=3.11.3
FROM alpine:$alpine_version

LABEL maintainer="0x4242"

ARG openntpd_version=6.2_p3-r3
ARG tzdata_version=2019c-r0
RUN apk add --no-cache openntpd="${openntpd_version}" && \
    apk add --no-cache tzdata="${tzdata_version}"

COPY ntpd.conf /etc/ntpd.conf

# NTP server port
EXPOSE 123/udp

ENTRYPOINT ["/usr/sbin/ntpd"]
CMD ["-d", "-f", "/etc/ntpd.conf"]
