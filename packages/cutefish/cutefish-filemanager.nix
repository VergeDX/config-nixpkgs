let
  pkgs = import <nixpkgs> { };
  cutefish-filemanager = pkgs.stdenv.mkDerivation rec {
    name = "cutefish-filemanager";
    version = "0.4";

    src = pkgs.fetchgit {
      url = "https://github.com/cutefishos/filemanager";
      rev = version;
      sha256 = "sha256-cjkXUTxwNDgbfv+0eMWNBA6kWCl6HVCG0k4gY6Pb9bM=";
    };

    nativeBuildInputs = [ pkgs.cmake pkgs.libsForQt5.wrapQtAppsHook ];
    buildInputs = [
      pkgs.libsForQt5.qt5.qttools
      pkgs.libsForQt5.kio
      pkgs.pkgs.libsForQt5.qt5.qtquickcontrols2

      (pkgs.callPackage ./fishui.nix { })
      pkgs.libsForQt5.qt5.qtgraphicaleffects
    ];

    installPhase = ''
      sed -i 's@/var/empty@'"$out"'@g' cmake_install.cmake
      make install
    '';

    postFixup = ''
      wrapProgram $out/bin/cutefish-filemanager --set PATH ${pkgs.libsForQt5.kinit}/bin
    '';
  };
in
cutefish-filemanager
