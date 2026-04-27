# Decisions

Durable architectural and workflow decisions. Append-only; supersede with a new entry rather than editing.

## 2026-04-20 — Repository purpose: hybrid (knowledge + dotfiles + plugin)

**Decision:** Lyra-Lynx MythoNexus serves three purposes in one repo — knowledge base, dotfiles, Claude Code plugin.

**Alternatives considered:** A) dotfiles only; B) personal meta-repo; C) purpose-specific project.

**Reason:** The user wants a single canonical source of environment + context Claude can sync to. Splitting across three repos creates friction for what is effectively one coherent knowledge system.

## 2026-04-20 — Dotfiles deployment: per-platform files

**Decision:** Git Bash uses `dotfiles/bashrc`, WSL uses `dotfiles/bash_aliases`. The install script detects environment and deploys the correct file.

**Alternatives considered:** Single portable `.bashrc` with OS detection guards.

**Reason:** Two files are clearer than one file with nested conditionals. WSL's stock `.bashrc` already sources `.bash_aliases`, so dropping a file there is non-invasive.

## 2026-04-20 — Agent v1 scope: three highest-leverage workflows

**Decision:** Ship `windows-env-auditor`, `repo-installer`, `security-gatekeeper` in v1. Add `dotfiles-deployer`, `memory-syncer`, `knowledge-curator` in v1.1 after validating trigger ergonomics.

**Reason:** Faster initial delivery; each agent's triggering language can be refined against real use before the next batch is written.

## 2026-04-20 — Self-audit cadence: 14 days

**Decision:** Run local + repo self-audits every 14 days. Scheduled via GitHub Actions (`self-audit.yml`) and local cron/Task Scheduler pointer.

**Reason:** Long enough to accumulate meaningful drift, short enough that findings are actionable. User-specified cadence.

## 2026-04-25 — Machine-wide AI memory cache: ~/.ai-memory/

**Decision:** Create a centralized, append-only memory store at `~/.ai-memory/` accessible by all models (Claude, Cursor, VS Code, Continue.dev, Ollama) via `AI_MEMORY_PATH`.

**Alternatives considered:** A) Per-tool memory silos; B) Cloud-based memory service; C) Repo-only knowledge files.

**Reason:** The user switches between Claude Code, VS Code, Continue.dev, and local LLMs. A machine-wide cache prevents context loss when switching tools. The JSONL format is append-only and tool-agnostic. Sync scripts bridge the cache into the repo's `knowledge/` directory while sanitizing secrets.
