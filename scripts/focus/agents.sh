#!/usr/bin/env bash
# Agent-coverage intake: count agents in main + proposed, and list recurring
# workflows that might warrant a new agent.
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

echo "=== agent coverage intake: $(date +%Y-%m-%d) ==="
echo

main_count=$(find "$REPO_DIR/agents" -maxdepth 1 -name "*.md" -type f 2>/dev/null | wc -l)
proposed_count=$(find "$REPO_DIR/agents/proposed" -maxdepth 1 -name "*.md" -type f 2>/dev/null | wc -l)

echo "Active agents:    $main_count"
echo "Proposed agents:  $proposed_count"
echo

echo "--- active agents ---"
find "$REPO_DIR/agents" -maxdepth 1 -name "*.md" -type f -exec basename {} \; 2>/dev/null | sort
echo

echo "--- proposed agents (awaiting promotion) ---"
find "$REPO_DIR/agents/proposed" -maxdepth 1 -name "*.md" -type f -exec basename {} \; 2>/dev/null | sort
echo

echo "--- recent manual workflows (git log mentions) ---"
# Look for commit messages that reference manual toil that might warrant automation
cd "$REPO_DIR"
git log --since="14 days ago" --pretty=format:'%s' 2>/dev/null \
    | grep -iE 'manually|repeat|again|boilerplate|tedious' || echo "  (none detected)"
