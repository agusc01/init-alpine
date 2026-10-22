#!/bin/sh
set -eu

# Source directory.
directory="$HOME/.config/dshortcuts"

# Clone the source repository.
if [ ! -e "$directory" ] && [ ! -L "$directory" ]; then
    git clone https://github.com/agusc01/dshortcuts "$directory"
fi

# Validate the source directory.
if [ ! -f "$directory/Makefile" ]; then
    echo "Error: dshortcuts source directory is invalid." >&2
    exit 1
fi

# Compile and install dshortcuts.
# dmenu alone is responsible for installing the shared stest executable.
cd "$directory"

make clean
make
doas make install
