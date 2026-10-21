#!/bin/sh
set -eu

# Console keyboard utilities.
doas apk add kbd

# On-screen keyboard for X11.
doas apk add onboard
