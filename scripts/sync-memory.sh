#!/usr/bin/env bash
# Knowledge Synthesizer: Evolves raw memory files into durable environment patterns.
# 
# Workflow:
# 1. Sanitize raw memory files (Strip PII/Secrets).
# 2. Stage for synthesis.
# 3. If --synthesize is passed, it creates a 'synthesis-prompt.md' that can be fed to an LLM 
#    to extract new idioms for patterns.md.
#
# Safety: dry-run by default. Pass --apply to write sanitized files; --synthesize to generate prompt.

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
MEMORY_DIR="${CLAUDE_MEMORY_DIR:-$HOME/.claude/projects}"
OUT_DIR="$REPO_DIR/knowledge"
STAGE_DIR="$(mktemp -d)"
APPLY=0
SYNTHESIZE=0

for arg in "$@"; do
    case "$arg" in
        --apply) APPLY=1 ;;
        --synthesize) SYNTHESIZE=1 ;;
        --help)  echo "Usage: $0 [--apply] [--synthesize]"; exit 0 ;;
    esac
done

if [[ ! -d "$MEMORY_DIR" ]]; then
    echo "No memory dir found at $MEMORY_DIR (set CLAUDE_MEMORY_DIR to override)"
    exit 0
fi

echo "Scanning $MEMORY_DIR ..."
mapfile -t files < <(find "$MEMORY_DIR" -type f -name "*.md" 2>/dev/null)

if [[ ${#files[@]} -eq 0 ]]; then
    echo "No memory files found."
    exit 0
fi

sanitize() {
    # Strip Windows and POSIX user paths
    sed -E 's#([A-Za-z]:/Users/[^/]+/|/c/Users/[^/]+/|/home/[^/]+/)#~/#g' | \
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

if [[ $SYNTHESIZE -eq 1 ]]; then
    PROMPT_FILE="$OUT_DIR/synthesis-prompt.md"
    {
        echo "# Memory Synthesis Request"
        echo "Analyze the following sanitized session memories and extract recurring idioms, technical gotchas, or environment conventions."
        echo "Format the output as markdown additions for \`patterns.md\`."
        echo "Only include high-confidence, reusable patterns. Skip one-off bug fixes."
        echo "---"
        for sfile in "$STAGE_DIR"/*.md; do
            echo "## File: $(basename "$sfile")"
            cat "$sfile"
            echo "---"
        done
    } > "$PROMPT_FILE"
    echo "Synthesis prompt generated: $PROMPT_FILE"
fi

if [[ $APPLY -eq 0 ]]; then
    echo
    echo "DRY RUN — no changes written to $OUT_DIR/memory-sync"
    echo "Review the staged files above, then re-run with --apply"
    exit 0
fi

DEST="$OUT_DIR/memory-sync"
mkdir -p "$DEST"
cp "$STAGE_DIR"/*.md "$DEST/" 2>/dev/null || true
echo "Promoted $total file(s) -> $DEST"
rm -rf "$STAGE_DIR"
