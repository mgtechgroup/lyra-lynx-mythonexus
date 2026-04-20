#!/usr/bin/env bash
# Run the full security scan stack against the repo.
# Exits non-zero if any scanner reports findings.

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_DIR"

echo "==> gitleaks"
if command -v gitleaks >/dev/null 2>&1; then
    gitleaks detect --no-banner --config=.gitleaks.toml --verbose || { echo "gitleaks found issues"; exit 1; }
else
    echo "  gitleaks not installed — run: choco install gitleaks"
fi

echo
echo "==> semgrep"
if command -v semgrep >/dev/null 2>&1; then
    semgrep scan --config=p/default --config=p/secrets --config=p/bash --error
else
    echo "  semgrep not installed — run: python -m pip install semgrep"
fi

echo
echo "==> pip-audit (if any Python project files present)"
if command -v pip-audit >/dev/null 2>&1; then
    if find . -name "requirements*.txt" -o -name "pyproject.toml" | grep -q .; then
        pip-audit -r <(find . -name "requirements*.txt" -print0 | xargs -0 cat 2>/dev/null) 2>/dev/null || true
    else
        echo "  no Python dependency files found"
    fi
else
    echo "  pip-audit not installed — run: python -m pip install pip-audit"
fi

echo
echo "==> shellcheck (scripts + dotfiles)"
if command -v shellcheck >/dev/null 2>&1; then
    find scripts dotfiles -type f \( -name "*.sh" -o -name "bashrc" -o -name "bash_aliases" \) -print0 \
        | xargs -0 -r shellcheck -x
else
    echo "  shellcheck not installed — run: choco install shellcheck"
fi

echo
echo "All scans complete."
