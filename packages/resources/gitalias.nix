{ stdenv, fetchurl }:
stdenv.mkDerivation rec {
  name = "gitalias";
  fileName = "${name}.txt";

  # https://github.com/GitAlias/gitalias#install
  src = fetchurl {
    url = "https://raw.githubusercontent.com/GitAlias/${name}/master/${fileName}";
    sha256 = "sha256-Ov333cW2PbvX5fp1KAHfgXR4SCwjoolHGCHBf0xskkE=";
  };

  unpackPhase = "echo";
  installPhase = "mkdir $out && cp ${src} $out/${fileName}";
}
