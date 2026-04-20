# Modern Unix tools

Faster, saner alternatives to classic Unix commands. All three have native Windows builds (Rust binaries) and are installed via Chocolatey.

## Install

```bash
choco install fd fzf zoxide -y
```

On Debian/Ubuntu/WSL:

```bash
sudo apt-get install fd-find fzf zoxide -y
```

Note: Debian ships `fd` as `fdfind`. The `bash_aliases` in this repo adds `alias fd='fdfind'`.

## fd — modern `find`

```bash
fd pattern                 # find in CWD
fd pattern /path           # find in given dir
fd -e md                   # find by extension
fd -t f pattern            # files only
fd -t d pattern            # directories only
fd -H pattern              # include hidden
```

Upside over `find`: sensible defaults, respects `.gitignore`, colorized, parallel, much faster on large trees.

## fzf — fuzzy finder

Keybindings (sourced automatically by the repo's bashrc/bash_aliases):

| Keys | Action |
|------|--------|
| `Ctrl+T` | Fuzzy file picker, pastes selection at cursor |
| `Ctrl+R` | Fuzzy history search |
| `Alt+C` | Fuzzy `cd` into subdirectory |

Piping pattern:

```bash
vim $(fd -t f | fzf)
cd $(fd -t d | fzf)
```

## zoxide — smarter `cd`

```bash
z foo          # jump to frecent dir matching "foo"
z foo bar      # jump to dir matching both
zi             # interactive (fzf) selection
z -            # jump back to previous dir
```

zoxide learns from your navigation and ranks directories by frecency (frequency × recency). One-time init via `eval "$(zoxide init bash)"` — already in this repo's dotfiles.

## Further reading

See [`tools/references/`](references/) (vendored) for a full A-Z Linux command reference and more alternative tools at [`modern-unix`](https://github.com/ibraheemdev/modern-unix).
