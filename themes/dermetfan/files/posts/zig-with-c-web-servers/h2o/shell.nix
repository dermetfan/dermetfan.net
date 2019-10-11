let
  pkgs = import (builtins.fetchTarball {
    url = https://github.com/nixos/nixpkgs/archive/b2935fbeceaea0b64df4401545d7c8ea29102120.tar.gz;
    sha256 = "1z1631v7q2c8mavy7xnvfx0wz34zd49jqmjg66nk0qgsi605m3qp";
  }) {};

  h2o = pkgs.h2o.overrideAttrs (oldAttrs: with oldAttrs; rec {
    patches = [
      # https://github.com/ziglang/zig/pull/4165
      # https://github.com/ziglang/zig/issues/1499
      ./h2o-no-bitfields.patch
    ];
  });
in

pkgs.stdenv.mkDerivation {
  name = "h2o-zig-env";

  nativeBuildInputs =
    (with pkgs; [
      (zig.overrideAttrs (oldAttrs: with oldAttrs; rec {
        version = "5acc8afb5f9674b9b7b290635e9c2837872b8a93";

        src = fetchFromGitHub {
          owner = "ziglang";
          repo = pname;
          rev = version;
          sha256 = "084w97lgwpdmag2xbm5hkxy4glqcf36nrjif69aa51m3n6r821pv";
        };
      }))

      openssl.dev
    ]) ++ [
      h2o.dev
    ];

  buildInputs =
    (with pkgs; [
      openssl.out
    ]) ++ [
      h2o.lib
    ];
}
