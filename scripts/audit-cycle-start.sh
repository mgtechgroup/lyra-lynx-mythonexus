#!/usr/bin/env bash
# Day 1 of a 14-day cycle.
# 1. Select focus area (lowest score from previous cycle, or $FOCUS env override)
# 2. Run the focus-area intake
# 3. Create a 2-hour sprint plan in security/audit-cycles/<date>-<focus>.md
# 4. (The plan is then executed by the self-audit-orchestrator agent or a human)

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_DIR"

DATE="$(date +%Y-%m-%d)"
CYCLES_DIR="$REPO_DIR/security/audit-cycles"
mkdir -p "$CYCLES_DIR"

# Determine focus area
FOCUS="${FOCUS:-}"
if [[ -z "$FOCUS" ]]; then
    # Pick the lowest-scoring dimension from the most recent cycle log
    last_cycle="$(find "$CYCLES_DIR" -name "*.md" -print0 | xargs -0 -r ls -t 2>/dev/null | head -1)"
    if [[ -n "$last_cycle" && -f "$last_cycle" ]]; then
        FOCUS="$(grep -oE 'next-focus: [a-z]+' "$last_cycle" | head -1 | awk '{print $2}')"
    fi
    FOCUS="${FOCUS:-sec}"   # default to security for first cycle
fi

CYCLE_FILE="$CYCLES_DIR/$DATE-$FOCUS.md"

if [[ -f "$CYCLE_FILE" ]]; then
    echo "Cycle already started today: $CYCLE_FILE"
    exit 0
fi

echo "Starting cycle: focus = $FOCUS, file = $CYCLE_FILE"

# Run focus-area intake if one exists
INTAKE="$REPO_DIR/scripts/focus/$FOCUS.sh"
INTAKE_OUTPUT=""
if [[ -x "$INTAKE" ]]; then
    INTAKE_OUTPUT="$(bash "$INTAKE" 2>&1 || true)"
fi

cat > "$CYCLE_FILE" <<EOF
# Cycle: $DATE — focus: $FOCUS

Started: $DATE
Ended: (pending)
Duration: 14 days

## Focus

See \`security/focus-areas.md\` for the \`$FOCUS\` sprint goal.

## Day 1 intake

\`\`\`
${INTAKE_OUTPUT:-no intake script at $INTAKE}
\`\`\`

## Day 1 sprint plan (2-hour target)

- [ ] (fill in by orchestrator agent or user)

## Day 1 sprint execution log

(append here as work is done)

## Day 14 system-wide score

To be computed by \`scripts/audit-cycle-end.sh\`.

| Dimension | Score |
|-----------|-------|
| sec | |
| eff | |
| know | |
| tool | |
| agents | |
| deps | |
| docs | |
| perf | |
| **Overall** | |

## Day 14 improvements installed

(filled in by end-of-cycle script)

## Next cycle

next-focus: (lowest-scoring dimension above)
EOF

echo "Created $CYCLE_FILE"
echo
echo "Next: hand this file to the self-audit-orchestrator agent, or execute the sprint manually."
