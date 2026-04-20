# Scoring rubric

On day 14 of each cycle, the system-wide score is computed as the average of these dimensions. Each dimension scores 0–100, higher is better.

Input data comes from the per-focus intake scripts under `scripts/focus/` and the cycle log in `security/audit-cycles/`.

## Dimensions

### Security (`sec`)

| Score | Criterion |
|-------|-----------|
| 100 | Zero Critical/High findings across all local repos |
| 80  | All Critical closed; High findings have documented mitigation |
| 60  | Critical findings have tracked plans; High count decreasing |
| 40  | Critical findings untracked OR High count stagnant 2+ cycles |
| 0   | Unresolved Critical > 1 week old, no plan |

### Efficiency (`eff`)

| Score | Criterion |
|-------|-----------|
| 100 | No manually-repeated workflows observed this cycle |
| 80  | 1-2 repeats, planned for automation next cycle |
| 60  | 3-5 repeats, no plan yet |
| 40  | 6+ repeats, still no automation |
| 0   | Same workflow done manually every session |

### Knowledge (`know`)

| Score | Criterion |
|-------|-----------|
| 100 | `knowledge/*.md` matches current environment; no drift |
| 80  | Minor drift (<10% of facts stale) |
| 60  | Moderate drift, known gaps documented |
| 40  | Major drift OR gaps not tracked |
| 0   | Knowledge base not updated in 3+ cycles |

### Tooling (`tool`)

| Score | Criterion |
|-------|-----------|
| 100 | All declared tools installed + version-aligned across Git Bash + WSL |
| 80  | Minor version skew (non-breaking) |
| 60  | Missing 1-2 declared tools |
| 40  | Broken tool installs in PATH (like the Python 3.14 empty dir) |
| 0   | 3+ missing or broken tool installs |

### Agent coverage (`agents`)

| Score | Criterion |
|-------|-----------|
| 100 | Every recurring (>=3x) workflow has a dedicated agent |
| 80  | New candidates identified in `agents/proposed/`, plan to ship next cycle |
| 60  | Candidates identified, no plan |
| 40  | Recurring workflows not tracked |
| 0   | No agent coverage attempted |

### Dependencies (`deps`)

| Score | Criterion |
|-------|-----------|
| 100 | Zero known-vulnerable deps; all deps within 1 minor release of latest |
| 80  | Vulnerable deps fixed, outdated deps tracked |
| 60  | Vulnerable deps scheduled for next cycle |
| 40  | Vulnerable deps not tracked |
| 0   | Vulnerable deps > 30 days old |

### Documentation (`docs`)

| Score | Criterion |
|-------|-----------|
| 100 | README/CLAUDE/knowledge accurate; tested in last cycle |
| 80  | Minor inaccuracies, scheduled for fix |
| 60  | Known drift >10% |
| 40  | Drift not tracked |
| 0   | Docs reference non-existent paths/tools |

### Performance (`perf`)

| Score | Criterion |
|-------|-----------|
| 100 | All tracked scripts run under documented p95 thresholds |
| 80  | Minor regressions (<20%); investigation planned |
| 60  | Moderate regression (20–50%) |
| 40  | Major regression (>50%), no plan |
| 0   | Scripts unusable in practice |

## Overall score → action

| Overall | Action on day 14 |
|---------|------------------|
| 90-100 | Ship small polish improvements; rotate focus to next-lowest dimension |
| 70-89  | Install 2-3 targeted improvements, document in decisions.md |
| 50-69  | Dedicate next cycle to lowest-scoring dimension |
| <50    | Halt new features; emergency remediation cycle |
