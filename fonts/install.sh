#!/bin/sh
set -eu

# Font management.
doas apk add fontconfig                  # Manage installed fonts and rebuild font caches.

# Ubuntu Nerd Fonts.
doas apk add font-ubuntu-nerd            # Install Ubuntu Nerd Font and UbuntuMono Nerd Font.

# Optional terminal fonts.
# doas apk add font-jetbrains-mono-nerd  # JetBrains Mono with Nerd Font icons.
# doas apk add font-fira-code-nerd       # Fira Code with Nerd Font icons.
# doas apk add font-hack-nerd            # Hack with Nerd Font icons.

# Rebuild font caches.
fc-cache -fv

# List installed Ubuntu fonts.
fc-list : family | grep -i ubuntu
