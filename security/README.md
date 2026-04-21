# security/

Security audit logs and scan configurations. Append-only policy on `audit-log.md`.

## Contents

| File/Dir | Purpose |
|----------|---------|
| `audit-log.md` | Append-only security event log — never edit, only append |
| `gitleaks.toml` | Gitleaks secret scan config (if present) |
| `semgrep/` | Semgrep rule overrides (if present) |

## Prime Directive

Run `security-gatekeeper` before every `git push`. The agent runs:
- **gitleaks** — secret detection
- **semgrep** — SAST
- **pip-audit** — dependency CVEs
- **shellcheck** — shell script safety

## Audit Log Format

```markdown
## YYYY-MM-DD HH:MM:SS UTC — <event-type>

- **Who**: <actor>
- **What**: <action>
- **Result**: <pass|fail|finding>
- **Notes**: <details>
```
