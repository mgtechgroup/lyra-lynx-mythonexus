---
description: Draft an agent proposal in agents/proposed/ for a recurring workflow
argument-hint: "<short workflow description>"
allowed-tools: ["Read", "Write", "Edit", "Grep", "Glob"]
---

You are drafting a new agent proposal for a recurring workflow.

**Workflow description:** `$ARGUMENTS`

If `$ARGUMENTS` is empty, ask the user for a short description before proceeding.

Steps:

1. Read `agents/proposed/README.md` to get the exact proposal format (frontmatter fields, body sections, required headings). Follow it — do not invent a new format.

2. Ask the user for **at least 2 concrete triggering examples** — real moments in past sessions where this agent would have helped. Wait for the answer; the proposal is weaker without them.

3. Derive a short, kebab-case agent name from `$ARGUMENTS`. Examples:
   - "scan pull requests for missing tests" → `pr-test-coverage-scanner`
   - "sync notion tasks from commits" → `commit-to-notion-syncer`
   Check `agents/` and `agents/proposed/` first to avoid collisions. If a collision exists, suffix `-v2` or pick a more specific name.

4. Write the proposal to `agents/proposed/<name>.md`. Frontmatter MUST include:
   - `name: <name>`
   - `status: proposed`
   - `promote: no`
   - Any other fields required by `agents/proposed/README.md`

   Body MUST include:
   - One-paragraph purpose (based on `$ARGUMENTS`)
   - **Triggering examples** section with the user's examples, quoted verbatim and annotated with what the agent would have done at that moment
   - Proposed tool list (least-privilege — only what the workflow actually needs)
   - Success criteria for promotion (what "`promote: yes`" would require)

5. Do NOT promote. Do NOT move the file out of `agents/proposed/`. Do NOT edit `agents/` top level.

6. Report back: the file path written, the chosen agent name, and a one-line summary of the triggering evidence collected.
