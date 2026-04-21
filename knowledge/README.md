# knowledge/

Authoritative session-start context. Loaded by Claude Code at the start of every session via `CLAUDE.md`.

## Contents

| File | Purpose | Update frequency |
|------|---------|-----------------|
| `user-profile.md` | Working style, response preferences, durable directives | When preferences change |
| `environment.md` | OS, Python version, PATH, installed tools, known gotchas | After tool installs / env changes |
| `decisions.md` | Append-only log of architectural and workflow decisions | After each major decision |
| `patterns.md` | Recurring idioms: commit conventions, shell execution, file-write rules, pip rules | When new patterns are established |

## Usage

Files are loaded in order:
1. `user-profile.md`
2. `environment.md`
3. `decisions.md`
4. `patterns.md`

**Never edit `decisions.md` retroactively** — supersede with a new entry instead.
