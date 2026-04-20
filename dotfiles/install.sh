#!/usr/bin/env bash
# Install dotfiles into the current user's home directory.
# Works in Git Bash (Windows) and native Linux/WSL.
# Backs up existing files to ~/.dotfiles-backup-<timestamp>/

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TS="$(date +%Y%m%d-%H%M%S)"
BACKUP="$HOME/.dotfiles-backup-$TS"

detect_env() {
    if [[ -n "${WSL_DISTRO_NAME:-}" ]] || grep -qi microsoft /proc/version 2>/dev/null; then
        echo "wsl"
    elif [[ "${OSTYPE:-}" == msys* ]] || [[ "${OSTYPE:-}" == cygwin* ]]; then
        echo "gitbash"
    else
        echo "linux"
    fi
}

link_or_copy() {
    local src="$1" dest="$2"
    if [[ -e "$dest" || -L "$dest" ]]; then
        mkdir -p "$BACKUP"
        mv "$dest" "$BACKUP/"
        echo "  backed up existing $dest"
    fi
    cp "$src" "$dest"
    echo "  installed $dest"
}

ENV="$(detect_env)"
echo "Detected environment: $ENV"
echo "Repo: $REPO_DIR"
echo

case "$ENV" in
    gitbash)
        echo "Installing Git Bash dotfiles..."
        link_or_copy "$REPO_DIR/dotfiles/bashrc" "$HOME/.bashrc"
        ;;
    wsl|linux)
        echo "Installing Linux/WSL dotfiles..."
        link_or_copy "$REPO_DIR/dotfiles/bash_aliases" "$HOME/.bash_aliases"
        ;;
esac

# gitconfig: only install if user doesn't have one already
if [[ ! -f "$HOME/.gitconfig" ]]; then
    link_or_copy "$REPO_DIR/dotfiles/gitconfig" "$HOME/.gitconfig"
    echo
    echo "NOTE: ~/.gitconfig template installed — edit to add your [user] name/email."
else
    echo
    echo "~/.gitconfig already exists — not overwriting. See dotfiles/gitconfig for reference."
fi

echo
echo "Done. Backup (if any) at: $BACKUP"
echo "Reopen your shell or run: source ~/.bashrc (or ~/.bash_aliases for WSL)"
