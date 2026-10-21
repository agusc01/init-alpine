#!/bin/sh
set -eu

# Video players.
doas apk add mpv           # Lightweight video player with keyboard controls.
doas apk add vlc           # Multimedia player supporting a wide range of formats.
doas apk add vlc-qt        # Graphical interface for VLC.

# Video utilities.
doas apk add ffmpeg        # Convert, record, compress and process audio and video.

# Video recording and streaming.
# doas apk add obs-studio  # Record the screen, capture video and stream live.
