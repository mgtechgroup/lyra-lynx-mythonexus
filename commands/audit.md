---
description: Run security-gatekeeper on the current repo (full scan, not just diff)
argument-hint: "[pre-push|pre-commit|manual]"
allowed-tools: ["Bash", "Read", "Edit", "Grep", "Glob"]
---

You are running a full repository security audit.

**Trigger:** `$ARGUMENTS` (default to `manual` if empty)

Steps:

1. Invoke the `security-gatekeeper` agent with the trigger above. Do NOT limit the scan to the current diff — run the full scan stack across the entire working tree.

2. Have the agent execute its complete scan pipeline:
   - Secrets / credentials / API keys
   - `.env`, private keys, token files accidentally tracked
   - Dangerous patterns (hard-coded passwords, disabled TLS, `eval` on untrusted input, etc.)
   - Dependency advisories if a lockfile is present
   - Windows-specific concerns (path traversal, PowerShell execution policy hints)

3. Categorize every finding as **NEW** (not in `security/audit-log.md`) vs **EXISTING** (already logged / accepted). Match by file path + rule ID + fingerprint.

4. Append a new dated section to `security/audit-log.md` with:
   - Trigger reason (`$ARGUMENTS`)
   - Timestamp (today's date)
   - NEW findings (full detail)
   - EXISTING findings (one-line reference)
   - Net delta vs previous run

5. Print the final **SECURITY GATE** block verbatim — with PASS / FAIL, NEW count, EXISTING count, and the top three blocking issues (if any). This is the only part the user needs to see at a glance; everything else goes into the log file.

If the trigger is `pre-push` or `pre-commit` and any NEW high-severity finding exists, the gate MUST output **FAIL** and list the blocking paths. Do not auto-fix; surface the findings for the user to decide.
