#!/bin/sh
set -eu

# Display utilities.
doas apk add xrandr        # Configure screen resolution, orientation and connected monitors.
doas apk add xinput        # Configure input devices, including touchscreen rotation.
doas apk add xset          # Configure screen blanking, power management and X11 settings.

# Screenshot utilities.
doas apk add flameshot     # Capture, annotate and save screenshots.
doas apk add scrot         # Capture screenshots directly from the terminal.

# Optional display utilities.
# doas apk add arandr      # Graphical interface for configuring monitors with xrandr.
# doas apk add autorandr   # Automatically apply saved monitor configurations.
