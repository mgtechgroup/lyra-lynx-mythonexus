#!/usr/bin/env bash
# Auto-commit any staged or unstaged changes with a timestamped message.
# Intended for use in cron, hooks, or manual runs.
# Usage: auto-commit.sh [optional message prefix]
set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")/.." && pwd)"
PREFIX="${1:-chore}"
TIMESTAMP="$(date -u +%Y-%m-%dT%H:%M:%SZ)"

cd "$REPO_DIR"

if git diff --quiet && git diff --staged --quiet; then
  echo "Nothing to commit at $TIMESTAMP"
  exit 0
fi

git add -A
git commit -m "$PREFIX: auto-commit $TIMESTAMP

Co-Authored-By: Claude Sonnet 4.6 <noreply@anthropic.com>"

bash "$(dirname "$0")/session-log.sh" AUDIT git_auto_commit "committed at $TIMESTAMP"
echo "Auto-committed at $TIMESTAMP"
