{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
	buildInputs = [
		(pkgs.styx.overrideAttrs (oldAttrs: {
			nativeBuildInputs = [ pkgs.diffutils ];
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
			];
		}))
	];
}
