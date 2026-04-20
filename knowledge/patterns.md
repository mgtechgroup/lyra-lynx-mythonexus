# Patterns

Recurring idioms, conventions, and workflows used in this environment.

## Commit messages

Conventional commits: `<type>: <subject>`

- `feat:` new feature
- `fix:` bug fix
- `chore:` maintenance, deps, tooling
- `docs:` documentation only
- `sec:` security-related changes
- `refactor:` non-behavioral code changes
- `test:` test additions/changes

## Shell execution in Windows

- Prefer `/c/Users/<user>/...` over `C:/Users/<user>/...` in Git Bash
- Use `powershell -Command "..."` only when PowerShell-specific APIs are needed (e.g., `[System.Environment]::SetEnvironmentVariable`)
- Use `python -m <module>` over bare binary names when PATH propagation is uncertain

## File writes

- Always use the `Write` tool for files with shell-sensitive content (heredocs trigger the Opsera security hook)
- Use `Edit` for diffs against existing files; `Write` for new files or complete rewrites
- Never hand-craft multi-line files via `echo` or `cat` in Bash

## Git operations in Windows

- `git clone` may fail checkout on files with OS-illegal names (`| < > : " ? *`)
- Workaround: `git show HEAD:"<path>" > <safe-name>`
- `core.autocrlf = input` in gitconfig to keep LF line endings in the repo

## Pip on Windows

- Always run from the dir containing `pyproject.toml`, not a subdir
- `pip install -e .` installs into user scripts dir (read-only system Python)
- Check that the user scripts dir is first in PATH

## Package install verification sequence

1. `<tool> --version` to confirm install
2. `which <tool>` (or `type <tool>`) to confirm shim resolves
3. Minimal invocation to confirm runtime dependencies exist
