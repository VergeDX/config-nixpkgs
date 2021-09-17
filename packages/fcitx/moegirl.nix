{ stdenv, fetchurl }:
stdenv.mkDerivation
rec {
  name = "moegirl";
  version = "20210415";
  fileName = "${name}-${version}.dict";

  src = fetchurl {
    url = "https://github.com/outloudvi/mw2fcitx/releases/download/${version}/moegirl.dict";
    sha256 = "sha256-odujj/0gcl9PlJYKEiOd49S05xiVvDzEYE1c6CvpkD8=";
  };

  unpackPhase = "mkdir $out && cp ${src} $out";
  installPhase = "cd $out && mv *.dict ${fileName}";
}
