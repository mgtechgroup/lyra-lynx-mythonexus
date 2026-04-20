#!/usr/bin/env bash
# Sanitize Claude's local memory dir and promote durable learnings into knowledge/.
# NEVER copies raw memory files — always strips personal identifiers.
#
# Sanitization:
#   - Absolute Windows user paths:  C:\Users\<name>\   -> ~/
#   - Absolute POSIX user paths:    /home/<name>/      -> ~/
#   - Email addresses:              redacted
#   - Common token formats:         redacted
#
# Safety: dry-run by default. Pass --apply to write changes.

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
MEMORY_DIR="${CLAUDE_MEMORY_DIR:-$HOME/.claude/projects}"
OUT_DIR="$REPO_DIR/knowledge"
STAGE_DIR="$(mktemp -d)"
APPLY=0

for arg in "$@"; do
    case "$arg" in
        --apply) APPLY=1 ;;
        --help)  echo "Usage: $0 [--apply]"; exit 0 ;;
    esac
done

if [[ ! -d "$MEMORY_DIR" ]]; then
    echo "No memory dir found at $MEMORY_DIR (set CLAUDE_MEMORY_DIR to override)"
    exit 0
fi

echo "Scanning $MEMORY_DIR ..."

# Collect all memory markdown files
mapfile -t files < <(find "$MEMORY_DIR" -type f -name "*.md" 2>/dev/null)

if [[ ${#files[@]} -eq 0 ]]; then
    echo "No memory files found."
    exit 0
fi

echo "Found ${#files[@]} memory file(s). Sanitizing..."

sanitize() {
    # Strip Windows user paths
    sed -E 's#([A-Za-z]:\\\\Users\\\\[^\\\\]+\\\\|[A-Za-z]:/Users/[^/]+/|/c/Users/[^/]+/|/home/[^/]+/)#~/#g' | \
    # Redact email addresses
    sed -E 's#[[:alnum:]_.+-]+@[[:alnum:]-]+\.[[:alnum:].-]+#<email-redacted>#g' | \
    # Redact GitHub tokens
    sed -E 's#gh[pousr]_[A-Za-z0-9]{20,}#<token-redacted>#g' | \
    # Redact AWS keys
    sed -E 's#AKIA[A-Z0-9]{16}#<aws-key-redacted>#g' | \
    # Redact long base64-ish secrets (40+ chars)
    sed -E 's#([A-Za-z0-9+/]{40,}={0,2})#<secret-redacted>#g'
}

total=0
for f in "${files[@]}"; do
    rel="$(realpath --relative-to="$MEMORY_DIR" "$f")"
    out="$STAGE_DIR/$(echo "$rel" | tr '/' '_')"
    sanitize < "$f" > "$out"
    total=$((total+1))
done

echo "$total file(s) sanitized into staging: $STAGE_DIR"

if [[ $APPLY -eq 0 ]]; then
    echo
    echo "DRY RUN — no changes written to $OUT_DIR"
    echo "Review the staged files above, then re-run with --apply"
    echo "(staging dir will remain on disk for inspection)"
    exit 0
fi

# Apply: move sanitized files into knowledge/memory-sync/
DEST="$OUT_DIR/memory-sync"
mkdir -p "$DEST"
cp "$STAGE_DIR"/*.md "$DEST/" 2>/dev/null || true
echo "Promoted $total file(s) -> $DEST"
rm -rf "$STAGE_DIR"
