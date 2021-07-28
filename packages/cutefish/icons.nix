{ stdenv, fetchFromGitHub, cmake, ... }:
stdenv.mkDerivation rec {
  name = "cutefish-icons";
  version = "0.3";

  src = fetchFromGitHub {
    owner = "cutefishos";
    repo = "icons";
    rev = version;
    sha256 = "sha256-blDSIEcx3zdyfhJXYxWOArpYQiCmDYlGLSXKZu3xVBE=";
  };

  nativeBuildInputs = [ cmake ];
  installPhase = ''
    make DESTDIR=$out install
    cd $out/var/empty/ && mv ./share/ ../../
    cd ../../ && rm -r ./var/
  '';
}
