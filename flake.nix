{
  description = "Quartz (v4) nix-native build + serve";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    eis-notes = {
      url = "git+ssh://code.siemens.com/eis/eis-notes.git";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    eis-notes,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {inherit system;};

      node = pkgs.nodejs_22;

      quartzBuild = pkgs.buildNpmPackage {
        pname = "quartz";
        version = "4.5.2";

        src = self;

        inherit node;

        npmDepsHash = "sha256-7u+VlIx44B3/ivM9vLMIOn+e4TL4eS6B682vhS+Ikb4=";

        QUARTZ_BASE_URL = "m4rc2a.github.io/eis-wiki/";

        postUnpack = ''
          cp -r ${eis-notes} source/content
        '';

        buildInputs = [
          pkgs.source-sans
          pkgs.atkinson-hyperlegible-next
          pkgs.jetbrains-mono
          pkgs.atkinson-hyperlegible-mono
        ];

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
          mkdir -p $out/public/static/fonts

          copy_woff2() {
            local src="$1"
            if [ -d "$src" ]; then
              find "$src" -type f -name '*.woff2' -exec cp -v '{}' "$out/public/static/fonts/" \;
            fi
          }

          copy_woff2 ${pkgs.source-sans}/share/fonts
          copy_woff2 ${pkgs.jetbrains-mono}/share/fonts
          copy_woff2 ${pkgs.jetbrains-mono}/share/fonts/webfonts
          copy_woff2 ${pkgs.source-sans}/share/fonts/woff2

          cat > $out/public/static/fonts/fonts.css <<'EOF'
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
          exec ${node}/bin/node ./quartz/bootstrap-cli.mjs build --serve "$@"
        '';
      };
    in {
      packages.default = quartzBuild;

      apps.serve = {
        type = "app";
        program = "${serveApp}/bin/quartz-serve";
      };

      apps.default = {
        type = "app";
        program = "${serveApp}/bin/quartz-serve";
      };
    });
}
