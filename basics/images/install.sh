#!/bin/sh
set -eu

# Lightweight image viewers.
doas apk add feh             # Lightweight image viewer and desktop wallpaper manager.
doas apk add pqiv            # Fast image viewer with keyboard navigation.

# Image editors.
doas apk add mtpaint         # Lightweight image and pixel art editor.
doas apk add gimp            # Advanced image editing and manipulation.

# Color tools.
doas apk add gpick           # Advanced color picker and palette manager.

# KDE image viewers.
# doas apk add gwenview        # Image viewer with browsing and basic editing tools.

# KDE image editors.
# doas apk add kolourpaint     # Simple painting and image editing application.

# KDE color tools.
# doas apk add kcolorchooser   # Pick colors and copy their color values.
# doas apk add kontrast        # Check color contrast and accessibility.
