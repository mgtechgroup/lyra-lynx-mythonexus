---
description: Clone and install a GitHub repo (Windows-aware)
argument-hint: "<github-url>"
allowed-tools: ["Bash", "Read", "Write", "Grep", "Glob"]
---

You are installing a GitHub repository on this Windows machine.

**Target URL:** `$ARGUMENTS`

If `$ARGUMENTS` is empty, stop and ask the user for the GitHub URL before doing anything else.

Steps:

1. Invoke the `repo-installer` agent with the URL `$ARGUMENTS`. The agent is responsible for the full flow below; your job is to orchestrate and summarize.

2. Clone into the user's standard install location. Handle Windows filename-restriction errors gracefully:
   - If `git clone` fails with invalid-filename / long-path errors, retry with `core.longpaths=true` and / or sparse-checkout that excludes the offending paths. Log what was skipped.
   - If line-ending warnings appear, note them but do not abort.

3. Detect the project type by the highest-signal marker in this order:
   - `pyproject.toml` / `setup.py` / `requirements*.txt` → Python
   - `package.json` → Node (pnpm > yarn > npm, by lockfile)
   - `Cargo.toml` → Rust
   - `go.mod` → Go
   - `*.csproj` / `*.sln` → .NET
   - `Makefile` with an `install` target → fall back to `make install`

4. Run the correct install command for the detected stack. Capture stdout+stderr. Do not silently swallow errors.

5. Verify the binary / entry point is on `PATH`:
   - Find the declared executable (from `pyproject` `[project.scripts]`, `package.json` `bin`, Cargo `[[bin]]`, etc.).
   - Run `where <name>` (Windows) and invoke it with `--version` or `--help`.
   - If not on PATH, report the exact directory the user needs to add and do NOT modify PATH yourself.

6. Print the **REPO INSTALL** summary block:
   - Repo, commit SHA, install path
   - Detected stack
   - Install command(s) run
   - Skipped files (from the Windows-filename fallback), if any
   - PATH verification result (binary name → resolved path, or "not on PATH — add `<dir>`")
   - Next step the user should take (e.g. "restart terminal", "run `<tool> init`", "none")
