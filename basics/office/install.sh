#!/bin/sh
set -eu

# LibreOffice applications.
doas apk add libreoffice-writer     # Create and edit text documents.
doas apk add libreoffice-calc       # Create and edit spreadsheets.
doas apk add libreoffice-impress    # Create and edit presentations.
doas apk add libreoffice-gtk        # GTK desktop interface integration.

# Optional LibreOffice applications.
# doas apk add libreoffice-draw     # Create drawings and diagrams.
# doas apk add libreoffice-base     # Manage databases.
# doas apk add libreoffice-math     # Create mathematical formulas.

# Language packs.
# doas apk add libreoffice-lang-es      # Spanish interface.
# doas apk add libreoffice-lang-en_gb   # British English interface.

# Full LibreOffice suite (alternative to individual applications).
# doas apk add libreoffice        # Install the complete office suite.

# Lightweight office alternatives.
# doas apk add abiword           # Lightweight word processor.
# doas apk add gnumeric          # Lightweight spreadsheet editor.

# KDE office suite.
# doas apk add calligra          # KDE word processor, spreadsheets and presentations.
