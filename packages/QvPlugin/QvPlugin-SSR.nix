{ stdenv, fetchgit, cmake, libsForQt5, ... }:
stdenv.mkDerivation rec {
  pname = "QvPlugin-SSR";
  version = "3.0.0";

  src = fetchgit {
    url = "https://github.com/Qv2ray/${pname}";
    rev = "v${version}";
    hash = "sha256-PKyNunozXqYdfNSTOBy31a/fSffvo6EBMbtYqcm/ApI=";
  };

  nativeBuildInputs = [ cmake ];
  buildInputs = [ libsForQt5.qt5.qtbase ];
  dontWrapQtApps = true;
}
