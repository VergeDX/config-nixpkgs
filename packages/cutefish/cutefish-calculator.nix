let
  pkgs = import <nixpkgs> { };
  cutefish-calculator = pkgs.stdenv.mkDerivation rec {
    name = "cutefish-calculator";
    version = "0.4";

    src = pkgs.fetchgit {
      url = "https://github.com/cutefishos/calculator";
      rev = version;
      sha256 = "sha256-DMsRVI9QGDYLoJW99FofQHAztnIEVyJ2PT4xBOq5rbg=";
    };

    nativeBuildInputs = [ pkgs.cmake pkgs.libsForQt5.wrapQtAppsHook ];
    buildInputs = [
      pkgs.pkgs.libsForQt5.qt5.qtquickcontrols2
      pkgs.libsForQt5.qt5.qttools

      (pkgs.callPackage ./fishui.nix { })
      pkgs.libsForQt5.qt5.qtgraphicaleffects
    ];

    installPhase = ''
      sed -i 's@/var/empty@'"$out"'@g' cmake_install.cmake
      make install
    '';
  };
in
cutefish-calculator
