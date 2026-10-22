#!/bin/sh
set -eu

# Build tools.
doas apk add build-base         # GCC, make and standard compilation tools.
doas apk add git                # Clone source repositories.
doas apk add pkgconf            # Find compiler and linker flags.
doas apk add ncurses            # Provide tic for st terminfo installation.

# X11 libraries.
doas apk add libx11-dev         # Core X11 development library.
doas apk add libxft-dev         # Render fonts using Xft.
doas apk add libxinerama-dev    # Support multiple monitors.
doas apk add libxext-dev        # Support X11 extensions.
doas apk add libxrender-dev     # Support X11 rendering extensions.
doas apk add libxcomposite-dev  # Support window compositing extensions.
doas apk add libxrandr-dev      # Support monitor and screen changes.

# Font libraries.
doas apk add fontconfig-dev     # Configure and discover system fonts.
doas apk add freetype-dev       # Render TrueType and OpenType fonts.

# Image libraries.
doas apk add imlib2-dev         # Render dwm window and tag previews.
