{ stdenv, fetchgit, cmake, wrapQtAppsHook, pkg-config, callPackage, qrencode, zbar, ... }:
let libQtShadowsocks = callPackage ../libs/libQtShadowsocks.nix { };
in
stdenv.mkDerivation rec {
  pname = "shadowsocks-qt5";
  version = "3.0.1";

  src = fetchgit {
    url = "https://github.com/shadowsocks/${pname}";
    rev = "v${version}";
    hash = "sha256-Ttfo2MvosG3jgK4MkOMYznocKQnDdGwNKwus30dMgvI=";
  };

  nativeBuildInputs = [ cmake wrapQtAppsHook pkg-config ];
  buildInputs = [ libQtShadowsocks qrencode zbar ];
}
