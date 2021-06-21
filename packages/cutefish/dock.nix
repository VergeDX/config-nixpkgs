{ pkgs, ... }:
let
  cutefish-dock = pkgs.stdenv.mkDerivation rec {
    name = "cutefish-dock";
    version = "0.2-1";

    src = pkgs.fetchurl {
      url = "https://mirror.pseudoform.org/community/os/x86_64/${name}-${version}-x86_64.pkg.tar.zst";
      sha256 = "sha256-FCCQhwQc271vKHrnNAObf7ngSKcY0sDEF2jWUL19hR8=";
    };

    installPhase = "mkdir $out && cp -r bin share $out";
    buildInputs = [ pkgs.zstd ];
  };
in
pkgs.buildFHSUserEnv {
  name = cutefish-dock.name;
  runScript = "${cutefish-dock.out}/bin/cutefish-dock";
  targetPkgs = pkgs: [
    pkgs.libsForQt5.kwindowsystem
    pkgs.libsForQt5.qt5.qtdeclarative
    pkgs.libsForQt5.qt5.qtbase
    pkgs.libsForQt5.qt5.qtx11extras

    pkgs.libsForQt5.qt5.qtquickcontrols2
    (pkgs.callPackage ./fishui.nix { })
    pkgs.libsForQt5.qt5.qtgraphicaleffects
  ];
}
