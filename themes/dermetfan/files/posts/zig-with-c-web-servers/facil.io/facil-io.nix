{ stdenv, fetchFromGitHub,
  openssl # cmake
}:

stdenv.mkDerivation rec {
  name = "facil.io";
  version = "0.7.3";

  src = fetchFromGitHub {
    owner = "boazsegev";
    repo = "facil.io";
    rev = version;
    sha256 = "03r4wwb5p011mwxxqdmhzns1jlhhg6l4ldc5hm671yy1549xa0fz";
  };

  buildInputs = [
    # cmake
    openssl
  ];

  dontBuild = true;

  installTargets = [ "lib" ];

  postInstall = ''
    mkdir $out/lib
    mv tmp/libfacil.so $out/lib/

    mv libdump/include $out/
  '';
}
