#!/bin/sh
set -eu

# Optional backend for the future Wi-Fi menus.
# This installer only installs packages: it never starts, stops or enables
# NetworkManager, wpa_supplicant or the existing networking service.
doas apk add networkmanager          # Network management daemon.
doas apk add networkmanager-cli      # Provide the nmcli command.
doas apk add networkmanager-wifi     # Enable Wi-Fi device support.
doas apk add networkmanager-openrc   # OpenRC service definition (not enabled).

if ! command -v nmcli >/dev/null 2>&1; then
    echo 'Error: nmcli was not found after installation.' >&2
    exit 1
fi

printf '%s\n' \
    'NetworkManager packages installed. No network services were changed.' \
    'nmcli requires a running, correctly configured NetworkManager service.' \
    'Do not start NetworkManager alongside another manager of the same interface.' \
    'Follow the documented migration procedure before switching Wi-Fi backends.'
