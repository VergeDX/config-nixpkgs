let
  pkgs = import <nixpkgs> { };
  cutefish-screenlocker = pkgs.stdenv.mkDerivation rec {
    name = "cutefish-screenlocker";
    version = "0.4";

    src = pkgs.fetchgit {
      url = "https://github.com/cutefishos/screenlocker";
      rev = version;
      sha256 = "sha256-Wj3bNWdYw0Nms4/Xqanf/ACxD9R/WfDYCUtw1QYL1PA=";
    };

    # https://github.com/cutefishos/screenlocker/blob/0.4/screenlocker/qml/LockScreen.qml#L45
    patchPhase = ''
      sed -i '45d' screenlocker/qml/LockScreen.qml
    '';

    nativeBuildInputs = [ pkgs.cmake pkgs.libsForQt5.wrapQtAppsHook ];
    buildInputs = [
      pkgs.libsForQt5.qt5.qtx11extras
      pkgs.libsForQt5.qt5.qttools
      pkgs.linux-pam

      pkgs.pkgs.libsForQt5.qt5.qtquickcontrols2
      (pkgs.callPackage ./fishui.nix { })
      (pkgs.callPackage ./libcutefish.nix { })
      pkgs.libsForQt5.qt5.qtgraphicaleffects
    ];

    installPhase = ''
      sed -i 's@/var/empty@'"$out"'@g' cmake_install.cmake
      make install
    '';
  };
in
cutefish-screenlocker
