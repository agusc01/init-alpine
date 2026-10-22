#!/bin/sh
set -eu

# Directories and files.
wallpaper_directory="$HOME/Pictures/backgrounds"
config_directory="$HOME/.config/backgrounds"
selection_file="$config_directory/current"

# Validate wallpaper directory.
if [ ! -d "$wallpaper_directory" ]; then
    echo "Error: Wallpaper directory not found." >&2
    exit 1
fi

# Preserve links and unexpected configuration files.
if [ -L "$selection_file" ] || {
    [ -e "$selection_file" ] && [ ! -f "$selection_file" ]
}; then
    echo "Error: Unexpected wallpaper configuration file." >&2
    exit 1
fi

# Read the current selection, when available.
current_filename=""
if [ -f "$selection_file" ]; then
    IFS= read -r current_filename < "$selection_file" || :
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
current_available=0

for wallpaper in "$@"; do
    [ -f "$wallpaper" ] || continue

    index=$((index + 1))
    filename="${wallpaper##*/}"
    printf '%s) %s\n' "$index" "$filename"

    if [ -n "$current_filename" ] && [ "$filename" = "$current_filename" ]; then
        current_available=1
    fi
done

if [ "$index" -eq 0 ]; then
    echo "Error: No wallpapers found." >&2
    exit 1
fi

# Show the previous selection if the image is still available.
if [ "$current_available" -eq 1 ]; then
    printf '\nCurrent wallpaper: %s\n' "$current_filename"
fi

# Read the selection from the terminal, even before X11 starts.
echo
if [ "$current_available" -eq 1 ]; then
    printf 'Selection [1-%s, Enter to keep current]: ' "$index"
else
    printf 'Selection [1-%s]: ' "$index"
fi
IFS= read -r selection || selection=""

filename=""
if [ -z "$selection" ]; then
    if [ "$current_available" -ne 1 ]; then
        echo "Error: Select a wallpaper number." >&2
        exit 1
    fi

    filename="$current_filename"
else
    case "$selection" in
        *[!0-9]*)
            echo "Error: Invalid selection." >&2
            exit 1
            ;;
    esac

    index=0
    for wallpaper in "$@"; do
        [ -f "$wallpaper" ] || continue

        index=$((index + 1))
        if [ "$selection" = "$index" ]; then
            filename="${wallpaper##*/}"
            break
        fi
    done
fi

if [ -z "$filename" ]; then
    echo "Error: Invalid selection." >&2
    exit 1
fi

# Save only when the selection has changed.
mkdir -vp "$config_directory"
if [ "$filename" != "$current_filename" ] || [ ! -f "$selection_file" ]; then
    printf '%s\n' "$filename" > "$selection_file"
fi

echo "Wallpaper selected: $filename"

# Apply immediately in X11, or restore it when dwm starts.
if [ -n "${DISPLAY:-}" ]; then
    sh "$HOME/.config/init-alpine/backgrounds/apply.sh"
else
    echo "Wallpaper will be applied when dwm starts."
fi
