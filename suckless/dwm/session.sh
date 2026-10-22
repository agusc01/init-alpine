#!/bin/sh
set -eu

# Restore the selected wallpaper without blocking the desktop startup.
if ! sh "$HOME/.config/init-alpine/backgrounds/apply.sh"; then
    echo "Warning: Could not restore the wallpaper." >&2
fi

# Start the compositor if it is installed.
if command -v picom >/dev/null 2>&1; then
    if ! picom --daemon --config "$HOME/.config/picom/picom.conf"; then
        echo "Warning: Could not start picom." >&2
    fi
fi

# Start the notification daemon inside the same D-Bus session.
if command -v dunst >/dev/null 2>&1; then
    dunst --config "$HOME/.config/dunst/dunstrc" &
fi

# Start the status bar.
if [ -x "$HOME/.local/bin/dbar_start" ]; then
    "$HOME/.local/bin/dbar_start" ||
        echo "Warning: Could not start dbar." >&2
fi

# Start the window manager.
exec /usr/local/bin/dwm
