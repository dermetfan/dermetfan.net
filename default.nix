{ pkgs ? import ./nixpkgs.nix }:

(pkgs.callPackage (import ./site.nix) { inherit pkgs; }).site
