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
- When creating directories, use one `mkdir -vp PATH` command per directory on its own line. Always enable verbose output and avoid combining multiple directories into one command, so individual lines can be commented out easily.
- Assume the Alpine `community` repository is enabled; do not add temporary repository URL handling to ordinary installers.
