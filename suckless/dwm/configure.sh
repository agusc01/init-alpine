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

    # Only migrate session templates previously installed by init-alpine.
    legacy_content='#!/bin/sh
set -eu

# Start the dwm desktop session.
exec dbus-run-session -- dwm'

    absolute_path_content='#!/bin/sh
set -eu

# Start the dwm desktop session.
exec dbus-run-session -- /usr/local/bin/dwm'

    wallpaper_content='#!/bin/sh
set -eu

# Restore the selected wallpaper without blocking the desktop startup.
if ! sh "$HOME/.config/init-alpine/backgrounds/apply.sh"; then
    echo "Warning: Could not restore the wallpaper." >&2
fi

# Start the dwm desktop session.
exec dbus-run-session -- /usr/local/bin/dwm'

    existing_content=$(cat "$destination_file")
    if [ "$existing_content" != "$legacy_content" ] &&
       [ "$existing_content" != "$absolute_path_content" ] &&
       [ "$existing_content" != "$wallpaper_content" ]; then
        echo "Existing custom .xinitrc found. No changes made."
        exit 0
    fi

    # Back up the previous session before enabling the compositor and notifications.
    backup_file="$destination_file.init-alpine-session.bak"
    if [ -e "$backup_file" ] || [ -L "$backup_file" ]; then
        echo "Existing .xinitrc session backup found. No changes made."
        exit 0
    fi

    cp -v "$destination_file" "$backup_file"
    cp -v "$source_file" "$destination_file"
    echo "Previous init-alpine .xinitrc updated."
else
    # Install the new session configuration.
    cp -v "$source_file" "$destination_file"
    echo "dwm session configured."
fi

echo "Run startx from a local console to start dwm."
