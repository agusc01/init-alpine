#!/bin/sh
set -eu

# List detected video devices.
v4l2-ctl --list-devices

# Display supported camera formats.
v4l2-ctl --list-formats-ext
