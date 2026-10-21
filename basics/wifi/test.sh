#!/bin/sh
set -eu

PATH="$PATH:/sbin:/usr/sbin"
export PATH

# Detect the wireless interface.
interface=$(iw dev | awk '$1 == "Interface" { print $2; exit }')

if [ -z "$interface" ]; then
    echo "Error: no wireless interface detected." >&2
    exit 1
fi

# Wireless interface.
echo "Wireless interface: $interface"
iw dev "$interface" link

# Wireless radio status.
echo
echo "Wireless radio:"
rfkill list wifi

# IP address.
echo
echo "IP address:"
ip -4 addr show dev "$interface"

# Default route.
echo
echo "Default route:"
ip route show default

# Internet connectivity.
echo
echo "Internet connectivity:"
ping -c 2 -W 3 1.1.1.1

# DNS resolution.
echo
echo "DNS resolution:"
nslookup example.com

echo
echo "Wi-Fi checks completed."
