#!/bin/sh
set -eu

# Source directory.
directory="$HOME/.config/slock"

# Clone the source repository.
if [ ! -e "$directory" ] && [ ! -L "$directory" ]; then
    git clone https://github.com/agusc01/slock "$directory"
fi

# Validate the source directory.
if [ ! -f "$directory/Makefile" ]; then
    echo "Error: slock source directory is invalid." >&2
    exit 1
fi

# Compile and install slock.
# The upstream Makefile installs slock setuid-root for password verification.
# Do not launch slock until the local user's password is known.
cd "$directory"

make clean
make
doas make install

echo "slock installed. Verify the local password before running it."
