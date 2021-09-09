let
  pkgs = import <nixpkgs> { };
  fishui = pkgs.stdenv.mkDerivation rec {
    name = "libcutefish";
    version = "0.4";

    src = pkgs.fetchFromGitHub {
      owner = "cutefishos";
      repo = name;
      rev = version;
      sha256 = "sha256-hkwpGrCgr9l4vKW0NTNx6Tzcd7oFRKfg6uGvsk1uXJE=";
    };

    nativeBuildInputs = [ pkgs.cmake ];
    dontWrapQtApps = true;
    buildInputs = [
      pkgs.libsForQt5.qt5.qtbase
      pkgs.libsForQt5.qt5.qtquickcontrols
      pkgs.libsForQt5.qt5.qtquickcontrols2
      pkgs.libsForQt5.bluez-qt
      pkgs.libsForQt5.networkmanager-qt
      pkgs.libsForQt5.modemmanager-qt
      pkgs.libsForQt5.libkscreen
      pkgs.libsForQt5.kio
      pkgs.libsForQt5.qt5.qtsensors
    ];
  };
in
fishui
