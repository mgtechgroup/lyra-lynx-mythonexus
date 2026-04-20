# Environment

Last verified: 2026-04-20

## Host

- OS: Windows 11 Pro (26200)
- Shell: Git Bash (Unix syntax, `/c/Users/...` paths)
- WSL: Ubuntu (default distro, WSL2)

## Python

- Active: MS Store Python 3.13
  - site-packages is read-only; pip auto-falls-back to `--user`
- User scripts dir (in PATH):
  `~/AppData/Local/Packages/PythonSoftwareFoundation.Python.3.13_qbz5n2kfra8p0/LocalCache/local-packages/Python313/Scripts`
- Use `python -m pip` over bare `pip` (safer — pip.exe has previously been shadowed by a broken 3.14 install)

## Installed tools (relevant subset)

| Tool | Source | Notes |
|------|--------|-------|
| `fd` | Chocolatey | Modern `find` replacement |
| `fzf` | Chocolatey | Fuzzy finder (Ctrl+T, Ctrl+R, Alt+C in bash) |
| `zoxide` | Chocolatey | Smart `cd` — `z <name>` jumps to frecent dirs |
| `graphify` | pip editable install | Knowledge-graph builder, 20+ language parsers |
| `gh` | Preinstalled | GitHub CLI |
| Chocolatey | System | Primary Windows package manager |
| winget | System | Secondary package manager |

`scoop` is NOT installed — prefer Chocolatey or winget.

## Custom shell config

- Git Bash: `~/.bashrc` sourced (aliases, fzf, zoxide, prompt)
- WSL: `~/.bash_aliases` sourced via Ubuntu's stock `.bashrc`

## Known gotchas

- **PATH changes via registry** don't refresh in the current bash session. Use full paths or `python -m <module>` until a new terminal is opened.
- **Heredocs** (`cat > file << EOF`) trigger the Opsera pre-commit security gate even when not committing. Use the `Write` tool instead.
- **Windows filenames** can't contain `| < > : " ? *`. `git clone` fails the checkout on such files; use `git show HEAD:"<path>" > safe-name` to extract blobs.
- **`pip install -e .`** must run from the directory containing `pyproject.toml` (not a subdir with the same name as the package).
- **`choco install`** without `-y` hangs in non-interactive shells.
