#!/bin/sh
#
# ------------------------------------------------------------------------------
# Description
# ------------------------------------------------------------------------------
# Performs the necessary base setup and configuration of the host OS.
#
# This includes:
#   - install and configure Docker
#   - configure NICs
#   - enable packet forwarding
#   - set firewall rules
#
# ------------------------------------------------------------------------------
# Change History
# ------------------------------------------------------------------------------
# lastmod: 2020-06-28T14:37:44+02:00
# changelog:
#   - 2020-06-28:
#     - changed delimiter of sed for docker-compose.yml for timezone
#     - moved config of /etc/resolv.conf after docker build would
#       fail if DNS set to localhost as it is not running yet
#     - deamonized docker-compose up
#   - 2020-07-06: deamonize docker-compose up
#   - 2020-03-29:
#     - moved from host-setup.sh
#     - changed header style
#     - added iptables configuration
#     - set 127.0.0.1 as nameserver and make /etc/resolv.conf immutable
#   - 2020-01-29: static IP configuration on internal NIC
#   - 2020-01-23: created

INT_IF="enp3s0"
INT_IP4="10.66.66.1/24"

EXT_IF="enp6s0"
EXT_IP4="192.168.0.254/24"
EXT_IP4_GW="192.168.0.1"

# Update the apt package index:
apt-get update

# Install the latest version of Docker Engine Community Edition and containerd
apt-get install docker-ce docker-ce-cli containerd.io docker-compose
systemctl enable docker.service

# configure IP on internal NIC
echo "auto $INT_IF" >> /etc/network/interfaces
echo "allow-hotplug $INT_IF" >> /etc/network/interfaces
echo "iface $INT_IF inet static" >> /etc/network/interfaces
echo "  address $INT_IP4" >> /etc/network/interfaces

# configure IP on external NIC
echo "auto $EXT_IF" >> /etc/network/interfaces
echo "allow-hotplug $EXT_IF" >> /etc/network/interfaces
echo "iface $EXT_IF inet static" >> /etc/network/interfaces
echo "  address $EXT_IP4" >> /etc/network/interfaces
echo "  gateway $EXT_IP4_GW" >> /etc/network/interfaces

# enable packet forwarding IPv4
echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
# enable packet forwarding IPv6
#echo "net.ipv6.conf.all.forwarding=1" >> /etc/sysctl.conf

# iptable rules
cp ./iptables4.rules.template /etc/iptables4.rules
sed -i.bak "s/<INT_IF>/${INT_IF}/g" /etc/iptables4.rules
sed -i.bak "s/<EXT_IF>/${EXT_IF}/g" /etc/iptables4.rules
rm ./iptables4.rules.bak
/sbin/iptables-restore --noflush ./iptables4.rules
cp ./iptables-restore /etc/network/if-pre-up.d/iptables-restore
chmod +x /etc/network/if-pre-up.d/iptables-restore


# configure and build docker images
./docker-config.sh
./docker-build.sh

# configure localhost as DNS resolver and make config file immutable
rm -r /etc/resolv.conf
echo "nameserver 127.0.0.1" > /etc/resolv.conf
chattr +i /etc/resolv.conf

<<<<<<< HEAD
=======
# docker services
./docker-config.sh
./docker-build.sh
>>>>>>> b8e54af811c9410be2b4eb455c770a25c8f5a4e4
docker-compose up -d
