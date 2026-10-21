#!/bin/sh
set -eu

# Command-line calculators.
doas apk add bc             # Perform calculations with arbitrary precision.

# Graphical calculators.
doas apk add galculator     # Lightweight scientific calculator for GTK.

# KDE calculators.
# doas apk add kcalc        # Scientific calculator using KDE and Qt.
