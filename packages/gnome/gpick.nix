{ stdenv, fetchurl, dpkg, autoPatchelfHook, wrapGAppsHook, pkgs, ... }:
stdenv.mkDerivation rec {
  name = "gpick";
  version = "0.2.5+git20161221-1build1";

  src = fetchurl {
    url = "http://mirrors.bfsu.edu.cn/ubuntu/pool/universe/g/${name}/${name}_${version}_amd64.deb";
    sha256 = "sha256-eFIkoj0eeDlyV861uD2s2LwaKbp0E4EgXAzveFsvEX4=";
  };

  unpackCmd = "dpkg-deb -x ${src} .";
  installPhase = "mkdir -p $out && cp -r * $out";
  nativeBuildInputs = [
    dpkg
    autoPatchelfHook
    wrapGAppsHook
  ];

  buildInputs = [
    pkgs.gtk2-x11
    pkgs.boost165
    (pkgs.callPackage ./liblua5.2-0.nix { })
  ];
}
