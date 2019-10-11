let
  pkgs = import (builtins.fetchTarball {
    url = https://github.com/nixos/nixpkgs/archive/8130f3c1c2bb0e533b5e150c39911d6e61dcecc2.tar.gz;
    sha256 = "154nrhmm3dk5kmga2w5f7a2l6j79dvizrg4wzbrcwlbvdvapdgkb";
  }) {};
in

pkgs.stdenv.mkDerivation {
  name = "facil-zig-env";

  buildInputs =
    (with pkgs; [
      (zig.overrideAttrs (oldAttrs: with oldAttrs; rec {
        version = "fb6b94f80fed42b4c690b43a875bf0a58977493e";

        src = fetchFromGitHub {
          owner = "ziglang";
          repo = pname;
          rev = version;
          sha256 = "0qaz1z024yf53k82d0wmqsa1b6iwpwpj0rpnbja8y9dbxsbjkkab";
        };
      }))

      (pkgs.callPackage ./facil-io.nix {})
      openssl
    ]);
}
