[![License: GPL v3](https://img.shields.io/badge/License-GLv3-blue?style=flat-square)](https://www.gnu.org/licenses/gpl-3.0) [![Twitter Follow](https://img.shields.io/twitter/follow/0x4242?color=blue&logo=twitter&style=flat-square)](https://twitter.com/0x4242)

# solomon - The dockerized Home Router
---

The goal of this project is to provide a fully featured hardware agnostic home router aiming to replace traditional ISP or out-of-box solution. Thereby giving back full control over all networking services. Currently 'solomon' is providing the following services:

-  DNS server using [Unbound](https://nlnetlabs.nl/projects/unbound/about/)
-  DHCP server [Kea](https://www.isc.org/kea/)
-  NTP server using [OpenNTPD](http://www.openntpd.org/)
-  MQTT broker using [Mosquitto](https://mosquitto.org/)
-  IoT Automation using [Node-RED](https://nodered.org/)
-  VPN server using [WireGuard](https://www.wireguard.com/)
-  Docker host management using [Portainer](https://www.portainer.io/)

## Prerequisites
---

-  Debian 10 or later
-  Two physical network interfaces

## Setup
---

1.  Set the config values in `config.sh` and `setup.sh`
2.  Run `setup.sh`
