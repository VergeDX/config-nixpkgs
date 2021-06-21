{ pkgs, ... }:
let
  cutefish-calculator = pkgs.stdenv.mkDerivation rec {
    name = "cutefish-calculator";
    version = "0.1-2";

    src = pkgs.fetchurl {
      url = "https://mirror.pseudoform.org/community/os/x86_64/${name}-${version}-x86_64.pkg.tar.zst";
      sha256 = "sha256-DaBFKRQFvyz6XKgfRpTBx6MZGHB1cvq6vhqCnr4Z8YE=";
    };

    installPhase = "mkdir $out && cp -r bin share $out";
    nativeBuildInputs = [ pkgs.autoPatchelfHook ];
    buildInputs = [
      pkgs.zstd
      pkgs.libsForQt5.wrapQtAppsHook
      pkgs.libsForQt5.kwindowsystem
    ];
  };
in
pkgs.buildFHSUserEnv {
  name = cutefish-calculator.name;
  runScript = "${cutefish-calculator.out}/bin/cutefish-calculator";
  targetPkgs = pkgs: [
    pkgs.libsForQt5.qt5.qtquickcontrols2
    (pkgs.callPackage ./fishui.nix { })
    pkgs.libsForQt5.qt5.qtgraphicaleffects
  ];
}
