# L1B3RT4S (defensive reference — external clone only)

**Upstream:** https://github.com/elder-plinius/L1B3RT4S
**Local clone:** `~/Downloads/L1B3RT4S` (NOT mirrored into this repo)
**Type:** Reference — vendor-organized jailbreak payload catalog

## Why it's here

**Defensive posture.** This catalog is organized per LLM vendor, which is exactly the dimension along which we evaluate agent prompt resilience. Knowing what's weaponized against each vendor tells us where to harden.

## Vendor files upstream

```
ANTHROPIC.mkd   OPENAI.mkd      GOOGLE.mkd      META.mkd
APPLE.mkd       MICROSOFT.mkd   AMAZON.mkd      NVIDIA.mkd
ALIBABA.mkd     DEEPSEEK.mkd    MOONSHOT.mkd    MISTRAL.mkd
PERPLEXITY.mkd  GROK-MEGA.mkd   XAI.mkd         COHERE.mkd
CURSOR.mkd      WINDSURF.mkd    REKA.mkd        INFLECTION.mkd
BRAVE.mkd       HUME.mkd        GRAYSWAN.mkd    REFLECTION.mkd
LIQUIDAI.mkd    INCEPTION.mkd   FETCHAI.mkd     MULTION.mkd
NOUS.mkd        MIDJOURNEY.mkd  ZAI.mkd         ZYPHRA.mkd
1337.mkd        AAA.mkd         CHATGPT.mkd     TOKENADE.mkd
TOKEN80M8.mkd   SYSTEMPROMPTS.mkd               -MISCELLANEOUS-.mkd
#MOTHERLOAD.txt !SHORTCUTS.json
```

Plus `*SPECIAL_TOKENS.json` (illegal on Windows — doesn't check out without sanitized rename; non-essential for our use).

## How to use

- When writing or reviewing a Claude-family agent's system prompt, skim `ANTHROPIC.mkd` for the current attack meta. Ask: does my prompt encode anything worth leaking? Does it have an obvious override phrase? Would it survive the patterns in that file?
- When building an agent that proxies another model (e.g., a future research agent that calls Gemini or GPT), consult the matching vendor file.
- Treat `SYSTEMPROMPTS.mkd` as a reminder: real products get their system prompts leaked regularly. Anything in our `agents/*.md` should be safe to publish — **because it already is**.

## DO NOT

- **Copy payloads into lyra-lynx-mythonexus.** The repo is public; mirroring jailbreak text would weaponize it, trip gitleaks/semgrep, and risk platform takedown.
- **Paste payloads into scripts, tests, or prompts.** Models execute text; testing with live payloads is risky.
- **Run these against third-party services** without authorization.

## DO

- Reference a vendor file by name when justifying an agent's design choice: *"reviewed ANTHROPIC.mkd prompt-leak patterns — agent's system prompt encodes no secrets, only workflow rules."*
- Update this doc if upstream adds a vendor we care about.
- Treat L1B3RT4S as a moving target — upstream changes weekly. Re-skim at each Day-14 cycle.

## License

Per upstream `LICENSE` — not inherited here. Unclear/may be restrictive; this is another reason not to mirror content.
