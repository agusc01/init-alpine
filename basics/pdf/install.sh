#!/bin/sh
set -eu

# PDF viewers.
doas apk add mupdf           # Lightweight PDF and XPS viewer.

# PDF command-line utilities.
doas apk add poppler-utils   # Inspect, extract, convert and merge PDF files.

# KDE PDF viewers.
# doas apk add okular         # Advanced document viewer with annotations and forms.
