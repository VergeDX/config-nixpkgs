{ stdenv, fetchgit }:
stdenv.mkDerivation rec {
  name = "peda";
  version = "v1.2";

  src = fetchgit {
    url = "https://github.com/longld/${name}";
    rev = version;
    sha256 = "sha256-vtNJ9WHCUtZmIn/IXwwtKrZx1i/az+gMmW6fLd67QYQ=";
  };

  installPhase = ''
    mkdir -p $out && cp -r ${src} $out
    cd $out && mv * ${name}
  '';
}
