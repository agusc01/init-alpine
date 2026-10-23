#!/bin/sh
set -eu

repository=$(CDPATH= cd "$(dirname "$0")/.." && pwd)
workspace=$(mktemp -d)
trap 'rm -Rv "$workspace" >/dev/null' 0

sh -n "$repository/basics/core/configure.sh"
sh -n "$repository/install.sh"

HOME="$workspace/user"
export HOME
mkdir -vp "$HOME" >/dev/null

sh "$repository/basics/core/configure.sh" >/dev/null

config_file="$HOME/.config/fish/conf.d/90-init-alpine-local-bin.fish"
expected='fish_add_path --path "$HOME/.local/bin"'

[ -f "$config_file" ] || {
    echo 'Error: Fish PATH configuration was not created.' >&2
    exit 1
}
[ "$(cat "$config_file")" = "$expected" ] || {
    echo 'Error: Unexpected Fish PATH configuration.' >&2
    exit 1
}

# Re-running setup must not rewrite an existing managed configuration.
first_hash=$(cksum < "$config_file")
sh "$repository/basics/core/configure.sh" >/dev/null
[ "$(cksum < "$config_file")" = "$first_hash" ] || {
    echo 'Error: Re-running setup unexpectedly changed the configuration.' >&2
    exit 1
}

# The PR's earlier managed config must migrate without affecting other files.
printf '%s\n' 'fish_add_path -g -- "$HOME/.local/bin"' > "$config_file"
sh "$repository/basics/core/configure.sh" >/dev/null
[ "$(cat "$config_file")" = "$expected" ] || {
    echo 'Error: Legacy managed Fish config was not upgraded.' >&2
    exit 1
}

printf '%s\n' 'custom user contents' > "$config_file"
if sh "$repository/basics/core/configure.sh" >/dev/null 2>&1; then
    echo 'Error: Setup overwrote a conflicting user configuration.' >&2
    exit 1
fi
[ "$(cat "$config_file")" = 'custom user contents' ] || {
    echo 'Error: Conflicting user configuration was modified.' >&2
    exit 1
}

echo 'Fish user PATH tests passed.'
