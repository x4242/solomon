# ------------------------------------------------------------------------------
# Description
# ------------------------------------------------------------------------------
# Creates an image with Eclipse Mosquitto MQTT broker
# See https://mosquitto.org/ for details.
#
# This is a slightly modifed version of the official Dockerfile from the
# Eclipse Mosquitto project found under
# https://github.com/eclipse/mosquitto/tree/master/docker.
# The modifications are:
#   - one volume instead of two
#   - inital password generation script (moqsuitto_initial_passwd.sh)
#   - wrapper script for mosquitto_passwd (mosquitto_passwd.sh)
#   - entrypoint script which generates a password if no password file is found
#   - tzdata package for timezone configuration
#
# The images uses the config file found in /mosquitto/config/mosquitto.conf. If
# a custom configuration is preffered this has to be mounted accordingly.
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
# lastmod: 2020-08-01T21:32:30+02:00
# changelog:
#   - 2021-07-11: update to mosquitto 2.0.11 (c&p from offical docker file) and
#       alpine 3.14
#   - 2020-08-01:
#       - removed copying of config file, instead use mound in compose file
#       - update to mosquitto 1.6.10 but chage to openssl instead of libressl as
#         it did not work
#   - 2020-06-20: re-added tzdata
#   - 2020-05-31: update to mosquitto 1.6.9
#   - 2020-03-27: changed header
#   - 2020-03-01: use modified version of official image Dockerfile:
#       - adapted number of volume (just one)
#       - added inital password generation script
#   - 2020-02-23:
#       - added tzdata to set timezone
#       - set mosquitto docker version to 1.6.8
#   - 2020-02-21: add mosquitto_passwd.sh
#   - 2020-02-09: created

ARG alpine_version=3.14
FROM alpine:$alpine_version

ENV VERSION=2.0.11 \
    DOWNLOAD_SHA256=7b36a7198bce85cf31b132f5c6ee36dcf5dadf86fb768501eb1e11ce95d4f78a \
    GPG_KEYS=A0D6EEA1DCAE49A635A3B2F0779B22DFB3E717B7 \
    LWS_VERSION=4.2.0 \
    LWS_SHA256=a57e9a4765dbcd4d880feba8089b43ed69995eaf10d5d61a07981d9ddd975f40 \
    CJSON_VERSION=1.7.14 \
    CJSON_SHA256=fb50a663eefdc76bafa80c82bc045af13b1363e8f45cec8b442007aef6a41343

