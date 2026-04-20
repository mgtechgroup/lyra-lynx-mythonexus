---
description: Load the Lyra-Lynx knowledge base priority order into context
allowed-tools: ["Read", "Glob"]
---

You are priming context with the Lyra-Lynx knowledge base.

Read the following files in this exact order (priority order — earlier files override later ones on conflicts):

1. `CLAUDE.md`
2. `knowledge/user-profile.md`
3. `knowledge/environment.md`
4. `knowledge/decisions.md`
5. `knowledge/patterns.md`

If any file is missing, note it in your summary but continue with the rest.

After reading, produce **5-8 bullets** that summarize what you now know. Each bullet should capture a distinct, actionable fact — the user's preferences, the machine's constraints, past decisions that still bind, recurring patterns, conventions to respect.

**Do not** paste file contents. **Do not** quote long passages. The point is compression: the user already has the files; they want the synthesis.

Good bullet shape: `"Windows-first: prefer bash-compatible syntax, forward-slash paths, no /dev/null → NUL swaps"`
Bad bullet shape: `"The environment.md file describes the user's system in detail including..."`
