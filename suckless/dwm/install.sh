#!/bin/sh
set -eu

# Source directory.
directory="$HOME/.config/dwm"

# Clone the source repository.
if [ ! -e "$directory" ] && [ ! -L "$directory" ]; then
    git clone https://github.com/agusc01/dwm "$directory"
fi

# Validate the source directory.
if [ ! -f "$directory/Makefile" ]; then
    echo "Error: dwm source directory is invalid." >&2
    exit 1
fi

# Compile and install dwm.
cd "$directory"

make clean
make
doas make install
