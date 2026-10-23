#!/bin/sh
set -eu

# Test package commands without running apk, changing services or using X11.
repo=$(CDPATH= cd "$(dirname "$0")/.." && pwd)
test_directory=$(mktemp -d)
trap 'rm -Rv "$test_directory" >/dev/null' 0

mkdir -vp "$test_directory/bin" >/dev/null
test_log="$test_directory/packages"
: > "$test_log"
export test_log

cat > "$test_directory/bin/doas" <<'MOCK'
#!/bin/sh
printf '%s\n' "$*" >> "$test_log"
MOCK

cat > "$test_directory/bin/fzf" <<'MOCK'
#!/bin/sh
exit 0
MOCK

cat > "$test_directory/bin/nmcli" <<'MOCK'
#!/bin/sh
exit 0
MOCK

chmod +x "$test_directory/bin/doas"
chmod +x "$test_directory/bin/fzf"
chmod +x "$test_directory/bin/nmcli"
PATH="$test_directory/bin:$PATH"
export PATH

sh -n "$repo/menus/install.sh"
sh -n "$repo/basics/wifi/networkmanager/install.sh"
sh -n "$repo/install.sh"

sh "$repo/menus/install.sh" > "$test_directory/output"
sh "$repo/basics/wifi/networkmanager/install.sh" >> "$test_directory/output"

cat > "$test_directory/expected" <<'EXPECTED'
apk add fzf
apk add networkmanager
apk add networkmanager-cli
apk add networkmanager-wifi
apk add networkmanager-openrc
EXPECTED

if ! cmp -s "$test_log" "$test_directory/expected"; then
    echo 'Error: Unexpected package installation commands.' >&2
    diff -u "$test_directory/expected" "$test_log" >&2 || :
    exit 1
fi

# Full installation should include the menu engines, but not migrate networking.
grep -F 'sh "$HOME/.config/init-alpine/menus/install.sh"' "$repo/install.sh" >/dev/null
grep -F 'sh "$HOME/.config/init-alpine/suckless/dmenu/install.sh"' "$repo/install.sh" >/dev/null

if grep -F 'sh "$HOME/.config/init-alpine/basics/wifi/networkmanager/install.sh"' "$repo/install.sh" >/dev/null; then
    echo 'Error: Optional NetworkManager installation entered the default setup.' >&2
    exit 1
fi

printf '%s\n' 'Menu dependency installer tests passed.'
