{ pkgs ? import <nixpkgs> {} }:

(pkgs.callPackage (import ./site.nix) { inherit pkgs; }).site
