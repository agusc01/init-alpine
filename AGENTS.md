# Repository instructions

All content in this repository must be written in English.

- Use English for variable names, function names, filenames, comments, output messages, errors, and help text.
- Write README files, documentation, tests, configuration examples, commit messages, and pull request descriptions in English.
- Keep the repository specific to Alpine Linux. Do not add Debian/Ubuntu package-manager compatibility unless the project explicitly changes scope.
- Prefer clear, small installation scripts over framework-like module registries, dispatchers, or diagnostic systems.
- Use POSIX `sh` for bootstrapping so a fresh Alpine installation can run scripts without first installing Bash.
- Do not silently replace a user's existing configuration or change the root login shell.
- Keep package installation explicit and prefer Alpine's `apk` packages over Debian binaries.
- Use one `apk add` command per package on its own line so individual packages can be commented out easily. In ordinary user installers use `doas apk add PACKAGE`; in root-only bootstrap scripts use `apk add PACKAGE`.
- Add a short English comment beside each package installation explaining what the package provides or why it is needed. Prefer inline comments for easy reading and editing.
- Prefer verbose output for all commands whenever the command supports it, especially filesystem changes (`mkdir -vp`, `rmdir -v`, `rm -v`, `cp -v`, `mv -v`, and `ln -v`). Keep one filesystem target per command so individual operations are easy to comment out. Never add destructive flags such as `rm -rf` merely for convenience; protect intentional deletions and avoid overwriting user data.
- Assume the Alpine `community` repository is enabled; do not add temporary repository URL handling to ordinary installers.
