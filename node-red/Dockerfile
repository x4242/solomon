# ----------------------------------------
# Description
# ----------------------------------------
# Creates an image with Node-RED based on the Node-RED docker image.
# See https://nodered.org/docs/getting-started/docker and
# https://hub.docker.com/r/nodered/node-red/ and for Details
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
# lastmod: 2020-02-21T20:02:25+01:00
# changelog:
#   - 2020-02-21: added Node-RED version argument
#   - 2020-02-09: created

ARG nodered_version=latest
FROM nodered/node-red:$nodered_version

RUN npm install node-red-dashboard
