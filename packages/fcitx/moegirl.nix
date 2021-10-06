{ stdenv, fetchurl }:
stdenv.mkDerivation
rec {
  name = "moegirl";
  version = "20210914";
  fileName = "${name}-${version}.dict";

  src = fetchurl {
    url = "https://github.com/outloudvi/mw2fcitx/releases/download/${version}/moegirl.dict";
    sha256 = "sha256-5YP18SVnWcc8qcc450efWCQcLi3yFW/0nIcKjUf2OEA=";
  };

  unpackPhase = "mkdir $out && cp ${src} $out";
  installPhase = "cd $out && mv *.dict ${fileName}";
}
