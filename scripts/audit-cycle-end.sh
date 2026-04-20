#!/usr/bin/env bash
# Day 14 of a 14-day cycle.
# 1. Run intake for ALL focus areas (system-wide state snapshot)
# 2. Compute per-dimension scores (manual rubric application — orchestrator agent fills these)
# 3. Identify improvements to install based on overall score
# 4. Promote agent proposals that met their validation bar this cycle
# 5. Close the cycle file; seed the next cycle with the lowest-scoring dimension as focus

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_DIR"

DATE="$(date +%Y-%m-%d)"
CYCLES_DIR="$REPO_DIR/security/audit-cycles"

# Find the open cycle
OPEN_CYCLE="$(find "$CYCLES_DIR" -name "*.md" -print0 2>/dev/null | xargs -0 -r grep -l "Ended: (pending)" | head -1)"
if [[ -z "$OPEN_CYCLE" ]]; then
    echo "No open cycle found in $CYCLES_DIR"
    echo "Start one with: scripts/audit-cycle-start.sh"
    exit 0
fi

echo "Closing cycle: $OPEN_CYCLE"

# Run every intake script to produce a system-wide snapshot
SNAPSHOT_DIR="$CYCLES_DIR/$DATE-snapshot"
mkdir -p "$SNAPSHOT_DIR"

if [[ -d "$REPO_DIR/scripts/focus" ]]; then
    for f in "$REPO_DIR"/scripts/focus/*.sh; do
        [[ -f "$f" && -x "$f" ]] || continue
        id="$(basename "$f" .sh)"
        echo "  intake: $id"
        bash "$f" > "$SNAPSHOT_DIR/$id.txt" 2>&1 || true
    done
fi

# Promote eligible agent proposals
PROPOSED_DIR="$REPO_DIR/agents/proposed"
PROMOTED=0
if [[ -d "$PROPOSED_DIR" ]]; then
    for p in "$PROPOSED_DIR"/*.md; do
        [[ -f "$p" ]] || continue
        # Promotion criterion: file contains "promote: yes" in its frontmatter
        if grep -q "^promote: yes" "$p"; then
            name="$(basename "$p")"
            mv "$p" "$REPO_DIR/agents/$name"
            # Strip the promote: line on move
            sed -i '/^promote: yes/d' "$REPO_DIR/agents/$name"
            echo "  promoted: $name"
            PROMOTED=$((PROMOTED+1))
        fi
    done
fi

# Mark cycle closed
sed -i "s/^Ended: (pending)/Ended: $DATE/" "$OPEN_CYCLE"

echo
echo "Cycle closed: $OPEN_CYCLE"
echo "Snapshot:     $SNAPSHOT_DIR"
echo "Agents promoted this cycle: $PROMOTED"
echo
echo "Next: the self-audit-orchestrator agent fills the score table and installs improvements."
echo "Then start the next cycle:  scripts/audit-cycle-start.sh"
