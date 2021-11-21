{ stdenv, fetchurl, ... }:
stdenv.mkDerivation rec {
  pname = "subconverter";
  version = "0.7.1";

  src = fetchurl {
    url = "https://github.com/tindy2013/${pname}/releases/download/v${version}/${pname}_linux64.tar.gz";
    hash = "sha256-l4psDl06DHexJpVnpoxPN89BP5XEAUC3lD9v/LUiVbQ=";
  };

  installPhase = "mkdir $out/ && cp -r * $out/";
}
