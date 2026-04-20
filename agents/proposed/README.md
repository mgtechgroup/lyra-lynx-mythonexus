# Proposed agents

Agents staged here are **not active** — they're drafts waiting for promotion.

## Promotion flow

1. A workflow is observed recurring 3+ times without an agent.
2. The `self-audit-orchestrator` (or a user) drafts a file here using the standard agent format, plus one extra frontmatter field:
   ```yaml
   promote: no    # or "yes" when ready to ship
   ```
3. During the next 14-day cycle, the proposal accumulates triggering examples from real use.
4. When the system prompt is complete and examples are concrete, set `promote: yes`.
5. On Day 14, `scripts/audit-cycle-end.sh` moves `promote: yes` agents into `../` and strips the promotion field.

## Template

Copy this to start a new proposal:

```yaml
---
name: <short-hyphenated-name>
description: |
  Use this agent when ... Examples:
  <example>
    Context: ...
    user: "..."
    assistant: "..."
    <commentary>...</commentary>
  </example>
model: inherit
color: <pick one: blue|cyan|green|yellow|magenta|red>
tools: ["Read", "Bash"]
promote: no
---

You are ...

**Your Core Responsibilities:**
1. ...

**Analysis Process:**
1. ...

**Output Format:**
...

**Quality Standards:**
- ...

**Edge Cases:**
- ...
```

## What makes a good proposal

- **Concrete triggers.** At least 2 real example interactions from the observation log.
- **Narrow scope.** One coherent workflow, not a grab bag.
- **Least-privilege tools.** Only list tools the agent actually needs.
- **Testable output format.** The orchestrator can verify the agent produces the right shape.

Proposals that fail to meet these bars stay in this directory (or get deleted at user discretion).
