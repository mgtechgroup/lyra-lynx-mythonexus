#!/usr/bin/env bash
# Tooling intake: verify declared tools are installed + PATH is clean.
set -euo pipefail

echo "=== tooling intake: $(date +%Y-%m-%d) ==="
echo

echo "--- declared tools ---"
for tool in python pip gh git fd fzf zoxide choco winget shellcheck gitleaks semgrep; do
    if command -v "$tool" >/dev/null 2>&1; then
        version=$("$tool" --version 2>&1 | head -1)
        printf "  [ok]      %-12s %s\n" "$tool" "$version"
    else
        printf "  [missing] %-12s\n" "$tool"
    fi
done

echo
echo "--- PATH integrity ---"
IFS=':' read -ra paths <<< "$PATH"
for p in "${paths[@]}"; do
    # In Git Bash, convert /c/... to C:\... for existence check
    host_p="${p/#\/c\//C:/}"
    host_p="${host_p/#\/d\//D:/}"
    if [[ -d "$p" ]] || [[ -d "$host_p" ]]; then
        :
    else
        echo "  [broken]  $p"
    fi
done
