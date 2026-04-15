# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

EIS Wiki — a German-language knowledge base for the "Elektroniker fuer Informations- und Systemtechnik" vocational training program. Built on Quartz v4 (jackyzha0/quartz), a static site generator for digital gardens. The project tracks the upstream Quartz `v4` branch and merges upstream changes periodically.

## Common Commands

```bash
# Nix build (produces static site in result/public)
nix build

# Nix serve (uses working tree, hot reload)
nix run

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

# Run all tests
npm test

# Run a single test file
npx tsx --test quartz/util/path.test.ts

# Profile build performance
npm run profile
```

## Architecture

### Build Pipeline

Quartz processes content through three stages: **parse** (transformers) → **filter** → **emit**. Defined in `quartz/processors/`. The main build orchestrator is `quartz/build.ts`, which supports incremental rebuilds via file watching.

### Content is a Git Submodule + Flake Input

The `content/` directory is a **separate Git repository** (`marc.zander/eis-notes.git` on `code.siemens.com`). Wiki content edits belong in that submodule, not in this repo. For the Nix build, `eis-notes` is declared as a flake input (`git+ssh://code.siemens.com/...`) and copied into the source tree via `postUnpack`. This is necessary because `git archive` (used by Nix for `src = self`) does not include submodule contents.

In CI, the `eis-notes` input is overridden with `--override-input eis-notes path:./content` so it reads from the checked-out submodule instead of fetching via SSH.

### Configuration

- **`quartz.config.ts`** — Site config: locale is `de-DE`, fonts are self-hosted (`fontOrigin: "local"`), CDN caching disabled, `baseUrl` reads from `process.env.QUARTZ_BASE_URL` (fallback: `m4rc2a.github.io/eis-wiki/`). Content is authored in Obsidian (ObsidianFlavoredMarkdown transformer enabled).
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
- `quartz/i18n/` — Locale files (configured for `de-DE`)

## Deployment

All three platforms build via `nix build` and deploy `result/public/`:

- **GitHub Pages** (`.github/workflows/deploy.yml`): `cachix/install-nix-action`, `baseUrl` = `m4rc2a.github.io/eis-wiki/`
- **GitLab Pages** (`.gitlab-ci.yml`): `nixos/nix` Docker image, `baseUrl` = `m4rc2a.github.io/eis-wiki/` (adjust for GitLab domain)
- **Codeberg Pages** (`.forgejo/workflows/deploy.yml`): Forgejo Actions with `nixos/nix` container, `baseUrl` = `m4rc2a.codeberg.page/eis-wiki/`
- **Docker**: multi-stage build from `node:22-slim`, serves via `npx quartz build --serve`

### Nix Build Notes

- `eis-notes` flake input uses `git+ssh://` — requires SSH key with access to `code.siemens.com`. In CI, the input is overridden via `--override-input eis-notes path:./content` to read from the submodule checkout instead.
- Git dates (`CreatedModifiedDate` with `git` priority) are unavailable in the Nix sandbox (no `.git` directory). Falls back to frontmatter/filesystem dates.
- Fonts are bundled from nixpkgs and a `fonts.css` is generated in `postInstall`.

## Requirements

- Node >= 22 (`cat .node-version`)
- npm >= 10.9.2
- `.npmrc` enforces `engine-strict=true`
- ESM project (`"type": "module"`)

## Code Style

- Prettier: no semicolons, trailing commas, 100 char width, 2-space indent (see `.prettierrc`)
- TypeScript strict mode with no unused locals/parameters