RUN set -x && \
    apk --no-cache add --virtual build-deps \
        build-base \
        cmake \
        gnupg \
        linux-headers \
        openssl-dev \
        util-linux-dev && \
    wget https://github.com/warmcat/libwebsockets/archive/v${LWS_VERSION}.tar.gz -O /tmp/lws.tar.gz && \
    echo "$LWS_SHA256  /tmp/lws.tar.gz" | sha256sum -c - && \
    mkdir -p /build/lws && \
    tar --strip=1 -xf /tmp/lws.tar.gz -C /build/lws && \
    rm /tmp/lws.tar.gz && \
    cd /build/lws && \
    cmake . \
        -DCMAKE_BUILD_TYPE=MinSizeRel \
        -DCMAKE_INSTALL_PREFIX=/usr \
        -DDISABLE_WERROR=ON \
        -DLWS_IPV6=ON \
        -DLWS_WITHOUT_BUILTIN_GETIFADDRS=ON \
        -DLWS_WITHOUT_CLIENT=ON \
        -DLWS_WITHOUT_EXTENSIONS=ON \
        -DLWS_WITHOUT_TESTAPPS=ON \
        -DLWS_WITH_EXTERNAL_POLL=ON \
        -DLWS_WITH_SHARED=OFF \
        -DLWS_WITH_ZIP_FOPS=OFF \
        -DLWS_WITH_ZLIB=OFF && \
    make -j "$(nproc)" && \
    rm -rf /root/.cmake && \
    wget https://github.com/DaveGamble/cJSON/archive/v${CJSON_VERSION}.tar.gz -O /tmp/cjson.tar.gz && \
    echo "$CJSON_SHA256  /tmp/cjson.tar.gz" | sha256sum -c - && \
    mkdir -p /build/cjson && \
    tar --strip=1 -xf /tmp/cjson.tar.gz -C /build/cjson && \
    rm /tmp/cjson.tar.gz && \
    cd /build/cjson && \
    cmake . \
        -DCMAKE_BUILD_TYPE=MinSizeRel \
        -DBUILD_SHARED_AND_STATIC_LIBS=OFF \
        -DBUILD_SHARED_LIBS=OFF \
        -DCJSON_BUILD_SHARED_LIBS=OFF \
        -DCJSON_OVERRIDE_BUILD_SHARED_LIBS=OFF \
        -DCMAKE_INSTALL_PREFIX=/usr && \
    make -j "$(nproc)" && \
    rm -rf /root/.cmake && \
    wget https://mosquitto.org/files/source/mosquitto-${VERSION}.tar.gz -O /tmp/mosq.tar.gz && \
    echo "$DOWNLOAD_SHA256  /tmp/mosq.tar.gz" | sha256sum -c - && \
    wget https://mosquitto.org/files/source/mosquitto-${VERSION}.tar.gz.asc -O /tmp/mosq.tar.gz.asc && \
    export GNUPGHOME="$(mktemp -d)" && \
    found=''; \
    for server in \
        ha.pool.sks-keyservers.net \
        hkp://keyserver.ubuntu.com:80 \
        hkp://p80.pool.sks-keyservers.net:80 \
        pgp.mit.edu \
    ; do \
        echo "Fetching GPG key $GPG_KEYS from $server"; \
        gpg --keyserver "$server" --keyserver-options timeout=10 --recv-keys "$GPG_KEYS" && found=yes && break; \
    done; \
    test -z "$found" && echo >&2 "error: failed to fetch GPG key $GPG_KEYS" && exit 1; \
    gpg --batch --verify /tmp/mosq.tar.gz.asc /tmp/mosq.tar.gz && \
    gpgconf --kill all && \
    rm -rf "$GNUPGHOME" /tmp/mosq.tar.gz.asc && \
    mkdir -p /build/mosq && \
    tar --strip=1 -xf /tmp/mosq.tar.gz -C /build/mosq && \
    rm /tmp/mosq.tar.gz && \
    make -C /build/mosq -j "$(nproc)" \
        CFLAGS="-Wall -O2 -I/build/lws/include -I/build" \
        LDFLAGS="-L/build/lws/lib -L/build/cjson" \
        WITH_ADNS=no \
        WITH_DOCS=no \
        WITH_SHARED_LIBRARIES=yes \
        WITH_SRV=no \
        WITH_STRIP=yes \
        WITH_WEBSOCKETS=yes \
        prefix=/usr \
        binary && \
    addgroup -S -g 1883 mosquitto 2>/dev/null && \
    adduser -S -u 1883 -D -H -h /var/empty -s /sbin/nologin -G mosquitto -g mosquitto mosquitto 2>/dev/null && \
    mkdir -p /mosquitto/config /mosquitto/data /mosquitto/log && \
    install -d /usr/sbin/ && \
    install -s -m755 /build/mosq/client/mosquitto_pub /usr/bin/mosquitto_pub && \
    install -s -m755 /build/mosq/client/mosquitto_rr /usr/bin/mosquitto_rr && \
    install -s -m755 /build/mosq/client/mosquitto_sub /usr/bin/mosquitto_sub && \
    install -s -m644 /build/mosq/lib/libmosquitto.so.1 /usr/lib/libmosquitto.so.1 && \
    install -s -m755 /build/mosq/src/mosquitto /usr/sbin/mosquitto && \
    install -s -m755 /build/mosq/apps/mosquitto_ctrl/mosquitto_ctrl /usr/bin/mosquitto_ctrl && \
    install -s -m755 /build/mosq/apps/mosquitto_passwd/mosquitto_passwd /usr/bin/mosquitto_passwd && \
    install -s -m755 /build/mosq/plugins/dynamic-security/mosquitto_dynamic_security.so /usr/lib/mosquitto_dynamic_security.so && \
    install -m644 /build/mosq/mosquitto.conf /mosquitto/config/mosquitto.conf && \
    install -Dm644 /build/cjson/LICENSE /usr/share/licenses/cJSON/LICENSE && \
    install -Dm644 /build/lws/LICENSE /usr/share/licenses/libwebsockets/LICENSE && \
    install -Dm644 /build/mosq/epl-v20 /usr/share/licenses/mosquitto/epl-v20 && \
    install -Dm644 /build/mosq/edl-v10 /usr/share/licenses/mosquitto/edl-v10 && \
    chown -R mosquitto:mosquitto /mosquitto && \
    apk --no-cache add \
        tzdata \
        ca-certificates && \
    apk del build-deps && \
    rm -rf /build


# Set up the entry point script and default command
COPY docker-entrypoint.sh
VOLUME ["/mosquitto"]
EXPOSE 1883
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/usr/sbin/mosquitto", "-c", "/mosquitto/config/mosquitto.conf"]
