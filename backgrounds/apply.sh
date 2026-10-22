#!/bin/sh
set -eu

# Directories and files.
wallpaper_directory="$HOME/Pictures/backgrounds"
selection_file="$HOME/.config/backgrounds/current"

# No wallpaper has been selected yet.
if [ ! -f "$selection_file" ]; then
    exit 0
fi

# Read the selected filename.
filename=""
IFS= read -r filename < "$selection_file" || [ -n "$filename" ]

# Reject invalid filenames and directory traversal.
case "$filename" in
    ''|.|..|*/*)
        echo "Error: Invalid wallpaper filename." >&2
        exit 1
        ;;
esac

# Validate the selected wallpaper.
wallpaper="$wallpaper_directory/$filename"
if [ ! -f "$wallpaper" ]; then
    echo "Error: Wallpaper not found: $wallpaper" >&2
    exit 1
fi

# Require an active graphical session.
if [ -z "${DISPLAY:-}" ]; then
    echo "Error: X11 display is not available." >&2
    exit 1
fi

# Set the wallpaper without creating ~/.fehbg.
feh --no-fehbg --bg-fill "$wallpaper"
