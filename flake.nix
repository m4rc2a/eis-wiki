{
  description = "EIS Wiki — Quartz v4 nix-native build + serve";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    eis-notes = {
      url = "git+ssh://code.siemens.com/eis/eis-notes.git";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    eis-notes,
  }: let
    forAllSystems = fn:
      nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed
      (system: fn nixpkgs.legacyPackages.${system});
  in {
    packages = forAllSystems (pkgs: let
      node = pkgs.nodejs_22;

      mkQuartzBuild = {
        baseUrl ? "m4rc2a.github.io/eis-wiki/",
      }:
        pkgs.buildNpmPackage {
          pname = "quartz";
          version = "4.5.2";

          src = self;

          inherit node;

          npmDepsHash = "sha256-7u+VlIx44B3/ivM9vLMIOn+e4TL4eS6B682vhS+Ikb4=";

          postUnpack = ''
            cp -r ${eis-notes} source/content
          '';

          postPatch = ''
            substituteInPlace quartz.config.ts \
              --replace-fail '__QUARTZ_BASE_URL__' '${baseUrl}'
          '';

          buildInputs = [
            pkgs.woff2
            pkgs.source-sans
            pkgs.jetbrains-mono
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

            # Source Sans Pro: OTF -> WOFF2 (nixpkgs ships no woff2)
            tmpdir=$(mktemp -d)
            cp ${pkgs.source-sans}/share/fonts/opentype/SourceSans3-Regular.otf "$tmpdir/"
            cp ${pkgs.source-sans}/share/fonts/opentype/SourceSans3-Semibold.otf "$tmpdir/"
            ${pkgs.woff2}/bin/woff2_compress "$tmpdir/SourceSans3-Regular.otf"
            ${pkgs.woff2}/bin/woff2_compress "$tmpdir/SourceSans3-Semibold.otf"
            cp "$tmpdir/"*.woff2 $out/public/static/fonts/

            # JetBrains Mono: already ships WOFF2 in nixpkgs
            cp ${pkgs.jetbrains-mono}/share/fonts/WOFF2/JetBrainsMono-Regular.woff2 $out/public/static/fonts/
          '';
        };

      quartzBuild = mkQuartzBuild {};
    in {
      default = quartzBuild;
      quartz = quartzBuild;
      quartz-github = mkQuartzBuild {baseUrl = "m4rc2a.github.io/eis-wiki/";};
      quartz-gitlab = mkQuartzBuild {baseUrl = "eis-wiki-2e3f3a.code.siemens.io/";};
      quartz-codeberg = mkQuartzBuild {baseUrl = "m4rc2a.codeberg.page/eis-wiki/";};

      docker = pkgs.dockerTools.buildImage {
        name = "eis-wiki";
        tag = "latest";

        copyToRoot = [
          quartzBuild
          pkgs.darkhttpd
        ];

        config = {
          Cmd = [
            "${pkgs.darkhttpd}/bin/darkhttpd"
            "/public/public"
            "--port"
            "8080"
          ];
          ExposedPorts = {
            "8080/tcp" = {};
          };
        };
      };
    });

    apps = forAllSystems (pkgs: let
      node = pkgs.nodejs_22;
    in {
      default = {
        type = "app";
        program = "${pkgs.writeShellApplication {
          name = "quartz-serve";
          runtimeInputs = [node];
          text = ''
            exec ${node}/bin/node ./quartz/bootstrap-cli.mjs build --serve "$@"
          '';
        }}/bin/quartz-serve";
      };

      serve = {
        type = "app";
        program = "${pkgs.writeShellApplication {
          name = "quartz-serve";
          runtimeInputs = [node];
          text = ''
            exec ${node}/bin/node ./quartz/bootstrap-cli.mjs build --serve "$@"
          '';
        }}/bin/quartz-serve";
      };
    });

    devShells = forAllSystems (pkgs: {
      default = pkgs.mkShell {
        packages = [pkgs.nodejs_22];
      };
    });
  };
}
