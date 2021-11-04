{ stdenv, fetchurl }:
stdenv.mkDerivation rec {
  name = "gitalias";
  fileName = "${name}.txt";

  # https://github.com/GitAlias/gitalias#install
  src = fetchurl {
    url = "https://raw.githubusercontent.com/GitAlias/${name}/master/${fileName}";
    sha256 = "sha256-owo2Z24MraRisucY7PqOj4s619QTZMjSF+YQ5vU/Dhw=";
  };

  unpackPhase = "echo";
  installPhase = "mkdir $out && cp ${src} $out/${fileName}";
}
