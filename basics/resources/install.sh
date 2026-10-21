#!/bin/sh
set -eu

# Install system resource monitors and performance statistics.
doas apk add btop htop fastfetch sysstat
