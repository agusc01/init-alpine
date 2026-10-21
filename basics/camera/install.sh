#!/bin/sh
set -eu

# Camera utilities.
doas apk add v4l-utils    # Inspect and configure video devices.
doas apk add kmod         # Manage Linux kernel modules.
doas apk add guvcview     # View and capture webcam video.
