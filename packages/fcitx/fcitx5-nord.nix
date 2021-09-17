{ stdenv, fetchgit }:
stdenv.mkDerivation rec {
  name = "fcitx5-nord";
  version = "bab8b8a";

  src = fetchgit {
    url = "https://github.com/tonyfettes/fcitx5-nord";
    rev = "${version}d4bd39a400b997b4b7d3a12f4608c15e7";
    sha256 = "sha256-W876OhlAjjrGaBI2odV8Keh9qrdP7pelExizQwxLYN0=";
  };

  # https://github.com/hosxy/Fcitx5-Material-Color#%E6%89%8B%E5%8A%A8%E5%AE%89%E8%A3%85
  unpackPhase = "mkdir $out";
  installPhase = "cd ${src} && cp -r * $out";
}
