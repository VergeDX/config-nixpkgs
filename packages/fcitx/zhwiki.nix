{ stdenv, fetchurl }:
stdenv.mkDerivation rec {
  name = "fcitx5-pinyin-zhwiki";
  version = "0.2.3";
  fileName = "zhwiki-20210605.dict";

  src = fetchurl {
    url = "https://github.com/felixonmars/fcitx5-pinyin-zhwiki/releases/download/${version}/zhwiki-20210605.dict";
    sha256 = "sha256-rEWmUi1Q5CllD/LmKUm8sbLnD2C+NEdUCp8To2S9PLQ=";
  };

  unpackPhase = "mkdir $out && cp ${src} $out";
  installPhase = "cd $out && mv *.dict ${fileName}";
}
