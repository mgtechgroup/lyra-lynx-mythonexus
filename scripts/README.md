# scripts/

Shell utilities for session management, logging, and automation.

## Contents

| Script | Purpose | Usage |
|--------|---------|-------|
| `session-log.sh` | Append JSON-line event to daily + audit logs | `bash scripts/session-log.sh <LEVEL> <event> [message]` |
| `auto-commit.sh` | Stage all changes and git commit with timestamp | `bash scripts/auto-commit.sh [message-prefix]` |
| `self-audit.sh` | 14-day capability/drift scan (existing) | `bash scripts/self-audit.sh` |

## Git Hooks

`session-log.sh` is called by `.git/hooks/post-commit` automatically after every commit.

## Adding New Scripts

- Must be executable (`chmod +x`)
- Must have a `set -euo pipefail` header
- Use `bash scripts/session-log.sh` for any significant events
- Add entry to this README
