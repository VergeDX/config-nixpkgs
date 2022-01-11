{ stdenv, fetchurl }:
stdenv.mkDerivation rec {
  name = "gitalias";
  fileName = "${name}.txt";

  # https://github.com/GitAlias/gitalias#install
  src = fetchurl {
    url = "https://raw.githubusercontent.com/GitAlias/${name}/master/${fileName}";
    sha256 = "sha256-sKHqFo1legTImVxNhykmCDY24pUi1WWpUVgnUN2ujqk=";
  };

  unpackPhase = "echo";
  installPhase = "mkdir $out && cp ${src} $out/${fileName}";
}
