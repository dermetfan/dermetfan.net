{ pkgs ? import ./nixpkgs.nix, ... } @ args:

(pkgs.callPackage (import ./site.nix) args).site
