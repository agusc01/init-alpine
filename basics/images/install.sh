#!/bin/sh
set -eu

# Lightweight image viewers.
doas apk add feh             # Lightweight image viewer and desktop wallpaper manager.
doas apk add nsxiv           # Minimal image viewer with keyboard navigation.

# Alternative image viewers.
# doas apk add imv-x11        # Lightweight keyboard-driven image viewer for X11.

# Image editors.
doas apk add drawing         # Simple painting and image editing application.
doas apk add gimp            # Advanced image editing and manipulation.

# Alternative image editors.
# doas apk add pinta          # Paint-style editor with layers and effects.

# Color tools.
doas apk add gpick           # Advanced color picker and palette manager.

# KDE image viewers.
# doas apk add gwenview        # Image viewer with browsing and basic editing tools.

# KDE image editors.
# doas apk add kolourpaint     # Simple painting and image editing application.

# KDE color tools.
# doas apk add kcolorchooser   # Pick colors and copy their color values.
# doas apk add kontrast        # Check color contrast and accessibility.
