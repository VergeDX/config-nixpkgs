{ pkgs, ... }:
let
  cutefish-statusbar = pkgs.stdenv.mkDerivation rec {
    name = "cutefish-statusbar";
    version = "0.2-1";

    src = pkgs.fetchurl {
      url = "https://mirror.pseudoform.org/community/os/x86_64/${name}-${version}-x86_64.pkg.tar.zst";
      sha256 = "sha256-FEzirQC3dxuOb6ipYhEspPQRJ+hM15ipauPN0i6iLbw=";
    };

    installPhase = "mkdir $out && cp -r bin share $out";
    nativeBuildInputs = [ pkgs.autoPatchelfHook pkgs.libsForQt5.wrapQtAppsHook ];
    buildInputs = [
      pkgs.zstd
      pkgs.libsForQt5.kwindowsystem

      pkgs.libsForQt5.qt5.qtquickcontrols2
      (pkgs.callPackage ./fishui.nix { })
      pkgs.libsForQt5.qt5.qtgraphicaleffects
      (pkgs.callPackage ./libcutefish.nix { })
    ];
  };
in
cutefish-statusbar
