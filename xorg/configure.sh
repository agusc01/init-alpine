#!/bin/sh
set -eu

# Alpine defaults to mdev; Xorg's libinput driver needs eudev rules for devices.
# setup-devd handles replacing the old manager and enabling the required services.
doas setup-devd udev

echo "eudev configured for Xorg input devices."
echo "Reboot recommended if switching from mdev."
