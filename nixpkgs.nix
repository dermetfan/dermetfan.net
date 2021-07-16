import (builtins.fetchTarball {
  name = "nixpkgs";
  url = "https://github.com/nixos/nixpkgs/archive/aa576357673d609e618d87db43210e49d4bb1789.tar.gz";
  sha256 = "1868s3mp0lwg1jpxsgmgijzddr90bjkncf6k6zhdjqihf0i1n2np";
}) {
  overlays = [
    (self: super: {
      styx = super.styx.overrideAttrs (oldAttrs: {
        patches = [
          (super.writeText "nix-config-option.patch" ''
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
      });
    })
  ];
}
