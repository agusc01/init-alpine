#!/bin/sh
set -eu

# Notification daemon.
doas apk add dunst  # Display lightweight desktop notifications.

# Configuration paths.
source_file="$HOME/.config/init-alpine/notifications/dunst/dunstrc"
config_directory="$HOME/.config/dunst"
destination_file="$config_directory/dunstrc"

# Validate the default configuration.
if [ ! -f "$source_file" ]; then
    echo "Error: dunst configuration template not found." >&2
    exit 1
fi

# Preserve existing user configuration.
mkdir -vp "$config_directory"
if [ -e "$destination_file" ] || [ -L "$destination_file" ]; then
    echo "Existing dunst configuration found. No changes made."
else
    cp -v "$source_file" "$destination_file"
fi
