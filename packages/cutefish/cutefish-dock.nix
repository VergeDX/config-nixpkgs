let
  pkgs = import <nixpkgs> { };
  cutefish-dock = pkgs.stdenv.mkDerivation rec {
    name = "cutefish-dock";
    version = "0.4";

    src = pkgs.fetchgit {
      url = "https://github.com/cutefishos/dock";
      rev = version;
      sha256 = "sha256-lW3+shAKSYC2iQU67MGrPybnBM+kWTqRT2pavs1AGGk=";
    };

    nativeBuildInputs = [ pkgs.cmake pkgs.libsForQt5.wrapQtAppsHook ];
    buildInputs = [
      pkgs.libsForQt5.qt5.qtx11extras
      pkgs.libsForQt5.qt5.qttools
      pkgs.pkgs.libsForQt5.qt5.qtquickcontrols2
      pkgs.libsForQt5.kwindowsystem

      (pkgs.callPackage ./fishui.nix { })
      pkgs.libsForQt5.qt5.qtgraphicaleffects
    ];

    installPhase = ''
      sed -i 's@/var/empty@'"$out"'@g' cmake_install.cmake
      make install
    '';
  };
in
cutefish-dock
