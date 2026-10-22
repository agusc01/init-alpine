#!/bin/sh
set -eu

# Require an active graphical session.
if [ -z "${DISPLAY:-}" ]; then
    echo "Error: Run this script inside an X11 session." >&2
    exit 1
fi

# Directories and files.
wallpaper_directory="$HOME/Pictures/backgrounds"
config_directory="$HOME/.config/backgrounds"
selection_file="$config_directory/current"

# Validate wallpaper directory.
if [ ! -d "$wallpaper_directory" ]; then
    echo "Error: Wallpaper directory not found." >&2
    exit 1
fi

# Find supported image files.
set -- \
    "$wallpaper_directory"/*.jpg \
    "$wallpaper_directory"/*.jpeg \
    "$wallpaper_directory"/*.png \
    "$wallpaper_directory"/*.webp \
    "$wallpaper_directory"/*.JPG \
    "$wallpaper_directory"/*.JPEG \
    "$wallpaper_directory"/*.PNG \
    "$wallpaper_directory"/*.WEBP

# Display available wallpapers.
echo "Select a wallpaper:"
echo

index=0
for wallpaper in "$@"; do
    [ -f "$wallpaper" ] || continue
    index=$((index + 1))
    printf '%s) %s\n' "$index" "${wallpaper##*/}"
done

if [ "$index" -eq 0 ]; then
    echo "Error: No wallpapers found." >&2
    exit 1
fi

# Read the selection.
echo
printf "Selection [1-%s]: " "$index"
IFS= read -r selection || selection=""

case "$selection" in
    ''|*[!0-9]*)
        echo "Invalid selection."
        exit 1
        ;;
esac

# Find the selected wallpaper.
index=0
filename=""

for wallpaper in "$@"; do
    [ -f "$wallpaper" ] || continue
    index=$((index + 1))

    if [ "$selection" = "$index" ]; then
        filename="${wallpaper##*/}"
        break
    fi
done

if [ -z "$filename" ]; then
    echo "Invalid selection."
    exit 1
fi

# Create configuration directory.
mkdir -vp "$config_directory"

# Preserve links and unexpected configuration files.
if [ -L "$selection_file" ] || {
    [ -e "$selection_file" ] && [ ! -f "$selection_file" ]
}; then
    echo "Error: Unexpected wallpaper configuration file." >&2
    exit 1
fi

# Save the selection and apply it immediately.
printf '%s\n' "$filename" > "$selection_file"
sh "$HOME/.config/init-alpine/backgrounds/apply.sh"

echo "Wallpaper selected: $filename"
