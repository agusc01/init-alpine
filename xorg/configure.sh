#!/bin/sh
set -eu

echo "Alpine recommends eudev for graphical environments."
echo "Changing device managers may require a reboot."
echo

printf "Configure eudev? [y/N]: "
IFS= read -r answer || answer=""

case "$answer" in
    y|Y)
        doas setup-devd udev
        echo "Device manager configured."
        ;;
    *)
        echo "Device manager configuration skipped."
        ;;
esac
