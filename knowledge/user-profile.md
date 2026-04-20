# User profile

## Working style

- **Pragmatic and fast-moving.** Prefers end-to-end execution over multi-step approval gates once a design is agreed.
- **Explicit preference:** "less dependent on clarifying questions" — when in doubt, propose a concrete design with a recommended option rather than asking open-ended questions.
- **Security-conscious.** Runs multiple scanning layers (Opsera, CodeRabbit, Aikido, Semgrep, SonarQube). Assume all code lands in scanned CI.
- **Model-flexible.** Switches between Sonnet, Opus, and Haiku within sessions; code must be portable across model capabilities.

## Response preferences

- Short, information-dense answers
- Concrete file paths, line numbers, commands — not prose
- Proposes A/B/C options with a clear recommendation before implementation
- Avoid narration of internal deliberation; state decisions and results directly

## Repos of interest

- `safishamsi/graphify` — knowledge-graph builder (installed locally)
- `trinib/Linux-Bash-Commands` — command reference (vendored under `tools/references/`)

## Durable directives (set by user, applies to all sessions)

- Security audits, hardening, and accuracy are prime focus at all times
- Maintain persistent memory across sessions via this repo's `knowledge/` + local memory files
- Keep this repo public and version-controlled on GitHub
- Run self-audits every 14 days (see `scripts/self-audit.sh` + scheduled workflow)
