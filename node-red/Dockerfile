# ------------------------------------------------------------------------------
# Description
# ------------------------------------------------------------------------------
# Creates an image with Node-RED based on the Node-RED docker image.
# See https://nodered.org/docs/getting-started/docker and
# https://hub.docker.com/r/nodered/node-red/ and for Details
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
# lastmod: 2020-03-30T02:22:24+02:00
# changelog:
#   - 2020-03-30: changed header format
#   - 2020-02-21: added Node-RED version argument
#   - 2020-02-09: created

ARG nodered_version=latest
FROM nodered/node-red:$nodered_version

RUN npm install node-red-dashboard
