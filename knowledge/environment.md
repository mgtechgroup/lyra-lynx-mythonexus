# Environment

Last verified: 2026-04-25

## Host

- OS: Windows 11 Pro (26200)
- Shell: Git Bash (Unix syntax, `/c/Users/...` paths)
- WSL: Ubuntu (default distro, WSL2)

## Machine-Wide AI Memory Cache

- **Path:** `~/.ai-memory/` (set via `AI_MEMORY_PATH` env var)
- **Synced:** 5,806 entries from Claude project memory as of 2026-04-25
- **Core files:**
  - `memory.jsonl` — append-only forever log
  - `context.json` — active session state
  - `preferences.json` — portable user preferences
  - `projects.json` — project registry
  - `skills.json` — learned patterns and agent triggers
- **IDE integration:**
  - VS Code: `~/.vscode/settings.json` references `AI_MEMORY_PATH`
  - Continue.dev: `~/.continue/config.json` loads memory as context provider
  - Claude Code: `~/.claude/CLAUDE.md` loads `.ai-memory/` before repo knowledge
- **Sync scripts:**
  - `~/.ai-memory/sync.ps1` — pulls Claude memory into `memory.jsonl`
  - `~/.ai-memory/promote-to-repo.ps1` — promotes high-confidence entries to `knowledge/memory-sync/`
- **Rules:** append-only, never store secrets, sanitize paths/tokens before writing

## Python

- Active: MS Store Python 3.13
  - site-packages is read-only; pip auto-falls-back to `--user`
- User scripts dir (in PATH):
  `~/AppData/Local/Packages/PythonSoftwareFoundation.Python.3.13_qbz5n2kfra8p0/LocalCache/local-packages/Python313/Scripts`
- Use `python -m pip` over bare `pip` (safer — pip.exe has previously been shadowed by a broken 3.14 install)

## Hardware

| Component | Spec |
|-----------|------|
| RAM | 93 GB |
| GPU | NVIDIA RTX 5060 (8 GB VRAM) |
| Disk (C:) | 1.9 TB total, ~1.6 TB free (as of 2026-04-21) |

## Installed tools (relevant subset)

| Tool | Source | Notes |
|------|--------|-------|
| `fd` | Chocolatey | Modern `find` replacement |
| `fzf` | Chocolatey | Fuzzy finder (Ctrl+T, Ctrl+R, Alt+C in bash) |
| `zoxide` | Chocolatey | Smart `cd` — `z <name>` jumps to frecent dirs |
| `graphify` | pip editable install | Knowledge-graph builder, 20+ language parsers |
| `gh` | Preinstalled | GitHub CLI |
| Chocolatey | System | Primary Windows package manager |
| winget | System | Secondary package manager |
| `ollama` v0.21.0 | Chocolatey | Local LLM inference — installed 2026-04-21 |
| Docker Desktop | Preinstalled | v29.4.0, Docker Compose v5.1.1, context: desktop-linux |

## Local LLM models (Ollama)

| Model | Size | Purpose |
|-------|------|---------|
| `qwen2.5-coder:7b` | 4.7 GB | Primary code generation (fits in VRAM) |
| `nomic-embed-text:latest` | 274 MB | Local embeddings / semantic search |

## Local infra stack (Docker — `lyra-lynx-mythonexus/infra/`)

| Service | Port | Purpose |
|---------|------|---------|
| Loki | 3100 | Log aggregation |
| Grafana | 3000 | Dashboards |
| Prometheus | 9090 | Metrics |
| Portainer | 9000/9443 | Container management |
| ChromaDB | 8000 | Vector store |
| Ollama (native) | 11434 | LLM inference (not containerised) |

Start stack: `cd ~/lyra-lynx-mythonexus/infra && docker compose up -d`

`scoop` is NOT installed — prefer Chocolatey or winget.

## Custom shell config

- Git Bash: `~/.bashrc` sourced (aliases, fzf, zoxide, prompt)
- WSL: `~/.bash_aliases` sourced via Ubuntu's stock `.bashrc`

## Known gotchas

- **PATH changes via registry** don't refresh in the current bash session. Use full paths or `python -m <module>` until a new terminal is opened.
- **Heredocs** (`cat > file << EOF`) trigger the Opsera pre-commit security gate even when not committing. Use the `Write` tool instead.
- **Windows filenames** can't contain `| < > : " ? *`. `git clone` fails the checkout on such files; use `git show HEAD:"<path>" > safe-name` to extract blobs.
- **`pip install -e .`** must run from the directory containing `pyproject.toml` (not a subdir with the same name as the package).
- **`choco install`** without `-y` hangs in non-interactive shells.
