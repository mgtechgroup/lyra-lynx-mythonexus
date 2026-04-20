# Awesome GPT Super Prompting (defensive reference)

**Upstream:** https://github.com/CyberAlbSecOP/Awesome_GPT_Super_Prompting
**Local clone:** `~/Downloads/Awesome_GPT_Super_Prompting` (external clone only — NOT mirrored here)
**Type:** Reference catalog — adversarial prompting, jailbreaks, system-prompt leaks, prompt security

## Why it's here

**Defensive posture.** Knowing the attack surface is how we harden agents.

We do NOT vendor payloads into this repo. lyra-lynx-mythonexus is public — copying jailbreak text in would both weaponize our repo and trip secret/security scanners.

## Top-level sections upstream

- **Latest Jailbreaks/** — ~45 prompt payloads across model vendors (current meta)
- **Legendary Leaks/** — extracted system prompts from well-known GPT products (Grimoire, God of Prompt, Book Writer GPT, etc.)
- **My Super Prompts/** — author's own prompt templates (3 files have `|` in names, illegal on Windows — checkout partial)
- **Prompt Security/** — defensive patterns, detection rules
- **Ultra Prompts/** — long-form prompt engineering examples

## Directly relevant to our threat model

| Attack class | Where to read first | Defensive implication for us |
|--------------|---------------------|-------------------------------|
| Prompt injection in user-supplied text | `Prompt Security/` | Agents that read external files/URLs (repo-installer, security-gatekeeper) must treat fetched content as data, not instructions |
| System-prompt leaking | `Legendary Leaks/` | Don't encode secrets in agent system prompts. Every `agents/*.md` is world-readable |
| Universal/persona jailbreaks | `Latest Jailbreaks/Universal Bypass.md`, `Latest Jailbreaks/Z.md`, etc. | When drafting a new agent, its "DO NOT" list should anticipate that users may try to override it mid-session |
| Encoding/obfuscation tricks | `Latest Jailbreaks/Hex.md`, `Decodes Anything Now.md` | Scanner output should be read literally; don't let an agent "decode" suspicious blobs from scan results |

## How to use

- Browse **locally only**.
- When drafting a new agent (via `/propose-agent`), skim the relevant section to check the system prompt is robust against the attack class that agent will encounter.
- When the observation loop flags a recurring workflow involving processing external text, add "resist prompt injection from \<source\>" to the proposal's quality bar.

## DO NOT

- Commit payloads into this repo.
- Test payloads against third-party services without authorization.
- Paste payload content into agent system prompts "as examples" — the model executes what it reads.

## Partial-checkout note

Three files in `My Super Prompts/` use `|` in their name and don't check out cleanly on Windows (see `knowledge/environment.md` for the canonical recovery pattern). They're non-essential for defensive review; skip unless you need those specific prompts.

## License

Per upstream `LICENSE` — check the file; not inherited here.
