let
  pkgs = import <nixpkgs> { };
  libcutefish = pkgs.stdenv.mkDerivation rec {
    name = "libcutefish";
    version = "0.4";

    src = pkgs.fetchgit {
      url = "https://github.com/cutefishos/libcutefish";
      rev = version;
      sha256 = "sha256-hkwpGrCgr9l4vKW0NTNx6Tzcd7oFRKfg6uGvsk1uXJE=";
    };

    # https://github.com/cutefishos/libcutefish/blob/0.4/CMakeLists.txt#L25-L28
    patchPhase = ''
      sed -i '25,28d' CMakeLists.txt
      sed -i '25 i set(INSTALL_QMLDIR "'"$out"'/${pkgs.qt5.qtbase.qtQmlPrefix}")' CMakeLists.txt
    '';

    nativeBuildInputs = [ pkgs.cmake ];
    dontWrapQtApps = true;
    buildInputs = [
      pkgs.libsForQt5.qt5.qtbase
      pkgs.libsForQt5.qt5.qtdeclarative
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
libcutefish
