# CLAUDE.md

Instructions for Claude Code when working in this repository.

## Priority reading order

On session start in this repo, load these files before responding to the user:

1. `knowledge/environment.md` — current system fingerprint (OS, Python, installed tools, PATH)
2. `knowledge/user-profile.md` — how the user prefers to work
3. `knowledge/decisions.md` — durable choices already made ("option B was chosen for X because Y")
4. `knowledge/patterns.md` — recurring idioms and conventions

If any of the above contradicts what you observe in the live system, **trust what you observe** and update the relevant knowledge file in the same session.

## Working rules in this repo

- **No secrets ever.** Run `scripts/scan.sh` before any `git commit` that touches new files. CI will reject pushes with gitleaks findings.
- **Sanitize before committing knowledge.** Use `scripts/sync-memory.sh` to promote local memory into `knowledge/` — never copy raw memory files. The sync script strips usernames, absolute paths, tokens, and emails.
- **Append, don't rewrite** `security/audit-log.md`. Every entry is timestamped and immutable.
- **Agents are authoritative for their workflow.** If a task matches an agent's triggering examples (see `agents/*.md`), invoke the agent via the `Task` tool instead of executing the workflow manually.

## Agents available in this plugin

- `windows-env-auditor` — audits Windows/Python PATH state, flags broken installs, reports drift
- `repo-installer` — handles the clone → install workflow for arbitrary GitHub repos (Windows-aware)
- `security-gatekeeper` — runs gitleaks + semgrep + pip-audit, blocks on Critical/High findings

## Commit discipline

- Never skip pre-commit hooks (`--no-verify`) unless the user explicitly asks
- Commit messages follow conventional commits: `feat:`, `fix:`, `chore:`, `docs:`, `sec:`
- Sign commits when the gitconfig has a signing key configured (see `dotfiles/gitconfig`)
