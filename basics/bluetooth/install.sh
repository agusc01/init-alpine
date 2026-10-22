#!/bin/sh
set -eu

# Bluetooth packages.
doas apk add bluez
doas apk add bluez-openrc
doas apk add dbus
doas apk add util-linux-misc  # Provide rfkill for wireless device control.

# Graphical Bluetooth manager.
doas apk add blueman

# Enable Bluetooth services.
doas rc-update add dbus default
doas rc-update add bluetooth default

# Start Bluetooth services.
doas rc-service dbus start
doas rc-service bluetooth start
