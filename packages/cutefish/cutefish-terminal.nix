let
  pkgs = import <nixpkgs> { };
  cutefish-terminal = pkgs.stdenv.mkDerivation rec {
    name = "cutefish-terminal";
    version = "0.4";

    src = pkgs.fetchgit {
      url = "https://github.com/cutefishos/terminal";
      rev = version;
      sha256 = "sha256-Gz0FVVlt/F++kBRpRGeJjkZQ9ZecBDZGLz45DzQlrok=";
    };

    # https://github.com/cutefishos/terminal/blob/0.4/CMakeLists.txt#L22-L25
    patchPhase = ''
      sed -i '22,25d' CMakeLists.txt
      sed -i '22 i set(INSTALL_QMLDIR "'"$out"'/${pkgs.qt5.qtbase.qtQmlPrefix}")' CMakeLists.txt
    '';

    nativeBuildInputs = [ pkgs.cmake pkgs.libsForQt5.wrapQtAppsHook ];
    buildInputs = [
      pkgs.libsForQt5.qt5.qtquickcontrols2
      pkgs.libsForQt5.qt5.qttools

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
cutefish-terminal
