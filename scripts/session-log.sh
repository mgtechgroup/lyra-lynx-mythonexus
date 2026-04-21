#!/usr/bin/env bash
# Append a structured log entry to the session log.
# Usage: session-log.sh <level> <event> [message]
# Levels: INFO DEBUG WARN ERROR AUDIT
set -euo pipefail

LEVEL="${1:-INFO}"
EVENT="${2:-event}"
MESSAGE="${3:-}"
LOG_DIR="$(cd "$(dirname "$0")/.." && pwd)/logs"
LOG_FILE="$LOG_DIR/$(date +%Y-%m-%d).log"
AUDIT_FILE="$LOG_DIR/audit/$(date +%Y-%m).log"

mkdir -p "$LOG_DIR" "$LOG_DIR/audit"

ENTRY="$(printf '{"ts":"%s","level":"%s","event":"%s","host":"%s","msg":"%s"}\n' \
  "$(date -u +%Y-%m-%dT%H:%M:%SZ)" \
  "$LEVEL" \
  "$EVENT" \
  "$(hostname)" \
  "$MESSAGE")"

echo "$ENTRY" | tee -a "$LOG_FILE" >/dev/null

if [[ "$LEVEL" == "AUDIT" || "$LEVEL" == "ERROR" ]]; then
  echo "$ENTRY" >> "$AUDIT_FILE"
fi

echo "$ENTRY"
