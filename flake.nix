{
  description = "Quartz (v4) nix-native build + serve";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {inherit system;};

      node = pkgs.nodejs_22;

      quartzBuild = pkgs.buildNpmPackage {
        pname = "quartz";
        version = "4.5.2";

        src = self;

        inherit node;

        npmDepsHash = "sha256-79+TyTXBao2PeYyRe7TYpcIUqoRJn5ku66ycNM2FTmU=";

        buildInputs = [
          pkgs.source-sans
          pkgs.jetbrains-mono
        ];

        # Wir nutzen das Quartz-CLI direkt (statt npm run build, das es nicht gibt)
        buildPhase = ''
          runHook preBuild
          export NO_COLOR=1
          export QUARTZ_DISABLE_TELEMETRY=1
          ${node}/bin/node ./quartz/bootstrap-cli.mjs build
          runHook postBuild
        '';

        installPhase = ''
          runHook preInstall
          mkdir -p $out
          cp -r public $out/public
          runHook postInstall
        '';

        postInstall = ''
          # Quartz output liegt bei dir evtl. unter $out (je nach installPhase).
          # Wir legen die Fonts dahin, wo Quartz sie als /static/... ausliefert:
          mkdir -p $out/static/fonts

          # WOFF2 aus nixpkgs rüberkopieren (Pfad variiert; wir suchen robust)
          copy_woff2() {
            local src="$1"
            if [ -d "$src" ]; then
              find "$src" -type f -name '*.woff2' -print -exec cp -v '{}' "$out/static/fonts/" \;
            fi
          }

          copy_woff2 ${pkgs.source-sans}/share/fonts
          copy_woff2 ${pkgs.jetbrains-mono}/share/fonts
          copy_woff2 ${pkgs.jetbrains-mono}/share/fonts/webfonts
          copy_woff2 ${pkgs.source-sans}/share/fonts/woff2

          # erzeugung minimaler fonts.css
          cat > $out/static/fonts/fonts.css <<'EOF'
          @font-face {
            font-family: "Source Sans Pro";
            src: url("/static/fonts/SourceSans3-Regular.woff2") format("woff2");
            font-weight: 400;
            font-style: normal;
            font-display: swap;
          }

          @font-face {
            font-family: "JetBrains Mono";
            src: url("/static/fonts/JetBrainsMono-Regular.woff2") format("woff2");
            font-weight: 400;
            font-style: normal;
            font-display: swap;
          }
          EOF
        '';
      };

      serveApp = pkgs.writeShellApplication {
        name = "quartz-serve";
        runtimeInputs = [node];
        text = ''
          # nutzt den lokalen working tree (content/, quartz.config.ts, etc.)
          exec ${node}/bin/node ./quartz/bootstrap-cli.mjs build --serve "$@"
        '';
      };
    in {
      packages.default = quartzBuild;

      apps.serve = {
        type = "app";
        program = "${serveApp}/bin/quartz-serve";
      };

      # optional: nix run ohne .#serve starten
      apps.default = {
        type = "app";
        program = "${serveApp}/bin/quartz-serve";
      };
    });
}
