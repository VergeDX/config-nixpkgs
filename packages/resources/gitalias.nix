{ stdenv, fetchurl }:
stdenv.mkDerivation rec {
  name = "gitalias";
  fileName = "${name}.txt";

  # https://github.com/GitAlias/gitalias#install
  src = fetchurl {
    url = "https://raw.githubusercontent.com/GitAlias/${name}/master/${fileName}";
    sha256 = "sha256-77GElkqy1EG57+xN8gidaaAtoRb+hPjJ2Usomwe4L3g=";
  };

  unpackPhase = "echo";
  installPhase = "mkdir $out && cp ${src} $out/${fileName}";
}
