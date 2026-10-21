#!/bin/sh
set -eu

# Create user directories.
mkdir -p \
    "$HOME/Downloads" \
    "$HOME/Documents" \
    "$HOME/Music" \
    "$HOME/Pictures" \
    "$HOME/Videos"

# Install essential command-line utilities.
doas apk add \
    curl \
    wget \
    unzip \
    dos2unix \
    tree \
    fzf \
    nano \
    bat \
    lsd \
    figlet
