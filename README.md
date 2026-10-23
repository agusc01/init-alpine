# init-alpine

Minimal, Alpine Linux-only system bootstrap and setup scripts.

## Bootstrap a fresh installation

After installing Alpine Linux, sign in as `root` and run:

```sh
wget -O /tmp/init-alpine-bootstrap.sh https://raw.githubusercontent.com/agusc01/init-alpine/main/bootstrap.sh && sh /tmp/init-alpine-bootstrap.sh
```

The script:

1. Installs `doas`, `git`, and `fish` using `apk`.
2. Prompts for a username, and creates the account with a password if it does not exist.
3. Sets Fish as the user's login shell, leaving the root shell unchanged.
4. Adds the user to the `wheel` group.
5. Grants `wheel` access through `doas`, requiring the user's password and allowing a short authentication cache.
6. Adds administrative directories to Fish's `PATH`, so `doas apk` works without typing `/sbin/apk`.

Sign out of the root session, then sign in as your regular user to load the new shell and group membership.

```sh
echo $SHELL
doas apk update
doas apk add vim
```

Run `sh bootstrap.sh` from a local checkout if you have already downloaded the repository. Re-running the bootstrap script for a configured user is supported.

**Note:** For an existing account that uses another shell, changing the login shell requires `chsh` from the Alpine `shadow` package, which is in the `community` repository. This extra package is not needed for newly created users. The script does not enable repositories automatically.

## Scope

`bootstrap.sh` only prepares an administrative user, Git, Fish, and doas. It does not install Xorg, dwm, applications, or unrelated packages.

## Repository language

All code, identifiers, comments, CLI messages, documentation, tests, and contribution materials must be written in English. See [AGENTS.md](AGENTS.md).

## Graphical status bar

The main `install.sh` installs [agusc01/dbar](https://github.com/agusc01/dbar) after dwm.
The `status/dbar/install.sh` module preserves existing checkouts and does not run
`git pull` automatically. It runs dbar's installer, which provides `xsetroot`
and the `dbar_*` commands. The dwm session starts dbar automatically when installed.

Standalone installation:

```sh
sh "$HOME/.config/init-alpine/status/dbar/install.sh"
```

## Menu engines (dmenu and fzf)

The main `install.sh` installs both selectable interfaces for the upcoming
[agusc01/menus](https://github.com/agusc01/menus) project:

- `fzf` is the optional-preview terminal selector from Alpine `community` and works without X11.
- The existing `suckless/dmenu/install.sh` builds and installs the
  [agusc01/dmenu](https://github.com/agusc01/dmenu) fork for X11.

Install or repair either engine without rerunning the entire desktop setup:

```sh
sh "$HOME/.config/init-alpine/menus/install.sh"
sh "$HOME/.config/init-alpine/suckless/dmenu/install.sh"
```

The `menus/install.sh` script in this repository installs the **fzf package only**.
It does not yet clone or configure `agusc01/menus` or `agusc01/sh`; their application
installers will be integrated once those repositories contain their first modules.
No `linux-tools`, `linux-setup` or `linux-doctor` dependency is used.

## Optional NetworkManager CLI backend

The default `basics/wifi/install.sh` still installs the existing Alpine Wi-Fi
utilities and `wpa_supplicant`. It does **not** switch network managers.

If you intend to migrate Wi-Fi controls to the `nmcli` backend, install its
packages **separately**, while connected through a working network:

```sh
sh "$HOME/.config/init-alpine/basics/wifi/networkmanager/install.sh"
command -v nmcli
```

This installs `networkmanager`, `networkmanager-cli`, `networkmanager-wifi`
and `networkmanager-openrc` from the enabled `community` repository. The
installer deliberately does **not** start, stop or enable services; no existing
network configuration or startup behavior is changed. Installing the CLI alone
does not make `nmcli` an operational Wi-Fi backend.

**Do not enable NetworkManager alongside an existing service managing the same
network interface.** Migrating the active network needs an explicit, separate,
tested plan (ideally from a local console, with rollback steps); see
[Alpine's NetworkManager guide](https://wiki.alpinelinux.org/wiki/NetworkManager).
The new `agusc01/sh` Wi-Fi implementation should detect a running/usable backend
and fail clearly instead of automatically changing the user's network manager.

To validate the package installers without changing host packages or services:

```sh "$HOME/.config/init-alpine/tests/menu-installers.sh"
```

## Fish and user-installed commands

The normal `install.sh` now runs `basics/core/configure.sh` to make sure
Fish can find user-installed executables in `~/.local/bin`. This is where
`agusc01/sh` and `agusc01/menus` install commands such as `wifi_status`,
`dmenu_wifi`, and `fzf_wifi`. The setup writes a separate, managed
`~/.config/fish/conf.d/90-init-alpine-local-bin.fish` file and **never edits**
`config.fish` or overwrites user-modified configuration.

On an existing Alpine installation, configure only the PATH without installing
other packages or rebooting:

```sh
sh "$HOME/.config/init-alpine/basics/core/configure.sh"
```

Open a new Fish shell, or update the current shell immediately:

```fish
fish_add_path -g "$HOME/.local/bin"
command -s wifi_status
wifi_status
```

This PATH setup does not install the `sh` or `menus` repositories; install
those commands separately using their own installers. It only makes already
installed user executables discoverable in Fish. To run isolated configuration
tests without modifying your PATH or user files:

```sh
sh tests/fish-local-bin.sh
```
