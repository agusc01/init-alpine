#!/bin/sh
set -eu

# Source and destination.
source_file="$HOME/.config/init-alpine/suckless/dwm/xinitrc"
destination_file="$HOME/.xinitrc"

# Preserve existing user configuration.
if [ -e "$destination_file" ] || [ -L "$destination_file" ]; then
    echo "Existing .xinitrc found. No changes made."
    exit 0
fi

# Install the dwm session configuration.
cp -v "$source_file" "$destination_file"

echo "dwm session configured."
echo "Run startx from a local console to start dwm."
