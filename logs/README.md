# logs/

Session and audit event logs. Content is gitignored (JSON-lines); directory structure is tracked.

## Layout

```
logs/
├── YYYY-MM-DD.log     # Daily session events (JSON-lines, all levels)
└── audit/
    └── YYYY-MM.log    # Monthly audit/error events only
```

## Log Format

Each line is a JSON object:
```json
{"ts":"2026-04-21T10:00:00Z","level":"INFO","event":"session_start","host":"hostname","msg":"..."}
```

## Levels

| Level | Written to | Use case |
|-------|-----------|---------|
| INFO | daily log | Normal events |
| DEBUG | daily log | Verbose tracing |
| WARN | daily log | Non-fatal issues |
| ERROR | daily + audit | Failures requiring attention |
| AUDIT | daily + audit | Security events, git commits |

## Writing Logs

```bash
bash scripts/session-log.sh INFO session_start "description"
bash scripts/session-log.sh AUDIT git_commit "hash message"
```

## Viewing Logs

- **Grafana** → http://localhost:3000 → Explore → Loki → `{job="nexus-map-bot"}`
- **Raw**: `cat logs/$(date +%Y-%m-%d).log | jq .`
