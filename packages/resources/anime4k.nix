{ stdenv, fetchurl, unzip, ... }:
stdenv.mkDerivation rec {
  name = "Anime4K";
  version = "3.1";

  src = fetchurl {
    url = "https://github.com/bloc97/${name}/releases/download/${version}/${name}_v${version}.zip";
    sha256 = "sha256-FArxfPlnH5QNXV/mTTHd5jjYzSrbS2bB+aRZupaOPLg=";
  };

  buildInputs = [ unzip ];
  unpackPhase = "echo";
  installPhase = ''
    mkdir -p $out/shaders
    unzip -x ${src} -d $out/shaders
  '';
}
