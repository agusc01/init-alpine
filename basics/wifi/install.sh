#!/bin/sh
set -eu

# Network utilities.
doas apk add net-tools               # ifconfig, netstat and route.
doas apk add util-linux-misc         # rfkill: block and unblock wireless devices.

# Wireless utilities.
doas apk add iw                      # Manage wireless interfaces and inspect Wi-Fi networks.
doas apk add wireless-tools          # iwconfig, iwgetid and iwlist.

# Wireless authentication.
doas apk add wpa_supplicant          # Authenticate to WPA/WPA2 wireless networks.
doas apk add wpa_supplicant-openrc   # OpenRC service scripts for wpa_supplicant.
