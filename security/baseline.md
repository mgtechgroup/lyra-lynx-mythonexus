# Security Baseline

## Purpose

This document captures the initial security posture of the lyra-lynx-mythonexus repository at the start of its 14-day capability-building cycle. It serves as the reference snapshot against which subsequent Day 14 scorecards, audit findings, and mitigation decisions are compared. The baseline fixes the assumed threat model, scanner stack, and control set so that drift, regressions, and improvements can be detected objectively over time.

## Scope

The following directories and file classes are in-scope for all security controls described below:

- `scripts/` — shell and Python automation (cycle start/close, scoring, scanner orchestration)
- `agents/` — Claude Code subagent definitions (including security-gatekeeper)
- `dotfiles/` — shell, editor, and tool configuration intended for public distribution
- `knowledge/` — curated notes and references that ship with the repo
- `.github/` — workflows, issue templates, dependabot configuration

The repository root (top-level configuration files such as `.gitleaks.toml`, `.pre-commit-config.yaml`, `.semgrepignore`) is also in-scope.

## Scanner stack

| Tool       | Version / Ruleset                          | Role                                              |
|------------|--------------------------------------------|---------------------------------------------------|
| gitleaks   | v8.21.2                                    | Secret detection (staged diffs + full-repo scan)  |
| semgrep    | `p/default`, `p/secrets`, `p/bash`         | SAST for shell, Python, and generic patterns      |
| pip-audit  | latest stable                              | Python dependency CVE check (pinned requirements) |
| shellcheck | v0.10                                      | Shell-script linting and injection prevention     |

All scanner versions are pinned in CI. Local pre-commit hooks defer to the same versions via pinned hook revisions.

## Controls in place

- **Pre-commit hooks**: gitleaks, shellcheck, and a scoped semgrep run fire on every `git commit`. Commits with Critical or High findings are blocked by default.
- **GitHub Actions security workflow**: runs on every `push`, every `pull_request`, and on a weekly Monday cron. The workflow executes the full scanner stack and uploads SARIF artifacts.
- **Dependabot**: configured for `github-actions` ecosystem on a weekly cadence. Python requirements are tracked separately via `pip-audit` in the security workflow.
- **`.gitleaks.toml` allowlist**: permits the append-only `security/audit-log.md` (which legitimately references finding types) and documented placeholder tokens used in examples.

## Threat model

This is a public repository. The primary risk is accidental secret leakage (API keys, tokens, credentials) committed to history or pull requests. The secondary risk is shell-script injection or unsafe patterns in automation that downstream users execute on their own systems. The tertiary risk is dependency vulnerabilities in pinned Python tooling. Supply-chain attacks on upstream packages and plugin ecosystems are acknowledged but mitigated only by pinning and dependabot review.

## Explicitly out-of-scope

- Private repositories, private forks, and private mirrors of this project.
- Anything outside this working tree (other repositories, system-level configuration, the host machine).
- Upstream dependencies beyond the versions pinned here — transitive dependency analysis is limited to what `pip-audit` surfaces for pinned direct dependencies.
- Runtime behaviour of Claude Code itself or any MCP server the user attaches locally.

## Review cadence

The baseline is reviewed at every Day 14 cycle close. Any focus dimension (sec, eff, know, tool, agents, deps, docs, perf) scoring below 70 on the Day 14 rubric automatically triggers a mitigation task scheduled into the next cycle. The `sec` dimension scoring below 70 additionally triggers an immediate re-scan and an entry in `security/audit-log.md` with decision `BLOCK` until remediated.
