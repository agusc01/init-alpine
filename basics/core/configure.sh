#!/bin/sh
set -eu

# Ensure that Fish can find executables installed in ~/.local/bin.
# Manage a dedicated file rather than changing the user's config.fish.
config_directory="$HOME/.config/fish/conf.d"
config_file="$config_directory/90-init-alpine-local-bin.fish"
expected='fish_add_path -g -- "$HOME/.local/bin"'

if [ -L "$config_file" ] ||
   { [ -e "$config_file" ] && [ ! -f "$config_file" ]; }; then
    echo "Error: Unexpected Fish configuration path: $config_file" >&2
    exit 1
fi

if [ -f "$config_file" ]; then
    if [ "$(cat "$config_file")" != "$expected" ]; then
        echo "Error: Existing Fish configuration differs: $config_file" >&2
        exit 1
    fi
    echo "Fish user command PATH is already configured."
    exit 0
fi

mkdir -vp "$config_directory"
printf '%s\n' "$expected" > "$config_file"
echo "Fish user command PATH configured: $config_file"
echo 'Open a new Fish shell or run: fish_add_path -g "$HOME/.local/bin"'
