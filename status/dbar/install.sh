#!/bin/sh
set -eu

repository="$HOME/.config/dbar"

# Preserve existing checkouts and refuse unexpected files or symlinks.
if [ -L "$repository" ] ||
   { [ -e "$repository" ] && [ ! -d "$repository" ]; }; then
    echo "Error: Unexpected dbar installation path: $repository" >&2
    exit 1
fi

if [ ! -d "$repository" ]; then
    mkdir -vp "$HOME/.config"
    git clone https://github.com/agusc01/dbar "$repository"
fi

if [ ! -f "$repository/install.sh" ]; then
    echo "Error: Existing directory is not a valid dbar checkout: $repository" >&2
    exit 1
fi

# dbar installs xsetroot and safe user-level command symlinks.
sh "$repository/install.sh"
