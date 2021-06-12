{ stdenv, fetchgit, pkgs }:
stdenv.mkDerivation rec {
  name = "ssf2fcitx";
  version = "a8e7e1d7";

  src = fetchgit {
    url = "https://github.com/VOID001/ssf2fcitx";
    rev = "${version}bb7287582c184d4a8dd64473ad94aa2b";
    sha256 = "sha256-6r4TCL0Vhd2qb3efATmYmvjgFI250jSkpcbXhQzm5k4=";
  };

  nativeBuildInputs = [ pkgs.qt5.wrapQtAppsHook ];
  buildInputs = [ pkgs.cmake pkgs.openssl pkgs.pkg-config pkgs.libunistring ];
  prebuildPhase = "cmake ../";
}
