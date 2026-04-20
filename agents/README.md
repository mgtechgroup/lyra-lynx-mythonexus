# The hive

This directory holds the collective of agents that encode workflows specific to this environment. Agents are autonomous, composable, and grow in number as new recurring workflows emerge.

## Active agents (v1)

| Agent | Color | Role |
|-------|-------|------|
| [`windows-env-auditor`](windows-env-auditor.md) | blue | Audits PATH, Python, declared tools; reports drift |
| [`repo-installer`](repo-installer.md) | cyan | Clones and installs arbitrary GitHub repos; Windows-aware |
| [`security-gatekeeper`](security-gatekeeper.md) | red | Runs scan stack; blocks Critical/High findings |
| [`self-audit-orchestrator`](self-audit-orchestrator.md) | magenta | Runs the 14-day capability-building cycle |

## How the hive grows

1. **Observation** — the `self-audit-orchestrator` watches for workflows that the user or Claude executes 3+ times without an agent.
2. **Proposal** — a draft agent is written to [`proposed/`](proposed/) with `promote: no` in frontmatter.
3. **Validation** — the proposal accumulates real triggering examples over the current cycle. If its system prompt is complete and examples are concrete, a user or the orchestrator flips `promote: yes`.
4. **Promotion** — on Day 14 of the cycle, `scripts/audit-cycle-end.sh` moves any `promote: yes` agents from `proposed/` to this directory and strips the promotion flag.
5. **Retirement** — agents that haven't fired in 3+ cycles get flagged for the user. If still unused, they move to an `archive/` directory at the end of a cycle.

## Adding an agent manually

```
agents/
├── <name>.md         # agent file with YAML frontmatter
```

Required frontmatter fields:

```yaml
---
name: <lowercase-hyphenated-3-to-50-chars>
description: |
  Use this agent when ... Examples:
  <example>
    Context: ...
    user: "..."
    assistant: "..."
    <commentary>...</commentary>
  </example>
model: inherit           # or sonnet/opus/haiku
color: <blue|cyan|green|yellow|magenta|red>
tools: ["Read", "Bash"]  # least-privilege; omit for all tools
---
```

Then the body is the system prompt, addressed to the agent in second person. See existing agents as a pattern guide, or `skill: plugin-dev:agent-development` for the full spec.

## Validation

The CI workflow `ci.yml → validate-agents` ensures every agent file has the required frontmatter before merge.
