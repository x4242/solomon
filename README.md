[![License: GPL v3](https://img.shields.io/badge/License-GLv3-blue?style=flat-square)](https://www.gnu.org/licenses/gpl-3.0)

[![Twitter Follow](https://img.shields.io/twitter/follow/0x4242?color=blue&logo=twitter&style=flat-square)](https://twitter.com/0x4242)

# Outline
- Debian as host OS
- services as Docker containers
- HW req: 2x ETH, CPU with AES-NI

## DHCP
Kea on Alpine Linux

**TODO**:
- add volume to persist lease file
- finalize config

## DNS
unbound on Alpine Linux

**TODO**:
- Container
  - finalize config
  - add volume to container to persists generated config file, maybe cache
  - find place where to put scripts
  - cronjobs
- Update script: see script
- Blacklist scripts: see script

## Smart Home
Mosquitto
Node-RED
