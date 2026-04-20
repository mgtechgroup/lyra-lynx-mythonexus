---
status: flagged-for-review
install: not-installed
trust: unverified
---

# vibeship-scanner

**Upstream:** https://github.com/vibeforge1111/vibeship-scanner
**Local clone:** `~/Downloads/vibeship-scanner` (clone only — NOT installed)
**Hosted service:** `scanner.vibeship.co`
**Project type:** Monorepo — SvelteKit frontend + Python scanner + Supabase + remote MCP server

## What it claims to do

Runs 16 security scanners on arbitrary GitHub repos and produces AI-ready fix prompts. Offered as a web service and as a remote MCP server at `https://scanner.vibeship.co/mcp`.

## Why this is flagged

1. **Unverified publisher.** `vibeforge1111` is not a known vendor or researcher account. No signed releases, no published threat model.
2. **Messy repo hygiene.** Top level contains ~40 verification JSONs, benchmark MDs, and two stray files named `C:UsersUSERDesktopvibeship_scanner_master_fix_prompt.md` / `C:UsersUSERDesktopvibeship_scanner_report.md` — evidence of Windows absolute paths committed as single-token filenames. Signals rushed development, weak review process.
3. **Remote MCP of broad scope.** The advertised integration wires `npx mcp-remote https://scanner.vibeship.co/mcp` into Claude Desktop. That gives a third party MCP tool execution inside the user's Claude session, with the ability to scan and read any repo the user points at. Every prompt and every scanned repo URL flows through the operator's infrastructure.
4. **No SECURITY.md, no code audit, no reproducible build pinning.**

## What we did

- Cloned the repo for offline inspection only.
- Did NOT run the installer (no `npm install`, no `pip install`, no MCP wire-up).
- Did NOT add the MCP endpoint to any Claude config.

## If the user wants to proceed

Minimum safe path:
1. Read `src/`, `scanner/`, `supabase/` end-to-end.
2. Run only against a throwaway sandbox repo with no secrets.
3. Do NOT wire the remote MCP into the main Claude config — use a separate profile.
4. Revisit at Day 14 cycle close; reassess based on whether the repo has published signed releases and a real SECURITY.md by then.

## Alternative stacks we already trust

Our active security-gatekeeper agent runs a transparent, audit-logged stack: `gitleaks + semgrep + pip-audit + shellcheck`. Every run appends to `security/audit-log.md`. No third-party service involved. Prefer this for regular scans.
