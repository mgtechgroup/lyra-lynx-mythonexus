# infra/config/

Static configuration files for all Docker services. Mounted read-only into containers.

## Contents

| Path | Service | Purpose |
|------|---------|---------|
| `loki/loki-config.yaml` | Loki | Storage (filesystem/TSDB), retention (90d), schema v13 |
| `promtail/promtail-config.yaml` | Promtail | Log scrape jobs — nexus-sessions, nexus-audit, system-logs |
| `grafana/datasources/datasources.yaml` | Grafana | Auto-provisions Loki + Prometheus data sources |
| `prometheus/prometheus.yml` | Prometheus | Scrape targets: prometheus, loki, ollama, chromadb |

## Editing

Changes to these files require a container restart:
```bash
docker compose restart <service>
```
