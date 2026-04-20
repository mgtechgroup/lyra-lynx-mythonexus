# G0DM0D3 (reference — red-team chat interface)

**Upstream:** https://github.com/elder-plinius/G0DM0D3
**Local clone:** `~/Downloads/G0DM0D3`
**Type:** Reference — open-source multi-model red-team chat UI (AGPL-3.0)
**Hosted:** `godmod3.ai`

## What it is

A single-page chat interface (SvelteKit + Tailwind) that fans out a prompt across 50+ models via OpenRouter. Built for red-teaming, cognition research, and adversarial evaluation. Core features per upstream README:

- **GODMODE CLASSIC** — 5 prompt+model combos race in parallel, best response wins
- **ULTRAPLINIAN** — Multi-model evaluation across 5 tiers (10–55 models) with composite scoring
- **Parseltongue** — 33 input-perturbation techniques for red-team fuzzing (3 intensity tiers)
- **AutoTune** — context-adaptive sampling parameter engine with EMA learning
- **STM (Semantic Transformation Modules)** — real-time output normalization
- **Privacy** — API key stays in browser; telemetry opt-out, dataset opt-in

## Why it's here

**Red-team reference.** Our security-gatekeeper and future red-team agents benefit from knowing:

1. **What a multi-model attack rig looks like.** If we ever need to cross-validate an agent's robustness, the ULTRAPLINIAN pattern (same prompt, many models, composite scoring) is a clean template.
2. **What input-perturbation fuzzing looks like.** The Parseltongue module is a cataloged 33-technique list. When writing tests for agent prompt resilience, pick from that taxonomy.
3. **A reference for "single-file deployable" web apps.** The architecture (one `index.html`, BYO API key) is a model for anything we might self-host for private evaluation.

## How we'd use it (future)

- **Not installed.** No install attempted — UI/service, not a CLI we run locally.
- If the hive grows a `red-team-evaluator` agent, point it at the G0DM0D3 rig locally (self-hosted, BYO key) to fuzz a candidate agent's system prompt before promotion.
- Reference `Parseltongue` in the quality bar for new agent proposals once we define adversarial-resilience testing.

## DO NOT

- Wire the hosted `godmod3.ai` into any automation without understanding data flow.
- Use against third-party models in ways that violate their ToS.
- Mistake "red-team tool" for "attack tool" — the value is finding your own weaknesses first.

## License

**AGPL-3.0.** Strong copyleft. Any derivative hosted as a service must publish source. We are NOT deriving from this repo; we reference it only.
