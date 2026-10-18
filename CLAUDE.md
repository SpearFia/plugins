# plugins

Spear Fia effect suite (DCTL, OFX, WGSL) with AI-readable capability descriptors.

## Layout

- `<plugin>/`: one folder per plugin, with `<plugin>.asset.json` (descriptor with
  capabilities), `README.md`, and `dctl/`, `ofx/`, `wgsl/` builds. First plugin: `focus-loupe/`.
- `shared/{dctl,cpp,wgsl}/`: math shared across formats.
- `recipes/`: multi-step looks that reference capabilities as `spearfia/<asset>#<capability>`.
- `test-harness/`: render a frame and compare it to `golden/` (Git LFS).
- `bench/`: performance benchmarks.
- `scripts/install.ps1`: installs DCTLs and OFX bundles on Windows.

## Commands

```powershell
.\scripts\install.ps1 -Plugin focus-loupe
# validation (CI does this): with spearfia-spec next to this repo
node ..\spearfia-spec\scripts\check.mjs asset focus-loupe\focus-loupe.asset.json
node ..\spearfia-spec\scripts\check.mjs recipe recipes\facecam-pip.yaml
```

When a plugin file changes, update the descriptor's `hash`. DCTL rules learned the hard
way are in `spearfia/skills` → `plugin-builder/checklists/`.

## Naming

| Context | Form |
| --- | --- |
| Prose, UI, README titles | Spear Fia |
| GitHub org, URLs, crates, packages, IDs | `spearfia` |
| Rust crates | `spearfia-<name>` |
| npm packages | `@spearfia/<name>` |
| Asset and plugin IDs | `spearfia/<asset>@<semver>`, e.g. `spearfia/focus-loupe@0.1.0` |
| Schema IDs | `https://spearfia.dev/schemas/<name>/v1.json` |

Never write the second word of the name in all capitals.

## Rules

- Never commit media. Media lives on the external drive, not under `C:\dev`.
- The schemas in `spearfia/spearfia-spec` are the source of truth for every format.
  Change the schema there first, then the code or data that uses it.
- `main` is protected: work on `feat/`, `fix/` or `exp/` branches and open a PR.
- New files are dual licensed MIT OR Apache-2.0.
