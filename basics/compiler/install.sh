#!/bin/sh
set -eu

# Install essential build tools.
doas apk add build-base cmake meson
