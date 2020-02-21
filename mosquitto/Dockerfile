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
# lastmod: 2020-02-21T20:02:53+01:00
# changelog:
#   - 2020-02-21: add mosquitto_passwd.sh
#   - 2020-02-09: created

ARG mosquitto_version=latest
FROM eclipse-mosquitto:$mosquitto_version

COPY mosquitto_passwd.sh /usr/local/sbin/mosquitto_passwd.sh
COPY mosquitto.conf /mosquitto/config/mosquitto.conf
