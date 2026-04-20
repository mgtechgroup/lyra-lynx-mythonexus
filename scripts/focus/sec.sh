#!/usr/bin/env bash
# Security intake: scan this repo + any sibling repos under ~ for Critical/High findings.
set -euo pipefail

echo "=== security intake: $(date +%Y-%m-%d) ==="
echo

echo "--- local repos ---"
# Any directory under $HOME that is a git repo
mapfile -t repos < <(find "$HOME" -maxdepth 3 -type d -name ".git" 2>/dev/null | sed 's#/\.git$##')
for r in "${repos[@]}"; do
    echo "  $r"
done

echo
echo "--- gitleaks (this repo) ---"
if command -v gitleaks >/dev/null 2>&1; then
    gitleaks detect --no-banner --config="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)/.gitleaks.toml" 2>&1 | tail -20 || true
else
    echo "gitleaks not installed"
fi

echo
echo "--- pip-audit ---"
if command -v pip-audit >/dev/null 2>&1; then
    pip-audit 2>&1 | tail -20 || true
else
    echo "pip-audit not installed"
fi

echo
echo "--- system updates available (winget) ---"
if command -v winget >/dev/null 2>&1; then
    winget upgrade 2>&1 | head -20 || true
fi
