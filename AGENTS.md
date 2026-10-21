# Repository instructions

All content in this repository must be written in English.

- Use English for variable names, function names, filenames, comments, output messages, errors, and help text.
- Write README files, documentation, tests, configuration examples, commit messages, and pull request descriptions in English.
- Keep the repository specific to Alpine Linux. Do not add Debian/Ubuntu package-manager compatibility unless the project explicitly changes scope.
- Prefer clear, small installation scripts over framework-like module registries, dispatchers, or diagnostic systems.
- Use POSIX `sh` for bootstrapping so a fresh Alpine installation can run scripts without first installing Bash.
- Do not silently replace a user's existing configuration or change the root login shell.
- Keep package installation explicit and prefer Alpine's `apk` packages over Debian binaries.
