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
