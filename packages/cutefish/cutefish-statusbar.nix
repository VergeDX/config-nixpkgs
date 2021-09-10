let
  pkgs = import <nixpkgs> { };
  cutefish-statusbar = pkgs.stdenv.mkDerivation rec {
    name = "cutefish-statusbar";
    version = "0.4";

    src = pkgs.fetchgit {
      url = "https://github.com/cutefishos/statusbar";
      rev = version;
      sha256 = "sha256-Z6JZni2WD74QP5udKvXK5JmoFmD9LfsktlfgMV1fTQo=";
    };

    nativeBuildInputs = [
      pkgs.cmake
      pkgs.libsForQt5.wrapQtAppsHook
      pkgs.pkg-config
    ];

    buildInputs = [
      pkgs.libsForQt5.qt5.qtx11extras
      pkgs.libsForQt5.qt5.qttools
      pkgs.libsForQt5.qt5.qtquickcontrols2
      pkgs.libsForQt5.kwindowsystem
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
cutefish-statusbar
