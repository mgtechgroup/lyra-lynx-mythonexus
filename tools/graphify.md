# graphify

Knowledge-graph builder that turns any folder of code/docs into a queryable graph. Parses 20+ languages via tree-sitter. Repo: https://github.com/safishamsi/graphify

## Install (Windows, MS Store Python 3.13)

```bash
git clone https://github.com/safishamsi/graphify.git
cd graphify
python -m pip install -e ".[all]"
```

The `-e` editable install links the cloned source into the user site-packages; changes to the cloned code take effect immediately.

## CLI

The `graphify.exe` script lives in the user scripts dir (already in PATH in this environment):

```
~/AppData/Local/Packages/PythonSoftwareFoundation.Python.3.13_qbz5n2kfra8p0/LocalCache/local-packages/Python313/Scripts/graphify.exe
```

## Common commands

| Command | Purpose |
|---------|---------|
| `graphify install --platform claude` | Copy the skill files to Claude Code's config dir |
| `graphify path "A" "B"` | Shortest path between two nodes in `graph.json` |
| `graphify explain "X"` | Plain-language explanation of a node + neighbors |
| `graphify add <url>` | Fetch URL, save to `./raw`, update graph |

## Optional extras

```bash
python -m pip install "graphifyy[mcp,pdf,watch,svg,office,video,leiden]"
```

| Extra | Adds |
|-------|------|
| `mcp` | MCP server integration |
| `pdf` | `pypdf`, `html2text` — parse PDFs and HTML |
| `watch` | `watchdog` — incremental graph updates |
| `svg` | `matplotlib` — render graph as SVG |
| `office` | `python-docx`, `openpyxl` — Word/Excel ingestion |
| `video` | `faster-whisper`, `yt-dlp` — transcribe video/audio |
| `leiden` | `graspologic` — community detection (requires py < 3.13) |

## Package name caveat

The PyPI package is `graphifyy` (two y's) but the CLI command and repo are `graphify`. This is common where an author avoids a naming collision on PyPI.
