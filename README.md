# EIS Wiki

Wissensdatenbank für die Ausbildung zum **Elektroniker für Informations- und Systemtechnik** — gebaut mit [Quartz v4](https://quartz.jzhao.xyz/).

## Schnellstart

```bash
# Seite bauen (Output in result/public/)
nix build

# Lokal mit Hot Reload servieren
nix run

# Dev-Shell mit Node.js
nix develop
```

## Deployment

Die Seite wird automatisch auf drei Plattformen deployt:

| Plattform | Package | URL |
|-----------|---------|-----|
| GitHub Pages | `.#quartz-github` | `m4rc2a.github.io/eis-wiki/` |
| GitLab Pages | `.#quartz-gitlab` | `eis-wiki-2e3f3a.code.siemens.io/` |
| Codeberg Pages | `.#quartz-codeberg` | `m4rc2a.codeberg.page/eis-wiki/` |

## Docker

```bash
nix build .#docker
docker load < result
docker run -p 8080:8080 eis-wiki:latest
```

## Inhalte bearbeiten

Wiki-Inhalte liegen im Git-Submodule `content/` ([`eis-notes`](https://code.siemens.com/eis/eis-notes)). Änderungen an den Inhalten gehören dort, nicht in diesem Repo.

## Nix-Details

- **Pure Builds**: `baseUrl` wird über `mkQuartzBuild { baseUrl = "..."; }` parametrisiert — kein `--impure` nötig
- **Fonts**: Source Sans Pro und JetBrains Mono werden aus nixpkgs gebündelt (OTF → WOFF2 Konvertierung)
- **npmDepsHash aktualisieren**: `nix run nixpkgs#prefetch-npm-deps -- package-lock.json`
