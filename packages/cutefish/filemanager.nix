{ pkgs, ... }:
let
  cutefish-filemanager = pkgs.stdenv.mkDerivation rec {
    name = "cutefish-filemanager";
    version = "0.2-1";

    src = pkgs.fetchurl {
      url = "https://mirror.pseudoform.org/community/os/x86_64/${name}-${version}-x86_64.pkg.tar.zst";
      sha256 = "sha256-DOT7bSvn+YY85h587B1rNTPCl3ajGynVzekiu4Kgilg=";
    };

    installPhase = "mkdir $out && cp -r bin share $out";
    nativeBuildInputs = [ pkgs.autoPatchelfHook ];
    buildInputs = [
      pkgs.zstd
      pkgs.libsForQt5.wrapQtAppsHook
      pkgs.libsForQt5.kio
    ];
  };
in
pkgs.buildFHSUserEnv {
  name = cutefish-filemanager.name;
  runScript = "${cutefish-filemanager.out}/bin/cutefish-filemanager";
  targetPkgs = pkgs: [
    pkgs.libsForQt5.qt5.qtquickcontrols2
    (pkgs.callPackage ./fishui.nix { })
    pkgs.libsForQt5.qt5.qtgraphicaleffects
    pkgs.libsForQt5.kinit
  ];
}
