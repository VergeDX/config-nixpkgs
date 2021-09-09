let
  pkgs = import <nixpkgs> { };
  fishui = pkgs.stdenv.mkDerivation rec {
    name = "fishui";
    version = "0.4";

    src = pkgs.fetchFromGitHub {
      owner = "cutefishos";
      repo = name;
      rev = version;
      sha256 = "sha256-gwG/9OOXLDSWyBHz3yyc2hGor9r37U1rADEol/4Twjo=";
    };

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

    # https://github.com/cutefishos/fishui/blob/0.4/CMakeLists.txt#L49-L57
    installPhase = ''
      make install

      cd /build/qtbase-everywhere-src-5.15.2/
      mv '$(out)' qt && cd qt
      mv '$(qtQmlPrefix)' qml

      cd $out/lib
      mv /build/qtbase-everywhere-src-5.15.2/qt .
    '';
  };
in
fishui
