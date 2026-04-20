# External references

Catalog of external repos cloned locally for reference. **Not vendored** into this repo — content stays in `~/Downloads/` and we document what's there + how to use it defensively.

| Doc | Upstream | Role |
|-----|----------|------|
| [ruleset-recipes.md](ruleset-recipes.md) | `github/ruleset-recipes` | Importable GitHub ruleset JSONs — branch/tag/push protection recipes to harden this repo at Day-14 |
| [awesome-gpt-super-prompting.md](awesome-gpt-super-prompting.md) | `CyberAlbSecOP/Awesome_GPT_Super_Prompting` | Adversarial prompting catalog — defensive reference when drafting agent system prompts |
| [l1b3rt4s.md](l1b3rt4s.md) | `elder-plinius/L1B3RT4S` | Vendor-organized jailbreak catalog — check the relevant vendor file before shipping an agent |
| [g0dm0d3.md](g0dm0d3.md) | `elder-plinius/G0DM0D3` | Multi-model red-team chat UI — reference for future adversarial-eval rig |
| [linux-bash-commands.md](linux-bash-commands.md) | `trinib/Linux-Bash-Commands` | Bash command primer (pre-existing) |
| [linux-bash-alternatives.md](linux-bash-alternatives.md) | `trinib/Linux-Bash-Commands` | Modern-unix alternatives table (pre-existing) |

## Rules

1. **Never mirror payloads.** Public repo. Copying jailbreak/exploit text in would weaponize our repo and trip scanners.
2. **Never install untrusted repos** without a documented review. See `tools/vibeship-scanner.md` for an example flag.
3. **Each reference doc must explain the defensive framing** — why this is useful to a security-hardened agent system, not just what the upstream repo is.
4. **License matters.** Note it explicitly. AGPL and similar copyleft licenses mean we can't derive code; we can only reference.
5. **Re-skim at each Day-14 cycle.** Upstreams move; our posture should too.
