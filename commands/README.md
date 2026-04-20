# lyra-lynx-mythonexus / commands

Slash commands for the `lyra-lynx-mythonexus` Claude Code plugin. Each command is a markdown file with YAML frontmatter (`description`, optional `argument-hint`, optional `allowed-tools`) plus a body that is sent to the model as the prompt when the slash command fires.

## Command index

| Command | Routes through | Purpose |
|---|---|---|
| `/audit [pre-push\|pre-commit\|manual]` | `security-gatekeeper` agent | Full-tree security scan, NEW-vs-EXISTING categorization, appends `security/audit-log.md`, prints SECURITY GATE block. |
| `/cycle-start [focus-id]` | `self-audit-orchestrator` agent | Day-1 of a 14-day cycle. Runs `scripts/audit-cycle-start.sh`, presents intake summary + 2-hour sprint plan, asks whether to execute. |
| `/cycle-end` | `self-audit-orchestrator` agent | Day-14 close-out. Runs `scripts/audit-cycle-end.sh`, scores 8 dimensions, installs improvements, promotes `promote: yes` agents, seeds next focus. |
| `/install-repo <github-url>` | `repo-installer` agent | Windows-aware clone + install. Handles filename restrictions, detects stack, verifies binary on PATH. |
| `/env-audit` | `windows-env-auditor` agent | PATH / Python / declared-tool drift report against `knowledge/environment.md`. Read-only. |
| `/propose-agent <description>` | Inline (writes `agents/proposed/<name>.md`) | Drafts a new agent proposal with `promote: no`, using the format from `agents/proposed/README.md`. Requires at least 2 user-provided triggering examples. |
| `/sync-memory [--apply]` | Inline (runs `scripts/sync-memory.sh`) | Sanitizes `~/.claude` memory into `knowledge/memory-sync/`. Dry-run by default; `--apply` writes. Reminds user to review before commit. |
| `/knowledge` | Inline (no agent) | Reads the knowledge-base files in priority order and returns a 5-8 bullet synthesis. |

## Least-privilege note

Each command's frontmatter declares `allowed-tools`. When a command routes through an agent, the **agent's** declared tool list takes precedence — the command cannot grant an agent access beyond what the agent itself is allowed. `allowed-tools` in the command frontmatter acts as an upper bound on what the command's top-level prompt can do before delegating.

## Adding a new command

1. Create `commands/<name>.md`. The filename (without `.md`) is the slash command.

2. Frontmatter fields:
   - `description` — one-line shown in the `/` menu. Required.
   - `argument-hint` — placeholder text shown after the command name. Optional.
   - `allowed-tools` — YAML list of tool names. Optional (default: full tool set). Keep this as tight as the command needs.

3. `$ARGUMENTS` in the body expands to everything the user typed after the command name. If the command takes no args, omit `argument-hint` and don't reference `$ARGUMENTS`.

4. **Route to an agent when the workflow is reusable.** If the same logic exists as an agent in `agents/`, the command body should just invoke that agent and summarize its output. Don't duplicate agent logic inline — when the agent changes, the command should stay correct.

5. **Keep logic inline only when it's command-specific.** `/knowledge` and `/sync-memory` are inline because there's no agent boundary worth crossing: one is a read-and-summarize, the other is a shell-script wrapper.

6. Convention: the body should end by describing exactly **what the user sees in chat** (a named output block like `SECURITY GATE`, `REPO INSTALL`, `CYCLE CLOSE`). Everything else belongs on disk in the repo, not in the transcript.
