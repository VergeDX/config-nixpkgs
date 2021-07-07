{ stdenv, fetchurl, dpkg, autoPatchelfHook, pkgs, ... }:
stdenv.mkDerivation rec {
  name = "liblua5.2-0";
  version = "5.2.4-1";

  src = fetchurl {
    url = "https://mirrors.bfsu.edu.cn/ubuntu/pool/main/l/lua5.2/${name}_${version}.1build1_amd64.deb";
    sha256 = "sha256-k5Nem5c/BSRAvJcTUep3htG9PQw9aL4RtjKsWSHxfVY=";
  };

  unpackCmd = "dpkg-deb -x ${src} .";
  nativeBuildInputs = [
    dpkg
    autoPatchelfHook

    pkgs.gcc-unwrapped.lib
  ];

  installPhase = ''
    mkdir -p $out && cp -r * $out
    cd $out/lib/ && ln -s ./x86_64-linux-gnu/liblua5.2.so.0 .
  '';
}
