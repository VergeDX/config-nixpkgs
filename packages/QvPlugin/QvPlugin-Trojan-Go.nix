{ stdenv, fetchgit, cmake, libsForQt5, ... }:
stdenv.mkDerivation rec {
  pname = "QvPlugin-Trojan-Go";
  version = "3.0.0";

  src = fetchgit {
    url = "https://github.com/Qv2ray/${pname}";
    rev = "v${version}";
    sha256 = "sha256-UdW6hVOag+atsREoNGcG8ZYSlTBSiNJ0dmpqie4BYTc=";
  };

  nativeBuildInputs = [ cmake ];
  buildInputs = [ libsForQt5.qt5.qtbase ];
  dontWrapQtApps = true;
}
