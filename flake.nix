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

        # 1) Beim ersten Build: pkgs.lib.fakeHash einsetzen, Build laufen lassen,
        #    den "got: sha256-..." Wert aus der Fehlermeldung hier eintragen.
        npmDepsHash = pkgs.lib.fakeHash;

        # Wir nutzen das Quartz-CLI direkt (statt npm run build, das es nicht gibt)
        buildPhase = ''
          runHook preBuild
          ${node}/bin/node ./quartz/bootstrap-cli.mjs build
          runHook postBuild
        '';

        installPhase = ''
          runHook preInstall
          mkdir -p $out
          cp -r public $out/public
          runHook postInstall
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
