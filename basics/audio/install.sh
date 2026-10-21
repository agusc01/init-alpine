#!/bin/sh
set -eu

PATH="$PATH:/sbin:/usr/sbin"
export PATH

# Install ALSA.
doas apk add alsa-utils
doas apk add alsa-utils-openrc

# Grant audio access to the current user.
username=$(id -un)

if ! id -nG "$username" | tr ' ' '\n' | grep -Fxq audio; then
    doas addgroup "$username" audio
fi

# Enable ALSA state restoration at boot.
doas rc-update add alsa default
doas rc-service alsa start

echo "ALSA installed successfully."
echo "Log out and log back in if your audio group was updated."
