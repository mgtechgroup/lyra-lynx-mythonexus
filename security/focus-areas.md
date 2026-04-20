# Focus areas

The 14-day capability-building cycle rotates through these focus areas. Each cycle picks **one** (the orchestrator selects based on the lowest system-wide score from the previous cycle, or explicit user override).

New focus areas can be added by appending to this file. Each area gets its own section with intake, sprint, and scoring rubric.

| ID | Area | Day-1 sprint goal | Scoring dimension |
|----|------|---------------------|-------------------|
| `sec` | Security | Map vulns across all local repos + close them | % of Critical/High findings resolved |
| `eff` | Efficiency | Identify redundant workflows + automate or alias them | Wall-clock saved per week (estimated) |
| `know` | Knowledge | Fill gaps in `knowledge/` + add new decisions | Coverage % against known environment facts |
| `tool` | Tooling | Install/upgrade/prune tools; align versions across Git Bash + WSL | Tool drift count |
| `agents` | Agent coverage | Identify workflows that recurred >= 3 times without an agent, propose new agents in `agents/proposed/` | Uncovered recurring workflows |
| `deps` | Dependency hygiene | Run `pip-audit`, `npm audit`, `dependabot` review; patch outdated | Count of outdated / vulnerable deps |
| `docs` | Documentation | Audit README/CLAUDE/knowledge against reality; fix drift | Stale doc count |
| `perf` | Performance | Profile slow scripts/commands; apply optimizations | p95 runtime of tracked scripts |

## Adding a new focus area

1. Append a row above with a short `id` and a sprint goal.
2. Add a rubric section to `security/scoring-rubric.md` describing how this dimension is scored 0-100.
3. Add an intake script under `scripts/focus/<id>.sh` that gathers current state.
4. (Optional) Add a dedicated agent under `agents/` to handle this focus area autonomously.

## Cycle history

Each cycle logs itself to `security/audit-cycles/<YYYY-MM-DD>-<focus-id>.md`.
