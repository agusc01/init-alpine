#!/bin/sh
set -eu

# Install essential build tools.
doas apk add build-base
doas apk add cmake
doas apk add meson
