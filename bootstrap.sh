#!/bin/sh
# Prepare a regular Alpine user with Git, Fish, and doas.
set -eu

PATH="$PATH:/sbin:/usr/sbin:/usr/local/sbin"
export PATH

if [ "$(id -u)" -ne 0 ]; then
    echo "Error: run this script as root." >&2
    exit 1
fi

if [ ! -r /etc/os-release ]; then
    echo "Error: cannot identify the operating system." >&2
    exit 1
fi

. /etc/os-release
if [ "$ID" != "alpine" ]; then
    echo "Error: this bootstrap supports Alpine Linux only." >&2
    exit 1
fi

if [ ! -t 0 ]; then
    echo "Error: run this script from an interactive terminal." >&2
    exit 1
fi

printf "Username: "
IFS= read -r username

case "$username" in
    ''|root|*[!a-z0-9_-]*|-*|_*)
        echo "Error: invalid username." >&2
        exit 1
        ;;
    [a-z]*)
        ;;
    *)
        echo "Error: the username must start with a lowercase letter." >&2
        exit 1
        ;;
esac

if [ "${#username}" -gt 32 ]; then
    echo "Error: the username must contain at most 32 characters." >&2
    exit 1
fi

# Do not modify system accounts.
if id "$username" >/dev/null 2>&1; then
    user_id=$(id -u "$username")
    if [ "$user_id" -lt 1000 ]; then
        echo "Error: refusing to change a system account." >&2
        exit 1
    fi
fi

apk update
apk add doas
apk add git
apk add fish

fish_shell=$(command -v fish)
if [ ! -x "$fish_shell" ]; then
    echo "Error: the Fish executable was not found." >&2
    exit 1
fi

# A login shell must be listed in /etc/shells.
if ! grep -Fxq "$fish_shell" /etc/shells; then
    printf '%s\n' "$fish_shell" >> /etc/shells
fi

if id "$username" >/dev/null 2>&1; then
    current_shell=$(awk -F: -v name="$username" '$1 == name { print $7; exit }' /etc/passwd)
    if [ "$current_shell" != "$fish_shell" ]; then
        # chsh is only needed for existing accounts with another shell.
        if ! command -v chsh >/dev/null 2>&1; then
            echo "Changing an existing login shell requires the shadow package (community)."
            echo "The repository configuration will not be changed automatically."
            apk add shadow
        fi
        chsh -s "$fish_shell" "$username"
    fi
    echo "Existing user configured: $username"
else
    # Alpine's adduser prompts for the new user's password.
    adduser -h "/home/$username" -s "$fish_shell" "$username"
    echo "User created: $username"
fi

if ! id -nG "$username" | tr ' ' '\n' | grep -Fxq wheel; then
    adduser "$username" wheel
fi

# Keep these managed files separate from other administrators' settings.
ensure_config() {
    config_file=$1
    expected_content=$2

    if [ -L "$config_file" ] || { [ -e "$config_file" ] && [ ! -f "$config_file" ]; }; then
        echo "Error: unexpected configuration file: $config_file" >&2
        exit 1
    fi

    if [ -f "$config_file" ]; then
        if [ "$(cat "$config_file")" != "$expected_content" ]; then
            echo "Error: existing configuration differs: $config_file" >&2
            exit 1
        fi
    else
        printf '%s\n' "$expected_content" > "$config_file"
    fi
}

mkdir -p /etc/doas.d /etc/fish/conf.d

doas_config=/etc/doas.d/90-init-alpine-wheel.conf
ensure_config "$doas_config" 'permit persist :wheel'
chmod 600 "$doas_config"

# Fish must locate apk and other administrative commands.
fish_config=/etc/fish/conf.d/90-init-alpine-path.fish
ensure_config "$fish_config" 'fish_add_path -g /sbin /usr/sbin /usr/local/sbin'
chmod 644 "$fish_config"

echo
echo "Bootstrap completed for $username."
echo "Log out, then sign in as $username to activate Fish and wheel membership."
echo "After logging in, try: doas apk update"
