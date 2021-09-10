let
  pkgs = import <nixpkgs> { };
  cutefish-settings = pkgs.stdenv.mkDerivation rec {
    name = "cutefish-settings";
    version = "0.4";

    src = pkgs.fetchgit {
      url = "https://github.com/cutefishos/settings";
      rev = version;
      sha256 = "sha256-Lh6oN/KrPEpQ4v9u27KRY5bW4eZ20G+DqlUCr4/Prb8=";
    };

    nativeBuildInputs = [
      pkgs.cmake
      pkgs.libsForQt5.wrapQtAppsHook
      pkgs.pkg-config
    ];

    buildInputs = [
      pkgs.libsForQt5.qt5.qtquickcontrols2
      pkgs.libsForQt5.qt5.qtx11extras
      pkgs.libsForQt5.qt5.qttools
      pkgs.libsForQt5.kwindowsystem
      pkgs.libsForQt5.networkmanager-qt
      pkgs.libsForQt5.modemmanager-qt
      pkgs.xorg.libXcursor

      (pkgs.callPackage ./fishui.nix { })
      pkgs.libsForQt5.qt5.qtgraphicaleffects
      (pkgs.callPackage ./libcutefish.nix { })
    ];

    installPhase = ''
      sed -i 's@/var/empty@'"$out"'@g' cmake_install.cmake
      make install
    '';
  };
in
cutefish-settings
