---
description: Close the current cycle — score all dimensions, install improvements, promote agents
allowed-tools: ["Bash", "Read", "Write", "Edit"]
---

You are closing the current 14-day Lyra-Lynx capability cycle (Day-14 flow).

Steps:

1. Invoke the `self-audit-orchestrator` agent for the **Day-14** flow.

2. Run the close-out script:
   ```bash
   bash scripts/audit-cycle-end.sh
   ```
   This produces a close-out workspace (usually under `security/cycles/<cycle-id>/close/`). Read every file it emits.

3. Score each dimension according to `security/scoring-rubric.md`. The eight dimensions are: **Security, Efficiency, Knowledge, Tooling, Agents, Dependencies, Docs, Performance**. For each:
   - Give a 1-5 score with a one-line justification tied to evidence from this cycle.
   - Compute deltas against the prior cycle's scores.

4. Fill the cycle's score table (the close script lays out an empty table — populate it in place, don't create a parallel file).

5. Select improvements to install:
   - Rank candidate improvements by the **overall score impact** they would have (sum of dimensions they touch).
   - Install the top-ranked improvements whose prerequisites are already met. Skip any that would degrade another dimension below 3.

6. Promote agents:
   - Read every file under `agents/proposed/`. For each with `promote: yes` in the frontmatter AND evidence of use during the cycle, move it to `agents/` (top level) and flip the front-matter `status` to `promoted`.
   - Leave `promote: no` or unused agents in place.

7. Seed the next cycle's focus by writing a single line to the close-out summary: `next-focus: <id>` where `<id>` is the lowest-scoring dimension (tie-break: oldest unaddressed).

8. Print the final **CYCLE CLOSE** block: cycle id, final scores per dimension with deltas, list of installed improvements, list of promoted agents, next-focus id. This is the summary the user sees in chat; everything else lives on disk.
