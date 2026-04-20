# github/ruleset-recipes

**Upstream:** https://github.com/github/ruleset-recipes
**Local clone:** `~/Downloads/ruleset-recipes`
**Type:** Reference — official GitHub ruleset JSON recipes (first-party, MIT)

## What it is

GitHub-published starter rulesets as importable JSON. Rulesets are named lists of rules applied to a repo or org — who can push, whether PRs are required, signing, tag deletion, force-push policy, conventional commits, etc.

## Categories

- `branch-rulesets/` — branch protection, PR requirements, conventional commits, org-wide rules
- `tag-rulesets/` — prevent tag deletion, semantic-version enforcement
- `push-rulesets/` — push-level gating
- `universe-demos/` — GitHub Universe conference examples

## Notable recipes

| Recipe | What it enforces |
|-------|------------------|
| `branch-rulesets/were-just-normal-repositories.json` | Baseline branch protection best practices |
| `branch-rulesets/PRs and commits.json` | Require PRs + conventional commit messages |
| `branch-rulesets/org-rulesets/one-ruleset-to-rule-them-all.json` | Org-level rule that applies broadly |
| `tag-rulesets/prevent-tag-delete.json` | Block tag deletions |
| `tag-rulesets/org-ruleset/tag-defaults.json` | Org-wide semver tagging + no deletion |

## How to use

1. In a GitHub repo (or org with admin access), go to **Settings → Rules → Rulesets**.
2. Click **New ruleset → Import a ruleset**.
3. Pick a `.json` file from the local clone.
4. Review every rule before enabling — the defaults are opinionated.

## Relevance to lyra-lynx-mythonexus

Candidates to import once the repo is public:
- Baseline branch protection on `main`
- Require PRs + signed commits (signing is commented in `dotfiles/gitconfig`; flip it on when keys are set up)
- Block force-pushes to `main`
- Require CI pass (`validate-agents`, `lint`, `security`) before merge
- Tag deletion prevention (matches our append-only posture for cycle tags)

Plan to import at first Day-14 cycle close once the CI workflows have baked a few runs.

## License

MIT (per upstream `LICENSE`).
