---
description: Run windows-env-auditor — check PATH, Python, declared tools
allowed-tools: ["Bash", "Read", "Grep", "Glob"]
---

You are auditing the local Windows development environment.

Steps:

1. Invoke the `windows-env-auditor` agent. Let it run its full probe:
   - `PATH` entries (user + system), flagging duplicates, missing directories, and non-canonical casing.
   - Python situation: which interpreter `python` resolves to, `py -0` launcher output, pyenv / uv / conda presence, version mismatches vs `knowledge/environment.md`.
   - Declared tools from `knowledge/environment.md` — for each, check it exists on PATH, its version, and whether the version matches what's declared.
   - Shell context: current shell, bash-vs-pwsh surprises, `.bashrc` / profile drift.

2. Compute drift — the delta between **declared** (from `knowledge/environment.md`) and **observed**. Missing, extra, version-mismatched.

3. Print the **ENVIRONMENT AUDIT** block:
   - Counts: declared, present, missing, version-mismatched, undeclared-but-present
   - `PATH` issues (if any)
   - Python resolution
   - Per-tool table: `tool | declared | observed | status`
   - Recommended remediations (install / update / remove / declare), ranked by impact

Do not modify PATH, install tools, or edit `knowledge/environment.md` — this command is read-only. Surface actions for the user to take.
