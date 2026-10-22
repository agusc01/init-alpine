#!/bin/sh
set -eu

# Source and destination.
source_file="$HOME/.config/init-alpine/suckless/dwm/xinitrc"
destination_file="$HOME/.xinitrc"

# Ensure the session template is available.
if [ ! -f "$source_file" ]; then
    echo "Error: dwm session template not found." >&2
    exit 1
fi

# Never replace a linked or custom X11 session configuration.
if [ -L "$destination_file" ]; then
    echo "Existing .xinitrc symlink found. No changes made."
    exit 0
fi

if [ -e "$destination_file" ]; then
    if [ ! -f "$destination_file" ]; then
        echo "Existing .xinitrc is not a regular file. No changes made."
        exit 0
    fi

    if cmp -s "$source_file" "$destination_file"; then
        echo "dwm session is already configured."
        exit 0
    fi

    # Only migrate the exact session template previously installed by init-alpine.
    legacy_content='#!/bin/sh
set -eu

# Start the dwm desktop session.
exec dbus-run-session -- dwm'

    if [ "$(cat "$destination_file")" != "$legacy_content" ]; then
        echo "Existing custom .xinitrc found. No changes made."
        exit 0
    fi

    # Preserve the previous session configuration before updating it.
    backup_file="$destination_file.init-alpine.bak"
    if [ -e "$backup_file" ] || [ -L "$backup_file" ]; then
        echo "Existing .xinitrc backup found. No changes made."
        exit 0
    fi

    cp -v "$destination_file" "$backup_file"
    cp -v "$source_file" "$destination_file"
    echo "Previous init-alpine .xinitrc updated."
else
    # Create the session configuration only when it does not exist.
    cp -v "$source_file" "$destination_file"
    echo "dwm session configured."
fi

echo "Run startx from a local console to start dwm."
