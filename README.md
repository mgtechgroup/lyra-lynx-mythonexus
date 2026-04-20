# Lyra-Lynx MythoNexus

A portable knowledge system, dotfiles, and Claude Code plugin that keeps my development environment coherent across machines and AI sessions.

## What this is

A single repository that serves three purposes simultaneously:

1. **Knowledge base** — durable context about my environment, preferences, and decisions that Claude Code loads at session start, reducing repeated clarifying questions.
2. **Dotfiles & toolkit** — version-controlled shell configs, installation scripts, and modern Unix tool setups (fd, fzf, zoxide, graphify).
3. **Claude Code plugin** — custom agents (`windows-env-auditor`, `repo-installer`, `security-gatekeeper`) that encode repeatable workflows.

## Layout

```
.
├── agents/          Claude Code plugin agents (auto-discovered)
├── dotfiles/        Bash configs, gitconfig, install script
├── knowledge/       Durable context Claude reads at session start
├── security/        Hardening baseline + audit log
├── scripts/         Automation (memory sync, security scan, bootstrap)
├── tools/           Install/config docs for external tools
└── .claude-plugin/  Plugin manifest
```

## Quick start

```bash
git clone https://github.com/<owner>/lyra-lynx-mythonexus.git ~/lyra-lynx-mythonexus
cd ~/lyra-lynx-mythonexus
./scripts/bootstrap.sh
```

Then add a reference in your global `~/.claude/CLAUDE.md`:

```markdown
# Knowledge base
- Load context from `~/lyra-lynx-mythonexus/knowledge/` at session start.
```

## Security posture

- **Public repo, zero secrets** — enforced by `gitleaks` pre-commit hook and CI.
- **Every commit scanned** — `semgrep`, `pip-audit`, `gitleaks` in CI; findings gate merges.
- **Sanitized knowledge** — `scripts/sync-memory.sh` strips usernames, absolute paths, tokens, and emails before any commit.
- **Signed commits** — templated in `dotfiles/gitconfig`.
- **Audit trail** — every scan logged in `security/audit-log.md`.

See [`security/baseline.md`](security/baseline.md) for the full hardening checklist.

## License

MIT. See [`LICENSE`](LICENSE).
