#!/bin/sh
set -eu

# Install system resource monitors and performance statistics.
doas apk add btop
doas apk add htop
doas apk add fastfetch
doas apk add sysstat
