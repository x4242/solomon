# ----------------------------------------
# Description
# ----------------------------------------
# Creates an image with 'unbound' DNS server based on Alpine Linux base image.
#
# ----------------------------------------
# Change History
# ----------------------------------------
# lastmod: 2020-01-23T16:18:33+01:00
# changelog:
#   - 2020-01-23: initial working version

ARG alpine_version=3.11.3
FROM alpine:$alpine_version

LABEL maintainer="0x4242"

ARG unbound_version=1.9.6-r0
RUN apk add --no-cache unbound="${unbound_version}" && \
    wget https://www.internic.net/domain/named.root -O /etc/unbound/root.hints

#COPY update.sh /var/lib/unbound/
#RUN chmod +x /var/lib/unbound/update.sh && \
#    chown unbound:unbound /var/lib/unbound/update.sh

# copy unbound.conf into container
COPY unbound.conf /etc/unbound/unbound.conf

# update root trust anchor, and create lo file
RUN unbound-anchor -v || true && \
    touch /var/log/unbound.log

# expose DNS port
EXPOSE 53
EXPOSE 53/udp

ENTRYPOINT ["/usr/sbin/unbound"]
CMD ["-d"]
