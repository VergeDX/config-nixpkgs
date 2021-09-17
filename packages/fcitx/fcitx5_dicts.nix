{ stdenv, fetchurl }:
stdenv.mkDerivation rec {
  name = "fcitx5_dicts";
  version = "0.0.1";
  fileName = "cedict.dict";

  src = fetchurl {
    url = "https://github.com/cathaysia/${name}/releases/download/${version}/${fileName}";
    sha256 = "sha256-1FaHp9+f49J9Y/750ye+ulUb6q5rfwHKJl1Sdj7AtUg=";
  };

  unpackPhase = "mkdir $out && cp ${src} $out";
  installPhase = "cd $out && mv * ${fileName}";
}
