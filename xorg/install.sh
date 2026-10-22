#!/bin/sh
set -eu

# Xorg server.
doas apk add xorg-server          # Run the X11 graphical display server.
doas apk add xinit                # Start graphical sessions with startx.
doas apk add xauth                # Manage X11 authentication credentials.

# Graphics drivers.
doas apk add mesa-dri-gallium     # Provide hardware-accelerated graphics drivers.

# Input devices.
doas apk add xf86-input-libinput  # Support keyboards, mice, touchpads and touchscreens.

# Device management.
doas apk add eudev                # Detect and manage system devices.

# Session communication.
doas apk add dbus                 # Provide communication between desktop applications.

# Optional terminal.
# doas apk add xterm              # Alternative X11 terminal.

# Optional graphics drivers.
# doas apk add xf86-video-intel   # Alternative Intel graphics driver.
