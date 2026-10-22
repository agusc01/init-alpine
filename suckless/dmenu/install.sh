#!/bin/sh
set -eu

# Source directory.
directory="$HOME/.config/dmenu"

# Clone the source repository.
if [ ! -e "$directory" ] && [ ! -L "$directory" ]; then
    git clone https://github.com/agusc01/dmenu "$directory"
fi

# Validate the source directory.
if [ ! -f "$directory/Makefile" ]; then
    echo "Error: dmenu source directory is invalid." >&2
    exit 1
fi

# Compile and install dmenu.
cd "$directory"

make clean
make
doas make install
