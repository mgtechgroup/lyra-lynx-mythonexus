# infra/

Docker Compose–based local hypervisor stack for Nexus Map Bot / Lyra-Lynx.

## Services

| Container | Image | Port(s) | Purpose |
|-----------|-------|---------|---------|
| `nmb-loki` | grafana/loki:3.4.2 | 3100 | Log aggregation |
| `nmb-promtail` | grafana/promtail:3.4.2 | — | Scrapes `../logs/` → Loki |
| `nmb-prometheus` | prom/prometheus:v3.3.1 | 9090 | Metrics collection |
| `nmb-grafana` | grafana/grafana:11.6.1 | 3000 | Dashboards |
| `nmb-portainer` | portainer/portainer-ce:2.27.4 | 9000, 9443 | Container UI |
| `nmb-ollama` | ollama/ollama:latest | 11435 | Containerised LLM (fallback) |
| `nmb-chromadb` | chromadb/chroma:1.0.9 | 8000 | Local vector store |

## Directory Layout

```
infra/
├── docker-compose.yml     # Service definitions
├── .env                   # Secrets — GITIGNORED
├── .env.example           # Template (committed)
├── config/
│   ├── grafana/
│   │   └── datasources/   # Auto-provisioned Loki + Prometheus sources
│   ├── loki/              # Loki server config (90-day retention, TSDB schema v13)
│   ├── prometheus/        # Scrape targets
│   └── promtail/          # Log shipping rules
└── data/                  # Bind-mount persistent data (gitignored content)
    ├── chroma/            # ChromaDB collections
    ├── grafana/           # Grafana state, dashboards
    ├── loki/              # Loki chunks + index
    ├── portainer/         # Portainer DB
    └── prometheus/        # TSDB blocks (90-day retention)
```

## Usage

```bash
# Start all services
docker compose up -d

# View logs
docker compose logs -f

# Stop
docker compose down

# Full teardown (keeps bind-mount data)
docker compose down --remove-orphans
```

## Credentials

- **Grafana**: admin / see `infra/.env` → `GRAFANA_PASSWORD`
- All other services: unauthenticated on localhost only

## Network

All containers share the `nexus-map-bot` bridge network. No ports are exposed externally.
