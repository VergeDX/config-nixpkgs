{ pkgs, ... }:
pkgs.stdenv.mkDerivation rec {
  name = "fishui";
  version = "0.4";

  src = pkgs.fetchFromGitHub {
    owner = "cutefishos";
    repo = name;
    rev = version;
    sha256 = "sha256-gwG/9OOXLDSWyBHz3yyc2hGor9r37U1rADEol/4Twjo=";
  };

  # https://github.com/cutefishos/fishui/blob/0.4/CMakeLists.txt#L49-L52
  # https://www.folkstalk.com/2013/03/sed-remove-lines-file-unix-examples.html
  # https://archlinux.org/packages/community/x86_64/fishui/
  # http://www.yourownlinux.com/2015/04/sed-command-in-linux-append-and-insert-lines-to-file.html
  patchPhase = ''
    sed -i '49,52d' CMakeLists.txt
    sed -i '49 i set(INSTALL_QMLDIR "'"$out"'/${pkgs.qt5.qtbase.qtQmlPrefix}")' CMakeLists.txt
  '';

  nativeBuildInputs = [ pkgs.cmake ];
  dontWrapQtApps = true;
  buildInputs = [
    pkgs.libsForQt5.qt5.qtbase
    pkgs.libsForQt5.qt5.qtquickcontrols
    pkgs.libsForQt5.qt5.qtquickcontrols2
    pkgs.libsForQt5.qt5.qtx11extras
    pkgs.libsForQt5.kwindowsystem
    pkgs.extra-cmake-modules
  ];
}
