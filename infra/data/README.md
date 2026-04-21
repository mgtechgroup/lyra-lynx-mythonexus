# infra/data/

Bind-mount directories for persistent container state. Content is gitignored; structure is tracked.

## Contents

| Directory | Container | Contents |
|-----------|-----------|---------|
| `chroma/` | nmb-chromadb | ChromaDB collections, embeddings, indexes |
| `grafana/` | nmb-grafana | Dashboards, users, alert rules, plugin state |
| `loki/` | nmb-loki | Log chunks and TSDB index (90-day retention) |
| `portainer/` | nmb-portainer | Portainer database, users, endpoints |
| `prometheus/` | nmb-prometheus | TSDB metric blocks (90-day retention) |

## Notes

- These directories grow over time — monitor disk usage via Grafana or `du -sh data/*/`
- Safe to delete individual subdirs to reset that service's state (then `docker compose restart <svc>`)
- Ollama models are stored in a Docker named volume, not here (too large for bind-mount inspection)
