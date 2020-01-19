FROM debian:buster

MAINTAINER 0x4242

RUN apt-get update && \
    apt-get install -y \
      unbound \
      wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    wget https://www.internic.net/domain/named.root -O /var/lib/unbound/root.hints

COPY update.sh /var/lib/unbound/
RUN chmod +x /var/lib/unbound/update.sh && \
    chown unbound:unbound /var/lib/unbound/update.sh

COPY unbound.conf /etc/unbound/unbound.conf

RUN unbound-anchor -v || true && \
    chown unbound:unbound /var/lib/unbound/root.key && \
    touch /var/log/unbound.log && \
    chown unbound:unbound /var/log/unbound.log

EXPOSE 53

CMD ["unbound", "-d"]
