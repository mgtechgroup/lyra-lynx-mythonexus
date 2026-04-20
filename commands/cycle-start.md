---
description: Start a new 14-day capability-building cycle
argument-hint: "[focus-id: sec|eff|know|tool|agents|deps|docs|perf]"
allowed-tools: ["Bash", "Read", "Write", "Edit"]
---

You are opening a new 14-day Lyra-Lynx capability cycle (Day-1 flow).

**Focus hint:** `$ARGUMENTS` — one of `sec`, `eff`, `know`, `tool`, `agents`, `deps`, `docs`, `perf`. Empty is allowed; the orchestrator will pick.

Steps:

1. Invoke the `self-audit-orchestrator` agent for the **Day-1** flow.

2. Run the cycle bootstrap script. If `$ARGUMENTS` is non-empty, export it first:
   ```bash
   if [ -n "$ARGUMENTS" ]; then
     FOCUS="$ARGUMENTS" bash scripts/audit-cycle-start.sh
   else
     bash scripts/audit-cycle-start.sh
   fi
   ```

3. The script creates/updates a cycle file under `security/cycles/` (or the location the script prints). Read that file.

4. Present to the user:
   - **Intake summary** — what the orchestrator observed about the current repo state (scores from last cycle, open carry-overs, the chosen focus).
   - **2-hour sprint plan** — the concrete tasks the orchestrator proposes for the first working session. Numbered, with estimated time per task.

5. End with a direct question: **"Execute the 2-hour sprint now?"** Do not start any sprint work until the user answers.

Keep the presentation tight — the cycle file holds the full detail; the chat only needs the summary and the plan.
