#!/bin/sh
set -eu

# Wallpaper manager.
doas apk add feh  # Display images and set X11 wallpapers.

# Directories.
source_directory="$HOME/.config/init-alpine/backgrounds/images"
destination_directory="$HOME/Pictures/backgrounds"

# Validate source directory.
if [ ! -d "$source_directory" ]; then
    echo "Error: Wallpaper source directory not found." >&2
    exit 1
fi

# Create wallpaper directory.
mkdir -vp "$destination_directory"

# Copy supported wallpapers without overwriting existing files.
for source_file in "$source_directory"/*; do
    [ -f "$source_file" ] || continue

    case "$source_file" in
        *.jpg|*.jpeg|*.png|*.webp|*.JPG|*.JPEG|*.PNG|*.WEBP)
            ;;
        *)
            continue
            ;;
    esac

    filename="${source_file##*/}"
    destination_file="$destination_directory/$filename"

    if [ -e "$destination_file" ] || [ -L "$destination_file" ]; then
        echo "Skipping existing wallpaper: $filename"
        continue
    fi

    cp -v "$source_file" "$destination_file"
done
