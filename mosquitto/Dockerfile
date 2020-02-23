# ----------------------------------------
# Description
# ----------------------------------------
# Creates an image with 'mosquitto' MQTT broker.
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
# lastmod: 2020-02-23T12:20:08+01:00
# changelog:
#   - 2020-02-23:
#       - added tzdata to set timezone
#       - set mosquitto docker version to 1.6.8
#   - 2020-02-21: add mosquitto_passwd.sh
#   - 2020-02-09: created

ARG mosquitto_version=1.6.8
FROM eclipse-mosquitto:$mosquitto_version

ARG tzdata_version=2019c-r0
RUN apk add --no-cache tzdata="${tzdata_version}"

COPY mosquitto_passwd.sh /usr/local/sbin/mosquitto_passwd.sh
COPY mosquitto.conf /mosquitto/config/mosquitto.conf
