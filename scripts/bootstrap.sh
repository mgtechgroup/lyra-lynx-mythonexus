#!/usr/bin/env bash
# One-command setup for a new machine.
# Installs dotfiles, modern unix tools, and pre-commit hooks.

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_DIR"

echo "==> Detecting environment"
if grep -qi microsoft /proc/version 2>/dev/null; then
    ENV="wsl"
elif [[ "${OSTYPE:-}" == msys* ]] || [[ "${OSTYPE:-}" == cygwin* ]]; then
    ENV="gitbash"
else
    ENV="linux"
fi
echo "  $ENV"

echo
echo "==> Installing dotfiles"
bash "$REPO_DIR/dotfiles/install.sh"

echo
echo "==> Installing modern unix tools"
case "$ENV" in
    gitbash)
        if command -v choco >/dev/null 2>&1; then
            choco install fd fzf zoxide gitleaks shellcheck -y
        else
            echo "  Chocolatey not found — install from https://chocolatey.org/install"
        fi
        ;;
    wsl|linux)
        if command -v apt-get >/dev/null 2>&1; then
            sudo apt-get update
            sudo apt-get install -y fd-find fzf zoxide shellcheck
            # gitleaks via pre-built binary
            if ! command -v gitleaks >/dev/null 2>&1; then
                echo "  Install gitleaks manually: https://github.com/gitleaks/gitleaks/releases"
            fi
        fi
        ;;
esac

echo
echo "==> Installing pre-commit hooks"
if command -v pre-commit >/dev/null 2>&1 || python -m pip show pre-commit >/dev/null 2>&1; then
    :
else
    python -m pip install pre-commit
fi
python -m pre_commit install || pre-commit install

echo
echo "==> Bootstrap complete."
echo
echo "Next steps:"
echo "  1. Add a reference in ~/.claude/CLAUDE.md:"
echo "     Load context from $REPO_DIR/knowledge/ at session start."
echo "  2. Reopen your terminal so PATH changes apply."
echo "  3. Run scripts/self-audit-phase1.sh to generate the first security plan."
