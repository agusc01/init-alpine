#!/bin/sh
set -eu

# Create user directories.
mkdir -vp "$HOME/Downloads"
mkdir -vp "$HOME/Documents"
mkdir -vp "$HOME/Music"
mkdir -vp "$HOME/Pictures"
mkdir -vp "$HOME/Videos"

# Install essential command-line utilities.
doas apk add curl
doas apk add wget
doas apk add unzip
doas apk add dos2unix
doas apk add tree
doas apk add fzf
doas apk add nano
doas apk add bat
doas apk add lsd
doas apk add figlet
