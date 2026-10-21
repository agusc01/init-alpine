#!/bin/sh
set -eu

# Audio
sh "$HOME/.config/init-alpine/basics/audio/install.sh"
sh "$HOME/.config/init-alpine/basics/audio/cherry-trail.sh"
sh "$HOME/.config/init-alpine/basics/audio/test.sh"

# Resources
sh "$HOME/.config/init-alpine/basics/resources/install.sh"

# Compiler
sh "$HOME/.config/init-alpine/basics/compiler/install.sh"

# Core
sh "$HOME/.config/init-alpine/basics/core/install.sh"

# Disk
sh "$HOME/.config/init-alpine/basics/disk/install.sh"
