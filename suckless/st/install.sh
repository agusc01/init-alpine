#!/bin/sh
set -eu

# Source directory.
directory="$HOME/.config/st"

# Clone the source repository.
if [ ! -e "$directory" ] && [ ! -L "$directory" ]; then
    git clone https://github.com/agusc01/st "$directory"
fi

# Validate the source directory.
if [ ! -f "$directory/Makefile" ]; then
    echo "Error: st source directory is invalid." >&2
    exit 1
fi

# Compile and install st.
cd "$directory"

make clean
make
doas make install

# Install terminfo for the current user.
tic -sx st.info
