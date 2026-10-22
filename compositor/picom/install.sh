#!/bin/sh
set -eu

# Compositor.
doas apk add picom  # Enable X11 transparency and window composition.

# Configuration paths.
source_file="$HOME/.config/init-alpine/compositor/picom/picom.conf"
config_directory="$HOME/.config/picom"
destination_file="$config_directory/picom.conf"

# Validate the default configuration.
if [ ! -f "$source_file" ]; then
    echo "Error: picom configuration template not found." >&2
    exit 1
fi

# Preserve existing user configuration.
mkdir -vp "$config_directory"
if [ -e "$destination_file" ] || [ -L "$destination_file" ]; then
    echo "Existing picom configuration found. No changes made."
else
    cp -v "$source_file" "$destination_file"
fi
