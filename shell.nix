{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = [
    (pkgs.styx.overrideAttrs (oldAttrs: {
      patches = [
        (pkgs.writeText "41.patch" ''
          diff --git a/derivation.nix b/derivation.nix
          index 34c16be..96e2a9c 100644
          --- a/derivation.nix
          +++ b/derivation.nix
          @@ -17 +17 @@ stdenv.mkDerivation rec {
          -  server = "''${caddy.bin}/bin/caddy";
          +  server = "''${caddy}/bin/caddy";
        '')

        (pkgs.writeText "nix-config-option.patch" ''
          diff --git a/src/styx.sh b/src/styx.sh
          index a54e9d7..b1a4bff 100644
          --- a/src/styx.sh
          +++ b/src/styx.sh
          @@ -43,0 +44 @@ Generic options:
          +        --option NAME VAL      Nix configuration option to pass on to the Nix build.
          @@ -238,0 +240,3 @@ while [ "$#" -gt 0 ]; do
          +    --option)
          +      extraFlags+=("$i" "$1" "$2"); shift 2
          +      ;;
        '')
      ];
    }))
  ];
}
