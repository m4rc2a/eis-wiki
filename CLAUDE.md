# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

EIS Wiki — a German-language knowledge base for the "Elektroniker fuer Informations- und Systemtechnik" vocational training program. Built on Quartz v4 (jackyzha0/quartz), a static site generator for digital gardens. The project tracks the upstream Quartz `v4` branch and merges upstream changes periodically.

## Common Commands

```bash
# Nix build (produces static site in result/public)
nix build

# Nix build for a specific deployment target
nix build .#quartz-github
nix build .#quartz-gitlab
nix build .#quartz-codeberg

# Nix build Docker image (load with: docker load < result)
nix build .#docker

# Nix serve (uses working tree, hot reload)
nix run

# Enter dev shell (Node.js + tools)
nix develop

# Install dependencies (only needed for npm-based workflows)
npm ci

# Build the site with npm (output to public/)
npx quartz build

# Build and serve locally with hot reload
npx quartz build --serve

# Type check + format check
npm run check

# Auto-format code
npm run format

# Run all tests (Node.js built-in test runner, node:test + node:assert)
npm test

# Run a single test file
npx tsx --test quartz/util/path.test.ts

# Profile build performance
npm run profile

# Update npmDepsHash after changing package-lock.json
nix run nixpkgs#prefetch-npm-deps -- package-lock.json
```

## Architecture

### Build Pipeline

Quartz processes content through three stages: **parse** (transformers) → **filter** → **emit**. Defined in `quartz/processors/`. The main build orchestrator is `quartz/build.ts`, which supports incremental rebuilds via file watching.

### Content is a Git Submodule + Flake Input

The `content/` directory is a **separate Git repository** (`marc.zander/eis-notes.git` on `code.siemens.com`). Wiki content edits belong in that submodule, not in this repo. For the Nix build, `eis-notes` is declared as a flake input (`git+ssh://code.siemens.com/...`) and copied into the source tree via `postUnpack`. This is necessary because `git archive` (used by Nix for `src = self`) does not include submodule contents.

In CI, the `eis-notes` input is overridden with `--override-input eis-notes path:./content` so it reads from the checked-out submodule instead of fetching via SSH.

### Configuration

- **`quartz.config.ts`** — Site config: locale is `de-DE`, fonts are self-hosted (`fontOrigin: "local"`), CDN caching disabled, `baseUrl` uses a `__QUARTZ_BASE_URL__` placeholder that Nix substitutes via `substituteInPlace` in `postPatch`. Content is authored in Obsidian (ObsidianFlavoredMarkdown transformer enabled).
- **`quartz.layout.ts`** — Page layout: which components appear in header, footer, left/right sidebars for content pages vs list pages.

### Plugin System (`quartz/plugins/`)

- **Transformers** — Process markdown/HTML (frontmatter, GFM, OFM, syntax highlighting, LaTeX/KaTeX, ToC, links, descriptions)
- **Filters** — Exclude content from output (e.g., `RemoveDrafts`)
- **Emitters** — Generate output files (HTML pages, sitemap, RSS, assets, redirects)

### Component System (`quartz/components/`)

Preact components rendered server-side. Each component has a `.tsx` file and optionally a `.scss` style and a client-side script in `components/scripts/`. Custom CSS overrides go in `quartz/styles/custom.scss` (currently empty).

### Key Paths

- `quartz/bootstrap-cli.mjs` — CLI entry point (commands: create, update, restore, sync, build)
- `quartz/build.ts` — Build logic, file watching, incremental rebuilds
- `quartz/cfg.ts` — Type definitions for QuartzConfig, GlobalConfiguration, PageLayout
- `quartz/i18n/` — Locale files (configured for `de-DE`, currently unmodified upstream)
- `globals.d.ts` / `index.d.ts` — Global types: custom DOM events (`prenav`, `nav`, `themechange`, `readermodechange`), `ContentIndex`, `fetchData` promise. Important when writing new components or client-side scripts.

### Tests

Three test files using Node.js built-in test runner (`node:test` + `node:assert`):

- `quartz/util/path.test.ts` — Slug types, transforms, link resolution strategies
- `quartz/util/fileTrie.test.ts` — FileTrieNode tree operations
- `quartz/components/scripts/search.test.ts` — Search encoder/tokenizer (note: encoder function is inlined rather than imported from `search.inline.ts`)

## Deployment

All three platforms build via `nix build` and deploy `result/public/`:

- **GitHub Pages** (`.github/workflows/deploy.yml`): `cachix/install-nix-action`, builds `.#quartz-github` (baseUrl: `m4rc2a.github.io/eis-wiki/`)
- **GitLab Pages** (`.gitlab-ci.yml`): `nixos/nix` Docker image, builds `.#quartz-gitlab` (baseUrl: `eis-wiki-2e3f3a.code.siemens.io/`)
- **Codeberg Pages** (`.forgejo/workflows/deploy.yml`): Forgejo Actions with `nixos/nix` container, builds `.#quartz-codeberg` (baseUrl: `m4rc2a.codeberg.page/eis-wiki/`)
- **Docker**: built via `nix build .#docker`, minimal image with static site + `darkhttpd` on port 8080

### Nix Build Notes

- The `baseUrl` is parameterized via `mkQuartzBuild { baseUrl = "..."; }` in `flake.nix`. Named packages (`quartz-github`, `quartz-gitlab`, `quartz-codeberg`) provide per-target builds. The placeholder `__QUARTZ_BASE_URL__` in `quartz.config.ts` is substituted by `substituteInPlace` in the `postPatch` phase — no `--impure` needed.
- `eis-notes` flake input uses `git+ssh://` — requires SSH key with access to `code.siemens.com`. In CI, the input is overridden via `--override-input eis-notes path:./content` to read from the submodule checkout instead.
- Git dates (`CreatedModifiedDate` with `git` priority) are unavailable in the Nix sandbox (no `.git` directory). Falls back to frontmatter/filesystem dates.
- Fonts are bundled from nixpkgs: Source Sans Pro (OTF → WOFF2 conversion via `woff2_compress`) and JetBrains Mono (native WOFF2). The `fonts.css` lives in `quartz/static/fonts/fonts.css` and is copied by the Static emitter.
- Build sets `QUARTZ_DISABLE_TELEMETRY=1` and `NO_COLOR=1`.
- A dev shell is available via `nix develop` or `direnv` (`.envrc` uses `use flake`).

### CI Differences by Platform

- **GitHub/Forgejo**: Recursive submodule checkout, then `--override-input eis-notes path:./content`.
- **GitLab**: `GIT_SUBMODULE_STRATEGY: none`, fetches eis-notes via HTTPS with `CI_JOB_TOKEN` (`--override-input eis-notes git+https://gitlab-ci-token:${CI_JOB_TOKEN}@code.siemens.com/...`). Also sets corporate proxy variables (`http_proxy`, `https_proxy`, `no_proxy`).
- **Upstream CI** (`.github/workflows/ci.yaml`): Runs check/test/build but is gated to `jackyzha0/quartz` only — does not execute on forks.

## Requirements

- Node >= 22 (`cat .node-version`)
- npm >= 10.9.2
- `.npmrc` enforces `engine-strict=true`
- ESM project (`"type": "module"`)

## Code Style

- Prettier: no semicolons, trailing commas, 100 char width, 2-space indent (see `.prettierrc`)
- TypeScript strict mode with no unused locals/parameters
- LF line endings enforced via `.gitattributes`
