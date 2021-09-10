let
  pkgs = import <nixpkgs> { };
  cutefish-launcher = pkgs.stdenv.mkDerivation rec {
    name = "cutefish-launcher";
    version = "0.4";

    src = pkgs.fetchgit {
      url = "https://github.com/cutefishos/launcher";
      rev = version;
      sha256 = "sha256-h1MeRQkbCNYzU3TV8Rl79iZx0J1N68YONspfKKmtyfI=";
    };

    # https://github.com/cutefishos/launcher/blob/0.4/qml/main.qml#L100
    patchPhase = ''
      sed -i '100d' qml/main.qml
    '';

    nativeBuildInputs = [ pkgs.cmake pkgs.libsForQt5.wrapQtAppsHook ];
    buildInputs = [
      pkgs.pkgs.libsForQt5.qt5.qtquickcontrols2
      pkgs.libsForQt5.qt5.qttools
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
cutefish-launcher
