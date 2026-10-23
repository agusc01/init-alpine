#!/bin/sh
set -eu

# Console menu selector. It works in a TTY without X11.
doas apk add fzf  # Interactive fuzzy selection with optional previews.

if ! command -v fzf >/dev/null 2>&1; then
    echo 'Error: fzf was not found after installation.' >&2
    exit 1
fi

echo 'Console menu dependency is installed: fzf.'
