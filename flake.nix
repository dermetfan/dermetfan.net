{
  inputs = {
    nixpkgs.follows = "styx/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
    styx = {
      url = "github:dermetfan/styx/modernize";
      inputs.utils.follows = "flake-utils";
    };
  };

  outputs = { self, nixpkgs, flake-utils, styx, ... } @ inputs:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in rec {
      packages = self.outputs.overlay {} pkgs;

      defaultPackage = packages.dermetfan-blog;

      legacyPackages = pkgs.appendOverlays [ self.outputs.overlay ];

      apps.styx = {
        type = "app";
        program = "${styx.defaultPackage.${system}}/bin/styx";
      };

      defaultApp = apps.styx;

      devShell = pkgs.mkShell {
        packages = [ styx.defaultPackage.${system} ];
      };
    }) // rec {
      overlays.dermetfan-blog = final: prev: {
        dermetfan-blog = (import ./site.nix {
          pkgs = prev;
          styx = styx.defaultPackage.${prev.system};
          styxLib = styx.lib.${prev.system};
        }).site;
      };

      overlay = overlays.dermetfan-blog;
    };
}
