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

# Time
sh "$HOME/.config/init-alpine/basics/time/install.sh"

# Keyboard
sh "$HOME/.config/init-alpine/basics/keyboard/install.sh"

# Bluetooth
sh "$HOME/.config/init-alpine/basics/bluetooth/install.sh"

# Wi-Fi
sh "$HOME/.config/init-alpine/basics/wifi/install.sh"

# Camera
sh "$HOME/.config/init-alpine/basics/camera/install.sh"

# Images
sh "$HOME/.config/init-alpine/basics/images/install.sh"

# PDF
sh "$HOME/.config/init-alpine/basics/pdf/install.sh"

# Video
sh "$HOME/.config/init-alpine/basics/video/install.sh"

# Maths
sh "$HOME/.config/init-alpine/basics/maths/install.sh"

# Office
sh "$HOME/.config/init-alpine/basics/office/install.sh"

# Screen
sh "$HOME/.config/init-alpine/basics/screen/install.sh"

# Fonts
sh "$HOME/.config/init-alpine/fonts/install.sh"

# Backgrounds
sh "$HOME/.config/init-alpine/backgrounds/install.sh"
sh "$HOME/.config/init-alpine/backgrounds/configure.sh"

# Xorg
sh "$HOME/.config/init-alpine/xorg/install.sh"

# Suckless dependencies.
sh "$HOME/.config/init-alpine/suckless/dependencies.sh"

# Terminal.
sh "$HOME/.config/init-alpine/suckless/st/install.sh"

# Application launcher.
# sh "$HOME/.config/init-alpine/suckless/dmenu/install.sh"

# Window manager.
sh "$HOME/.config/init-alpine/suckless/dwm/install.sh"
sh "$HOME/.config/init-alpine/suckless/dwm/configure.sh"

# Screen locker.
sh "$HOME/.config/init-alpine/suckless/slock/install.sh"

# Keyboard shortcuts.
sh "$HOME/.config/init-alpine/suckless/dshortcuts/install.sh"
