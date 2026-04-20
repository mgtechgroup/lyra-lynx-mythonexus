---
description: Sanitize ~/.claude memory into knowledge/memory-sync/ (dry-run by default, --apply to write)
argument-hint: "[--apply]"
allowed-tools: ["Bash"]
---

You are syncing and sanitizing Claude memory into the repo's `knowledge/memory-sync/` area.

**Mode:** `$ARGUMENTS` — pass through to the script. Empty means dry-run. `--apply` means actually write.

Steps:

1. Run:
   ```bash
   bash scripts/sync-memory.sh $ARGUMENTS
   ```

2. Capture the script's output verbatim and present:
   - In dry-run mode: the list of files that **would change**, plus any entries the script flagged as redacted / dropped (secrets, paths with usernames, API keys, etc.).
   - In `--apply` mode: the list of files that **did change** on disk, plus the same redaction report.

3. After the output, remind the user:
   > **Do not commit `knowledge/memory-sync/` without reviewing each changed file.** Memory can contain private context, tokens, or personal information that the redactor may miss. Run `git diff knowledge/memory-sync/` before staging.

4. If the script exits non-zero, surface the exit code and stderr — do not swallow the failure.

Do not run `git add`, `git commit`, or any write operation beyond invoking the script.
